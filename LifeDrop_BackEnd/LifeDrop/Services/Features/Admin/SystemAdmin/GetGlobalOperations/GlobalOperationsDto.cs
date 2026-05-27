using System.Collections.Generic;

namespace Services.Features.Admin.SystemAdmin.GetGlobalOperations;

public record GovernorateStatDto(string GovernorateName, int RequestCount);

public record GlobalOperationsDto(
    int TotalHospitals,
    int TotalDonors,
    int TotalDonationRequests,
    int TotalBloodBagsCollected,
    List<GovernorateStatDto> RequestsByGovernorate
);
