namespace Api.Extensions;

/// <summary>
/// Centralized mapping of common property names to their documentation descriptions.
/// This ensures consistency between SchemaFilters and OperationFilters.
/// </summary>
public static class SwaggerDocumentationHelper
{
    public static string? GetDescription(string propertyName)
    {
        var name = propertyName.Split('.').Last().ToLower();
        
        return name switch
        {
            "email" => "The user's email address.",
            "password" or "confirmpassword" => "The user's password (min 8 characters).",
            "firstname" => "The user's first name.",
            "lastname" => "The user's last name.",
            "phonenumber" => "Contact phone number (e.g., +962...).",
            "code" => "The 6-digit OTP code.",
            "bloodtype" => "Blood type value (A_Positive, O_Negative, etc.).",
            "targetquota" => "Number of blood bags required.",
            "urgency" => "Request urgency (Normal, Urgent, Critical).",
            "dateofbirth" => "Donor date of birth.",
            "governorateid" => "Governorate unique identifier.",
            "districtid" => "District unique identifier.",
            "requestid" => "Donation request unique identifier.",
            "hospitalid" => "Hospital unique identifier.",
            "acceptanceid" => "Donation acceptance unique identifier.",
            "userid" => "User unique identifier.",
            "token" or "accesstoken" => "JWT access token for authentication.",
            "refreshtoken" => "Token used to obtain a new access token.",
            "status" => "Current status of the entity (e.g., Active, Completed, Cancelled).",
            "pagenumber" => "The page number to retrieve (1-based).",
            "pagesize" => "The number of items per page.",
            "searchterm" or "search" => "Optional search term to filter results.",
            "sortby" or "orderby" or "order_by" or "sort_by" or "sort" or "order" => "Field name to sort the results by (e.g., 'Name', 'Date').",
            "sortdescending" or "descending" => "Whether to sort in descending order.",
            "targetdistrictids" => "List of district IDs targeted by the request.",
            "cancellationreasonid" => "The ID of the reason for cancellation.",
            "note" => "Optional additional details.",
            _ => null
        };
    }
}
