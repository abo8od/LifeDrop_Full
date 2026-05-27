using Core.Common;
using MediatR;

namespace Services.Features.Hospitals.GetHospitalAnalytics;

public class GetHospitalAnalyticsQuery : IRequest<Result<HospitalAnalyticsDto>>
{
    public Guid HospitalId { get; set; }
}
