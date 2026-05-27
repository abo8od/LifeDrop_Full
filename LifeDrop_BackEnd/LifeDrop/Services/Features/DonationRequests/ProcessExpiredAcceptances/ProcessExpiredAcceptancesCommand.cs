using Core.Common;
using MediatR;

namespace Services.Features.DonationRequests.ProcessExpiredAcceptances;

/// <summary>
/// Command to process expired acceptances that have passed the timeout threshold.
/// This is typically invoked by a background worker to handle no-show donors.
/// </summary>
public class ProcessExpiredAcceptancesCommand : IRequest<Result<ProcessExpiredAcceptancesResult>>
{
}

public class ProcessExpiredAcceptancesResult
{
    public int ProcessedCount { get; init; }
    public int PenalizedDonorCount { get; init; }
    public int ReactivatedRequestCount { get; init; }
}