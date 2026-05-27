using Core.Common;

namespace Core.Common.Errors;

public static class DonationErrors
{
    public static readonly Error RequestNotFound = new(
        "donation.request_not_found",
        "Donation request not found.",
        ErrorType.NotFound);

    public static readonly Error RequestNotActive = new(
        "donation.request_not_active",
        "This donation request is no longer active.",
        ErrorType.Conflict);

    public static readonly Error QuotaFull = new(
        "donation.quota_full",
        "The target quota for this donation request has been reached.",
        ErrorType.Conflict);

    public static readonly Error AlreadyAccepted = new(
        "donation.already_accepted",
        "You have already accepted this donation request.",
        ErrorType.Conflict);

    public static readonly Error IncompatibleBloodType = new(
        "donation.incompatible_blood_type",
        "Your blood type is not compatible with the requested blood type.",
        ErrorType.Validation);

    public static readonly Error DonorNotAvailable = new(
        "donation.donor_not_available",
        "You have set your availability to off. Please update your profile to accept requests.",
        ErrorType.Validation);

    public static readonly Error InCooldown = new(
        "donation.in_cooldown",
        "You are in the donation cooldown period. Please wait until you are eligible to donate again.",
        ErrorType.Validation);

    public static Error InCooldownAt(DateTimeOffset nextEligibleDate) => new(
        InCooldown.Code,
        $"You are in the donation cooldown period. You will be eligible on {nextEligibleDate:yyyy-MM-dd}.",
        InCooldown.Type);

    public static readonly Error CriticalRequiresVerification = new(
        "donation.critical_requires_verification",
        "Critical requests are only visible to medically verified donors.",
        ErrorType.Validation);

    public static readonly Error ConcurrencyConflict = new(
        "donation.concurrency_conflict",
        "The quota is now full due to high demand. Please refresh and try another request.",
        ErrorType.Conflict);

    public static readonly Error AcceptanceNotFound = new(
        "donation.acceptance_not_found",
        "Donation acceptance not found for the current user.",
        ErrorType.NotFound);

    public static readonly Error AcceptanceNotAccepted = new(
        "donation.acceptance_not_accepted",
        "This acceptance is not in an active accepted state.",
        ErrorType.Conflict);


    public static readonly Error RequestAlreadyFulfilled = new(
        "donation.request_already_fulfilled",
        "This donation request is already fulfilled.",
        ErrorType.Conflict);

    public static readonly Error CertificateInvalidState = new(
        "donation.certificate_invalid_state",
        "Certificate can only be generated for fulfilled donations.",
        ErrorType.Conflict);

    public static readonly Error BloodTypeNotSet = new(
        "donation.blood_type_not_set",
        "Please set your blood type in your profile to view donation requests.",
        ErrorType.Validation);

    public static readonly Error DonorProfileNotFound = new(
        "donation.donor_profile_not_found",
        "Donor profile not found.",
        ErrorType.NotFound);

    public static readonly Error InvalidCancellationReason = new(
        "donation.invalid_cancellation_reason",
        "Invalid or inactive cancellation reason.",
        ErrorType.Validation);

    public static readonly Error NoActiveAcceptances = new(
        "donation.no_active_acceptances",
        "There are no active acceptances to decrement.",
        ErrorType.Conflict);

    public static readonly Error MultipleGovernoratesNotAllowed = new(
        "donation.multiple_governorates_not_allowed",
        "For normal urgency requests, you can only target districts within a single governorate. Please increase urgency to Urgent or Critical to target multiple governorates.",
        ErrorType.Validation);

    public static readonly Error HasActiveCommitment = new(
        "donation.has_active_commitment",
        "You already have an active donation commitment. Please fulfill or cancel it before accepting another.",
        ErrorType.Conflict);

    public static readonly Error NoActiveDonation = new(
        "donation.no_active_donation",
        "You do not have an active donation at the moment.",
        ErrorType.NotFound);
}
