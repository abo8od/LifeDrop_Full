using Core.Common;

namespace Core.Common.Errors;

public static class LocationErrors
{
    public static readonly Error GovernorateNotFound = new(
        "location.governorate_not_found",
        "Selected governorate does not exist.",
        ErrorType.NotFound);

    public static readonly Error DistrictNotFound = new(
        "location.district_not_found",
        "Selected district does not exist.",
        ErrorType.NotFound);
}
