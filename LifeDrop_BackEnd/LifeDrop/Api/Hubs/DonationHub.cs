using System.Security.Claims;
using Core.Enums;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.SignalR;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Caching.Memory;
using Services.Abstractions.Persistence;
using Shared.Notifications;

namespace Api.Hubs;

/// <summary>
/// SignalR Hub for real-time donation notifications.
/// Donors connect to this hub to receive notifications about new compatible donation requests.
/// </summary>
[Authorize]
public class DonationHub : Hub
{
    private readonly IUnitOfWork _unitOfWork;
    private readonly IHubContext<DonationHub> _hubContext;
    private readonly IMemoryCache _cache;

    private static readonly TimeSpan GroupInfoCacheTtl = TimeSpan.FromMinutes(5);

    private sealed record DonorGroupInfo(
        Guid? GovernorateId,
        BloodType? BloodType,
        bool ReceiveCritical,
        bool ReceiveUrgent,
        bool ReceiveNormal);

    public DonationHub(IUnitOfWork unitOfWork, IHubContext<DonationHub> hubContext, IMemoryCache cache)
    {
        _unitOfWork = unitOfWork;
        _hubContext = hubContext;
        _cache = cache;
    }

    /// <summary>
    /// Forces a refresh of the donor's SignalR groups based on their current profile.
    /// Useful when the donor updates their location or blood type.
    /// </summary>
    public async Task RefreshGroups()
    {
        var userId = GetUserId();
        if (userId == Guid.Empty) return;

        _cache.Remove(GroupCacheKey(userId));
        await LeaveGroupsInternal(userId);
        await JoinGroupsInternal(userId);
    }

    public override async Task OnConnectedAsync()
    {
        var hospitalId = GetHospitalId();
        if (hospitalId.HasValue)
            await Groups.AddToGroupAsync(Context.ConnectionId, $"Hospital_{hospitalId.Value}");
        else
            await JoinGroupsInternal(GetUserId());

        await base.OnConnectedAsync();
    }

    public override async Task OnDisconnectedAsync(Exception? exception)
    {
        var hospitalId = GetHospitalId();
        if (hospitalId.HasValue)
            await Groups.RemoveFromGroupAsync(Context.ConnectionId, $"Hospital_{hospitalId.Value}");
        else
            await LeaveGroupsInternal(GetUserId());

        await base.OnDisconnectedAsync(exception);
    }

    private async Task JoinGroupsInternal(Guid userId)
    {
        if (userId == Guid.Empty) return;
        var info = await GetGroupInfoAsync(userId);
        if (info == null) return;

        foreach (var group in BuildGroups(info))
            await Groups.AddToGroupAsync(Context.ConnectionId, group);
    }

    private async Task LeaveGroupsInternal(Guid userId)
    {
        if (userId == Guid.Empty) return;
        var info = await GetGroupInfoAsync(userId);
        if (info == null) return;

        foreach (var group in BuildGroups(info))
            await Groups.RemoveFromGroupAsync(Context.ConnectionId, group);
    }

    private async Task<DonorGroupInfo?> GetGroupInfoAsync(Guid userId)
    {
        var key = GroupCacheKey(userId);
        if (_cache.TryGetValue(key, out DonorGroupInfo? cached))
            return cached;

        var profile = await _unitOfWork.DonorProfiles
            .Query()
            .AsNoTracking()
            .Where(d => d.UserId == userId)
            .Select(d => new DonorGroupInfo(
                d.GovernorateId,
                d.BloodType,
                d.ReceiveCriticalNotifications,
                d.ReceiveUrgentNotifications,
                d.ReceiveNormalNotifications))
            .FirstOrDefaultAsync();

        if (profile == null || !profile.BloodType.HasValue) return null;

        _cache.Set(key, profile, GroupInfoCacheTtl);
        return profile;
    }

    private static IEnumerable<string> BuildGroups(DonorGroupInfo info)
    {
        if (!info.BloodType.HasValue) yield break;
        var govId = info.GovernorateId?.ToString() ?? "Unknown";
        var baseGroup = $"Gov_{govId}_Blood_{info.BloodType.Value}";
        if (info.ReceiveCritical) yield return $"{baseGroup}_{UrgencyLevel.Critical}";
        if (info.ReceiveUrgent)   yield return $"{baseGroup}_{UrgencyLevel.Urgent}";
        if (info.ReceiveNormal)   yield return $"{baseGroup}_{UrgencyLevel.Normal}";
    }

    private static string GroupCacheKey(Guid userId) => $"hub:donor_groups:{userId}";

    private Guid GetUserId()
    {
        var userIdClaim = Context.User?.FindFirst(ClaimTypes.NameIdentifier)?.Value;
        return Guid.TryParse(userIdClaim, out var userId) ? userId : Guid.Empty;
    }

    private Guid? GetHospitalId()
    {
        var claim = Context.User?.FindFirst("hospitalId")?.Value;
        return Guid.TryParse(claim, out var hospitalId) ? hospitalId : null;
    }

    /// <summary>
    /// Get the current user's groups for debugging purposes.
    /// </summary>
    public async Task<IEnumerable<string>> GetMyGroups()
    {
        var userId = GetUserId();
        if (userId == Guid.Empty) return Enumerable.Empty<string>();
        var info = await GetGroupInfoAsync(userId);
        return info == null ? Enumerable.Empty<string>() : BuildGroups(info);
    }
}