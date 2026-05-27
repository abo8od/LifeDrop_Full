using Core.Entities;
using Infrastructure.Data;
using Infrastructure.Repositories;
using Microsoft.EntityFrameworkCore.Storage;
using Services.Abstractions.Persistence;

namespace Infrastructure;

public class UnitOfWork : IUnitOfWork
{
    private readonly AppDbContext _context;
    private IDbContextTransaction? _transaction;
    private bool _disposed;

    public UnitOfWork(AppDbContext context)
    {
        _context = context;
    }

    private IGenericRepository<User>? _users;
    public IGenericRepository<User> Users => _users ??= new GenericRepository<User>(_context);

    private IGenericRepository<Hospital>? _hospitals;
    public IGenericRepository<Hospital> Hospitals => _hospitals ??= new GenericRepository<Hospital>(_context);

    private IGenericRepository<DonorProfile>? _donorProfiles;
    public IGenericRepository<DonorProfile> DonorProfiles => _donorProfiles ??= new GenericRepository<DonorProfile>(_context);

    private IGenericRepository<HospitalEmployeeProfile>? _hospitalEmployeeProfiles;
    public IGenericRepository<HospitalEmployeeProfile> HospitalEmployeeProfiles => _hospitalEmployeeProfiles ??= new GenericRepository<HospitalEmployeeProfile>(_context);

    private IGenericRepository<RefreshToken>? _refreshTokens;
    public IGenericRepository<RefreshToken> RefreshTokens => _refreshTokens ??= new GenericRepository<RefreshToken>(_context);

    private IGenericRepository<Governorate>? _governorates;
    public IGenericRepository<Governorate> Governorates => _governorates ??= new GenericRepository<Governorate>(_context);

    private IGenericRepository<District>? _districts;
    public IGenericRepository<District> Districts => _districts ??= new GenericRepository<District>(_context);

    private IGenericRepository<DonationRequest>? _donationRequests;
    public IGenericRepository<DonationRequest> DonationRequests => _donationRequests ??= new GenericRepository<DonationRequest>(_context);

    private IGenericRepository<DonationAcceptance>? _donationAcceptances;
    public IGenericRepository<DonationAcceptance> DonationAcceptances => _donationAcceptances ??= new GenericRepository<DonationAcceptance>(_context);

    private IGenericRepository<CancellationReason>? _cancellationReasons;
    public IGenericRepository<CancellationReason> CancellationReasons => _cancellationReasons ??= new GenericRepository<CancellationReason>(_context);

    private IGenericRepository<OtpCode>? _otpCodes;
    public IGenericRepository<OtpCode> OtpCodes => _otpCodes ??= new GenericRepository<OtpCode>(_context);

    private IGenericRepository<PointTransaction>? _pointTransactions;
    public IGenericRepository<PointTransaction> PointTransactions => _pointTransactions ??= new GenericRepository<PointTransaction>(_context);

    private IGenericRepository<PendingRegistration>? _pendingRegistrations;
    public IGenericRepository<PendingRegistration> PendingRegistrations => _pendingRegistrations ??= new GenericRepository<PendingRegistration>(_context);

    private IGenericRepository<IdempotentRequest>? _idempotentRequests;
    public IGenericRepository<IdempotentRequest> IdempotentRequests => _idempotentRequests ??= new GenericRepository<IdempotentRequest>(_context);

    private IGenericRepository<DeviceToken>? _deviceTokens;
    public IGenericRepository<DeviceToken> DeviceTokens => _deviceTokens ??= new GenericRepository<DeviceToken>(_context);

    public async Task<int> SaveChangesAsync(CancellationToken cancellationToken = default)
    {
        // Domain events are now captured by ConvertDomainEventsToOutboxMessagesInterceptor
        // and dispatched by ProcessOutboxMessagesWorker (Outbox Pattern).
        return await _context.SaveChangesAsync(cancellationToken);
    }

    public async Task BeginTransactionAsync()
    {
        _transaction = await _context.Database.BeginTransactionAsync();
    }

    public async Task CommitTransactionAsync()
    {
        if (_transaction == null)
            throw new InvalidOperationException("Transaction not started. Call BeginTransactionAsync first.");

        try
        {
            await SaveChangesAsync();
            await _transaction.CommitAsync();
        }
        catch
        {
            await RollbackTransactionAsync();
            throw;
        }
        finally
        {
            await _transaction.DisposeAsync();
            _transaction = null;
        }
    }

    public async Task RollbackTransactionAsync()
    {
        if (_transaction != null)
        {
            await _transaction.RollbackAsync();
            await _transaction.DisposeAsync();
            _transaction = null;
        }
    }

    public void Dispose()
    {
        Dispose(true);
        GC.SuppressFinalize(this);
    }

    public async ValueTask DisposeAsync()
    {
        await DisposeAsyncCore();
        Dispose(false);
        GC.SuppressFinalize(this);
    }

    protected virtual void Dispose(bool disposing)
    {
        if (_disposed)
        {
            return;
        }

        if (disposing)
        {
            _transaction?.Dispose();
            _transaction = null;
            _context.Dispose();
        }

        _disposed = true;
    }

    protected virtual async ValueTask DisposeAsyncCore()
    {
        if (_disposed)
        {
            return;
        }

        if (_transaction is not null)
        {
            await _transaction.DisposeAsync();
            _transaction = null;
        }

        await _context.DisposeAsync();
        _disposed = true;
    }
}
