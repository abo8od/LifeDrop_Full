using Core.Entities;

namespace Services.Abstractions.Persistence;

public interface IUnitOfWork : IDisposable, IAsyncDisposable
{
    IGenericRepository<User> Users { get; }
    IGenericRepository<Hospital> Hospitals { get; }
    IGenericRepository<DonorProfile> DonorProfiles { get; }
    IGenericRepository<HospitalEmployeeProfile> HospitalEmployeeProfiles { get; }
    IGenericRepository<RefreshToken> RefreshTokens { get; }
    IGenericRepository<Governorate> Governorates { get; }
    IGenericRepository<District> Districts { get; }
    IGenericRepository<DonationRequest> DonationRequests { get; }
    IGenericRepository<DonationAcceptance> DonationAcceptances { get; }
    IGenericRepository<CancellationReason> CancellationReasons { get; }
    IGenericRepository<OtpCode> OtpCodes { get; }
    IGenericRepository<PointTransaction> PointTransactions { get; }
    IGenericRepository<PendingRegistration> PendingRegistrations { get; }
    IGenericRepository<IdempotentRequest> IdempotentRequests { get; }
    IGenericRepository<DeviceToken> DeviceTokens { get; }
    Task<int> SaveChangesAsync(CancellationToken cancellationToken = default);
    Task BeginTransactionAsync();
    Task CommitTransactionAsync();
    Task RollbackTransactionAsync();
}