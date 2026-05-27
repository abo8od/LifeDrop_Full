using Core.Enums;

namespace Core.Helpers;

/// <summary>
/// Provides blood type compatibility rules for donation matching.
/// Uses the universal donor/receiver matrix to determine which blood types can donate to which.
/// </summary>
public static class BloodCompatibilityHelper
{
    /// <summary>
    /// Gets all blood types that the donor can donate to (compatible recipients).
    /// </summary>
    /// <param name="donorBloodType">The blood type of the donor.</param>
    /// <returns>A list of blood types that can receive blood from this donor.</returns>
    public static IEnumerable<BloodType> GetCompatibleRecipientBloodTypes(this BloodType donorBloodType)
    {
        return donorBloodType switch
        {
            // O- (Universal Donor): Can donate to all blood types
            BloodType.O_Negative => Enum.GetValues<BloodType>(),

            // O+: Can donate to O+, A+, B+, AB+
            BloodType.O_Positive => new[]
            {
                BloodType.O_Positive,
                BloodType.A_Positive,
                BloodType.B_Positive,
                BloodType.AB_Positive
            },

            // A-: Can donate to A-, A+, AB-, AB+
            BloodType.A_Negative => new[]
            {
                BloodType.A_Negative,
                BloodType.A_Positive,
                BloodType.AB_Negative,
                BloodType.AB_Positive
            },

            // A+: Can donate to A+, AB+
            BloodType.A_Positive => new[]
            {
                BloodType.A_Positive,
                BloodType.AB_Positive
            },

            // B-: Can donate to B-, B+, AB-, AB+
            BloodType.B_Negative => new[]
            {
                BloodType.B_Negative,
                BloodType.B_Positive,
                BloodType.AB_Negative,
                BloodType.AB_Positive
            },

            // B+: Can donate to B+, AB+
            BloodType.B_Positive => new[]
            {
                BloodType.B_Positive,
                BloodType.AB_Positive
            },

            // AB-: Can donate to AB-, AB+
            BloodType.AB_Negative => new[]
            {
                BloodType.AB_Negative,
                BloodType.AB_Positive
            },

            // AB+ (Universal Recipient as donor): Can only donate to AB+
            BloodType.AB_Positive => new[]
            {
                BloodType.AB_Positive
            },

            _ => Array.Empty<BloodType>()
        };
    }

    /// <summary>
    /// Checks if a donor can donate to a specific recipient blood type.
    /// </summary>
    /// <param name="donorBloodType">The donor's blood type.</param>
    /// <param name="recipientBloodType">The recipient's blood type.</param>
    /// <returns>True if compatible, otherwise false.</returns>
    public static bool CanDonateTo(this BloodType donorBloodType, BloodType recipientBloodType)
    {
        return GetCompatibleRecipientBloodTypes(donorBloodType).Contains(recipientBloodType);
    }

    /// <summary>
    /// Gets all blood types that can donate to a specific recipient blood type.
    /// This is the reverse of GetCompatibleRecipientBloodTypes.
    /// </summary>
    /// <param name="recipientBloodType">The blood type of the recipient (the hospital's request).</param>
    /// <returns>A list of compatible donor blood types.</returns>
    public static IEnumerable<BloodType> GetCompatibleDonorBloodTypes(this BloodType recipientBloodType)
    {
        return recipientBloodType switch
        {
            // O- recipient: only O- can donate (universal recipient)
            BloodType.O_Negative => new[]
            {
                BloodType.O_Negative
            },

            // O+ recipient: O+ and O- can donate
            BloodType.O_Positive => new[]
            {
                BloodType.O_Positive,
                BloodType.O_Negative
            },

            // A- recipient: A- and O- can donate
            BloodType.A_Negative => new[]
            {
                BloodType.A_Negative,
                BloodType.O_Negative
            },

            // A+ recipient: A+, A-, O+, O- can donate
            BloodType.A_Positive => new[]
            {
                BloodType.A_Positive,
                BloodType.A_Negative,
                BloodType.O_Positive,
                BloodType.O_Negative
            },

            // B- recipient: B- and O- can donate
            BloodType.B_Negative => new[]
            {
                BloodType.B_Negative,
                BloodType.O_Negative
            },

            // B+ recipient: B+, B-, O+, O- can donate
            BloodType.B_Positive => new[]
            {
                BloodType.B_Positive,
                BloodType.B_Negative,
                BloodType.O_Positive,
                BloodType.O_Negative
            },

            // AB- recipient: AB- and O- can donate (universal recipient for Rh-)
            BloodType.AB_Negative => new[]
            {
                BloodType.AB_Negative,
                BloodType.A_Negative,
                BloodType.B_Negative,
                BloodType.O_Negative
            },

            // AB+ recipient (Universal Recipient): Everyone can donate to AB+
            BloodType.AB_Positive => Enum.GetValues<BloodType>(),

            _ => Array.Empty<BloodType>()
        };
    }
}