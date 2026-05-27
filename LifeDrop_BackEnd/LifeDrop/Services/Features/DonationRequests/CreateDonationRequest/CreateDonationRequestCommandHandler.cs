using Core.Common;
using Core.Common.Errors;
using Core.Entities;
using Core.Enums;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Services.Abstractions.Persistence;
using Services.Features.DonationRequests.Events;
using Services.Interfaces;
using Microsoft.Extensions.Logging;

using Microsoft.Extensions.Caching.Hybrid;

namespace Services.Features.DonationRequests.CreateDonationRequest;

public class CreateDonationRequestCommandHandler : IRequestHandler<CreateDonationRequestCommand, Result<CreateDonationRequestResult>>
{
    private readonly IUnitOfWork _unitOfWork;
    private readonly ICurrentUserService _currentUserService;
    private readonly IMediator _mediator;
    private readonly HybridCache _cache;
    private readonly ILogger<CreateDonationRequestCommandHandler> _logger;

    public CreateDonationRequestCommandHandler(
        IUnitOfWork unitOfWork, 
        ICurrentUserService currentUserService,
        IMediator mediator,
        HybridCache cache,
        ILogger<CreateDonationRequestCommandHandler> logger)
    {
        _unitOfWork = unitOfWork;
        _currentUserService = currentUserService;
        _mediator = mediator;
        _cache = cache;
        _logger = logger;
    }

    public async Task<Result<CreateDonationRequestResult>> Handle(CreateDonationRequestCommand request, CancellationToken cancellationToken)
    {
        var hospital = await _unitOfWork.Hospitals
            .Query()
            .FirstOrDefaultAsync(h => h.Id == request.HospitalId, cancellationToken);

        if (hospital == null)
        {
            _logger.LogWarning("Donation request creation failed: hospital {HospitalId} not found.", request.HospitalId);
            return Result<CreateDonationRequestResult>.Failure(HospitalErrors.NotFound);
        }

        // Verify the hospital employee belongs to this hospital (Security Check)
        if (_currentUserService.HospitalId.HasValue && _currentUserService.HospitalId != request.HospitalId)
        {
            _logger.LogWarning("Donation request creation failed: employee hospital mismatch for hospital {HospitalId}.", request.HospitalId);
            return Result<CreateDonationRequestResult>.Failure(HospitalErrors.HospitalMismatch);
        }

        var expiryDate = request.ExpiryDate.HasValue
            ? DateTime.SpecifyKind(request.ExpiryDate.Value, DateTimeKind.Utc)
            : DateTime.UtcNow.AddHours(24); // Default 24 hours, ensure UTC for PostgreSQL

        var districtIds = request.TargetDistrictIds ?? new List<Guid>();

        // Smart Restriction: Target Districts Validation
        if (request.Urgency == UrgencyLevel.Normal && districtIds.Count > 0)
        {
            var targetGovernoratesCount = await _unitOfWork.Districts.Query()
                .Where(d => districtIds.Contains(d.Id))
                .Select(d => d.GovernorateId)
                .Distinct()
                .CountAsync(cancellationToken);

            if (targetGovernoratesCount > 1)
            {
                _logger.LogWarning("Donation request creation failed: multi-governorate targeting for normal urgency.");
                return Result<CreateDonationRequestResult>.Failure(DonationErrors.MultipleGovernoratesNotAllowed);
            }
        }

        var donationRequest = new DonationRequest
        {
            HospitalId = request.HospitalId,
            CreatedByUserId = _currentUserService.UserId,
            BloodType = request.BloodType,
            TargetQuota = request.TargetQuota,
            CurrentActiveAcceptances = 0,
            CurrentFulfilledAcceptances = 0,
            Urgency = request.Urgency,
            Status = RequestStatus.Active,
            ExpiryDate = expiryDate,
            RequestDistricts = districtIds.Select(districtId => new DonationRequestDistrict
            {
                DistrictId = districtId
            }).ToList()
        };

        await _unitOfWork.DonationRequests.AddAsync(donationRequest);

        // 1. Prepare the notification data — fetch all distinct target governorates
        // so that donors in every targeted governorate receive a notification.
        var targetGovernorates = await _unitOfWork.Districts
            .Query()
            .Include(d => d.Governorate)
            .Where(d => districtIds.Contains(d.Id) && d.GovernorateId != null)
            .Select(d => new { d.GovernorateId, GovernorateName = d.Governorate!.Name })
            .Distinct()
            .ToListAsync(cancellationToken);

        // 2. Add one domain event per governorate (Outbox Pattern)
        // This ensures donors in every targeted governorate receive the SignalR notification.
        foreach (var gov in targetGovernorates.DistinctBy(g => g.GovernorateId))
        {
            donationRequest.AddDomainEvent(new DonationRequestCreatedEvent
            {
                RequestId = donationRequest.Id,
                HospitalName = hospital.Name,
                HospitalId = hospital.Id,
                GovernorateId = gov.GovernorateId,
                GovernorateName = gov.GovernorateName,
                BloodType = request.BloodType,
                Urgency = request.Urgency,
                TargetQuota = request.TargetQuota,
                ExpiryDate = expiryDate
            });
        }

        // 3. Save everything in a single transaction
        await _unitOfWork.SaveChangesAsync(cancellationToken);

        // 4. Invalidate hospital dashboard, profile, and admin stats in parallel
        await Task.WhenAll(
            _cache.RemoveByTagAsync($"dashboard_hospital_{request.HospitalId}", cancellationToken).AsTask(),
            _cache.RemoveByTagAsync($"hospital_{request.HospitalId}", cancellationToken).AsTask(),
            _cache.RemoveByTagAsync($"hospital_requests_{request.HospitalId}", cancellationToken).AsTask(),
            _cache.RemoveByTagAsync("admin_stats", cancellationToken).AsTask()
        );

        _logger.LogInformation("Donation request {RequestId} created by hospital {HospitalId} for blood type {BloodType} with quota {Quota}.",
            donationRequest.Id, request.HospitalId, request.BloodType, request.TargetQuota);

        return Result<CreateDonationRequestResult>.Success(
            new CreateDonationRequestResult(donationRequest.Id, donationRequest.TargetQuota, donationRequest.Status.ToString())
        );
    }
}