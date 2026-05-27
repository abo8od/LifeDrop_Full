namespace LifeDrop.Services.DTOs;

public class CertificateDataDto
{
    public string DonorName { get; set; } = string.Empty;
    public string BloodType { get; set; } = string.Empty;
    public string HospitalName { get; set; } = string.Empty;
    public DateTime Date { get; set; }
    public string CertificateId { get; set; } = string.Empty;
}