using Core.Common;

namespace Core.Events;

public record HospitalCreatedEvent(Guid HospitalId, string Name) : IDomainEvent;
