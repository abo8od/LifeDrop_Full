using Core.Common;

namespace Core.Common.Errors;

public static class HospitalErrors
{
    public static readonly Error NotFound = new(
        "hospital.not_found",
        "The hospital was not found.",
        ErrorType.NotFound);

    public static readonly Error DuplicateEmail = new(
        "hospital.duplicate_email",
        "A hospital admin with this email already exists.",
        ErrorType.Conflict);

    public static readonly Error InactiveAccount = new(
        "hospital.inactive_account",
        "Your hospital account is currently suspended. Please contact system administrator.",
        ErrorType.Unauthorized);

    public static readonly Error HospitalMismatch = new(
        "hospital.mismatch",
        "You do not have permission to access or create resources for this hospital.",
        ErrorType.Unauthorized);

    public static readonly Error EmployeeNotFound = new(
        "hospital.employee_not_found",
        "Employee not found in this hospital.",
        ErrorType.NotFound);
}