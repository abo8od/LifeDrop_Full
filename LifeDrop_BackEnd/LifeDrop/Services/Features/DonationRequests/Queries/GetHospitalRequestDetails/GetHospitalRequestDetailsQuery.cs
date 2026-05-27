using Core.Common;
using MediatR;
using Services.Features.DonationRequests.Queries.GetHospitalRequestDetails;

namespace Services.Features.DonationRequests.Queries.GetHospitalRequestDetails;

/// <summary>
/// Query to get detailed information about a specific donation request for the hospital.
/// Includes all acceptances with donor contact information.
/// </summary>
public record GetHospitalRequestDetailsQuery(Guid RequestId) : IRequest<Result<HospitalRequestDetailsDto>>;