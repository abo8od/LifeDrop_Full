using Core.Common;
using Core.Entities;
using Core.Events;
using MediatR;
using Microsoft.Extensions.Caching.Hybrid;
using Microsoft.Extensions.Logging;
using Services.Abstractions.Persistence;

namespace Services.Features.Admin.Hospitals.CreateHospital;

public class CreateHospitalCommandHandler : IRequestHandler<CreateHospitalCommand, Result<CreateHospitalResult>>
{
    private readonly IUnitOfWork _unitOfWork;
    private readonly HybridCache _cache;
    private readonly ILogger<CreateHospitalCommandHandler> _logger;

    public CreateHospitalCommandHandler(IUnitOfWork unitOfWork, HybridCache cache, ILogger<CreateHospitalCommandHandler> logger)
    {
        _unitOfWork = unitOfWork;
        _cache = cache;
        _logger = logger;
    }

    public async Task<Result<CreateHospitalResult>> Handle(CreateHospitalCommand request, CancellationToken cancellationToken)
    {
        var hospital = new Hospital
        {
            Name = request.Name,
            Address = request.Address,
            PhoneNumber = request.PhoneNumber,
            Latitude = request.Latitude,
            Longitude = request.Longitude,
            IsVerified = true
        };

        hospital.AddDomainEvent(new HospitalCreatedEvent(hospital.Id, hospital.Name));

        await _unitOfWork.Hospitals.AddAsync(hospital);
        await _unitOfWork.SaveChangesAsync(cancellationToken);

        await _cache.RemoveByTagAsync("admin_hospitals", cancellationToken);

        _logger.LogInformation("Hospital '{HospitalName}' created with ID {HospitalId}.", hospital.Name, hospital.Id);

        return Result<CreateHospitalResult>.Success(new CreateHospitalResult(hospital.Id, hospital.Name));
    }
}
