using Core.Common;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Services.Abstractions.Persistence;
using Services.Interfaces;
using Shared.Configuration;

namespace Services.Features.Donors.NotifyEligibleDonors;

public class NotifyEligibleDonorsCommandHandler : IRequestHandler<NotifyEligibleDonorsCommand, Result<NotifyEligibleDonorsResult>>
{
    private readonly IUnitOfWork _unitOfWork;
    private readonly IPushNotificationService _pushNotificationService;
    private readonly DonationSettings _donationSettings;
    private readonly ILogger<NotifyEligibleDonorsCommandHandler> _logger;

    public NotifyEligibleDonorsCommandHandler(
        IUnitOfWork unitOfWork,
        IPushNotificationService pushNotificationService,
        IOptions<DonationSettings> donationSettings,
        ILogger<NotifyEligibleDonorsCommandHandler> logger)
    {
        _unitOfWork = unitOfWork;
        _pushNotificationService = pushNotificationService;
        _donationSettings = donationSettings.Value;
        _logger = logger;
    }

    public async Task<Result<NotifyEligibleDonorsResult>> Handle(
        NotifyEligibleDonorsCommand request,
        CancellationToken cancellationToken)
    {
        var cutoff = DateTimeOffset.UtcNow.AddDays(-_donationSettings.CooldownDays);

        // Find donors whose cooldown just expired and haven't been notified for this donation cycle.
        // EligibilityNotificationSentFor tracks the LastDonationDate value at the time of the last
        // notification — if it differs from the current LastDonationDate, the donor donated again
        // and needs a fresh notification after their new cooldown expires.
        var eligibleDonors = await _unitOfWork.DonorProfiles
            .Query()
            .AsNoTracking()
            .Where(p =>
                p.IsAvailable &&
                p.LastDonationDate.HasValue &&
                p.LastDonationDate.Value <= cutoff &&
                (p.EligibilityNotificationSentFor == null ||
                 p.EligibilityNotificationSentFor < p.LastDonationDate))
            .Select(p => new { p.Id, p.UserId })
            .ToListAsync(cancellationToken);

        if (eligibleDonors.Count == 0)
            return Result<NotifyEligibleDonorsResult>.Success(new NotifyEligibleDonorsResult(0));

        var userIds = eligibleDonors.Select(p => p.UserId).ToList();

        await _pushNotificationService.SendToUsersAsync(
            userIds,
            title: "You can donate again!",
            body: "Your cooldown period has ended. Donors like you save lives — find a request now.",
            data: new Dictionary<string, string> { { "type", "EligibilityRestored" } },
            cancellationToken: cancellationToken);

        // Stamp all matched rows in a single SQL UPDATE using the same predicate
        // to prevent a race condition from leaving any row unstamped.
        var now = DateTimeOffset.UtcNow;
        await _unitOfWork.DonorProfiles
            .Query()
            .Where(p =>
                p.IsAvailable &&
                p.LastDonationDate.HasValue &&
                p.LastDonationDate.Value <= cutoff &&
                (p.EligibilityNotificationSentFor == null ||
                 p.EligibilityNotificationSentFor < p.LastDonationDate))
            .ExecuteUpdateAsync(
                s => s.SetProperty(p => p.EligibilityNotificationSentFor, p => p.LastDonationDate),
                cancellationToken);

        _logger.LogInformation("Eligibility notifications sent to {Count} donors.", eligibleDonors.Count);

        return Result<NotifyEligibleDonorsResult>.Success(new NotifyEligibleDonorsResult(eligibleDonors.Count));
    }
}
