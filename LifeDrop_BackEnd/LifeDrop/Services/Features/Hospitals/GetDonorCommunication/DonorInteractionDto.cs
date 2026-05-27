using System;

namespace Services.Features.Hospitals.GetDonorCommunication;

public record DonorInteractionDto(
    Guid DonorId,
    string FullName,
    string PhoneNumber,
    string BloodType,
    DateTimeOffset? LastInteractionDate,
    int TotalDonationsToHospital,
    string LastStatus,
    bool IsMedicallyVerified
);
