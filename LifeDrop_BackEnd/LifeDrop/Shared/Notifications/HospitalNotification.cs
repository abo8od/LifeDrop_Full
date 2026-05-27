namespace Shared.Notifications;

/// <summary>
/// Event: "RequestAccepted" — a donor accepted a hospital's blood request.
/// </summary>
public class RequestAcceptedNotification
{
    public Guid RequestId { get; init; }
    public Guid AcceptanceId { get; init; }
    public string DonorName { get; init; } = string.Empty;
    public string BloodType { get; init; } = string.Empty;
    public string Status { get; init; } = "Accepted";
    public DateTime AcceptedAt { get; init; }
}

/// <summary>
/// Event: "RequestUpdated" — request progress (accepted count / quota) changed.
/// </summary>
public class RequestUpdatedNotification
{
    public Guid RequestId { get; init; }
    public string Status { get; init; } = string.Empty;
    public int FulfilledCount { get; init; }
    public int TargetQuota { get; init; }
    public double DonorProgress { get; init; }
}

/// <summary>
/// Event: "DashboardUpdated" — hospital-level aggregate stats changed.
/// </summary>
public class DashboardUpdatedNotification
{
    public int ActiveRequests { get; init; }
    public int FulfilledRequests { get; init; }
    public int CanceledRequests { get; init; }
    public double CompletionRate { get; init; }
    public int TotalBags { get; init; }
}

/// <summary>
/// Event: "AcceptanceUpdated" — an acceptance record changed status.
/// </summary>
public class AcceptanceUpdatedNotification
{
    public Guid RequestId { get; init; }
    public Guid AcceptanceId { get; init; }
    public string Status { get; init; } = string.Empty;
}
