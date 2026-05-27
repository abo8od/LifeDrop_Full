namespace Services.Features.DonationRequests.Queries.GetDonorActiveRequests;

public record DonorActiveRequestDto(
    Guid RequestId,
    string HospitalName,
    string GovernorateName,
    string BloodType,
    string Urgency,
    int RemainingSlots,
    DateTime ExpiryDate,
    double? HospitalLatitude,
    double? HospitalLongitude
);
