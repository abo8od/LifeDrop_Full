using Core.Common;
using Core.Common.Errors;
using Core.Entities;

namespace Services.Features.Auth.Login;

public class LoginPolicy
{
    public Result Evaluate(User user, Hospital? hospital)
    {
        // Rule 1: User must exist (handled by handler, but double-check)
        if (user == null)
        {
            return Result.Failure(AuthenticationErrors.InvalidCredentials);
        }

        // Rule 2: User must be active
        if (!user.IsActive)
        {
            return Result.Failure(AuthenticationErrors.InvalidCredentials);
        }

        // Rule 3: Hospital Admin must have an active hospital
        if (user.Role == Core.Enums.Role.HospitalAdmin || user.Role == Core.Enums.Role.HospitalEmployee)
        {
            if (hospital == null)
            {
                return Result.Failure(HospitalErrors.NotFound);
            }

            // Hospital must be verified/active for hospital staff to login
            if (!hospital.IsVerified)
            {
                return Result.Failure(HospitalErrors.InactiveAccount);
            }
        }

        return Result.Success();
    }
}