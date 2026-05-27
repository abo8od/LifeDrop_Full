using Core.Events;
using MediatR;
using Microsoft.Extensions.Logging;

namespace Services.Features.Admin.Hospitals.Events;

public class HospitalCreatedEventHandler : INotificationHandler<HospitalCreatedEvent>
{
    private readonly ILogger<HospitalCreatedEventHandler> _logger;

    public HospitalCreatedEventHandler(ILogger<HospitalCreatedEventHandler> logger)
    {
        _logger = logger;
    }

    public Task Handle(HospitalCreatedEvent notification, CancellationToken cancellationToken)
    {
        _logger.LogInformation("New hospital registered: {HospitalName} ({HospitalId})", 
            notification.Name, notification.HospitalId);
            
        return Task.CompletedTask;
    }
}
