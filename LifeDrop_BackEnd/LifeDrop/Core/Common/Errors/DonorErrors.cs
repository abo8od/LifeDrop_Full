using Core.Common;

namespace Core.Common.Errors;

public static class DonorErrors
{
    public static readonly Error NotFound = new(
        "donor.not_found",
        "The donor was not found.",
        ErrorType.NotFound);

    public static readonly Error AlreadyVerified = new(
        "donor.already_verified",
        "The donor has already been verified.",
        ErrorType.Conflict);

    public static readonly Error InvalidBloodType = new(
        "donor.invalid_blood_type",
        "The specified blood type is invalid.",
        ErrorType.Validation);
}