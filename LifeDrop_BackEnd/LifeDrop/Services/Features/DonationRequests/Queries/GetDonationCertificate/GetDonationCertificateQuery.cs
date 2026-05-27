using Core.Common;
using MediatR;
using Services.Interfaces;

namespace Services.Features.DonationRequests.Queries.GetDonationCertificate;

public record GetDonationCertificateQuery(Guid RequestId) : ICachedQuery<Result<byte[]>>
{
    public string CacheKey => $"certificate:{RequestId}";
    public string[] Tags => [$"certificate_{RequestId}"];
    public TimeSpan Expiration => TimeSpan.FromHours(24);
}