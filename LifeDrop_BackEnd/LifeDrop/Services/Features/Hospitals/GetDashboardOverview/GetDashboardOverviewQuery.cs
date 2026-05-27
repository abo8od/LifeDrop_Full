using Core.Common;
using MediatR;

namespace Services.Features.Hospitals.GetDashboardOverview;

public class GetDashboardOverviewQuery : IRequest<Result<DashboardOverviewDto>>
{
    public Guid HospitalId { get; set; }
}
