using LifeDrop.Services.DTOs;

namespace LifeDrop.Services.Abstractions;

public interface IPdfCertificateGenerator
{
    byte[] Generate(CertificateDataDto data);
}