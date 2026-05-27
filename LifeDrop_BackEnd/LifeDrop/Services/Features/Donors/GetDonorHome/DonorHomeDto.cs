namespace Services.Features.Donors.GetDonorHome;

public record ActiveRequestSummaryDto(
    Guid RequestId,
    string HospitalName,
    string BloodType,
    string Urgency,
    int RemainingSlots
);

public record DonorHomeDto(
    string Username,
    int RemainingDays,
    string LastHospitalName,
    int TotalContributions,
    IReadOnlyList<ActiveRequestSummaryDto> ActiveRequests
);
