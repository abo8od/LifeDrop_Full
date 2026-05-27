using Core.Entities;

namespace Services.Interfaces;

public interface IJwtTokenGenerator
{
    TokenResponse CreateTokenPair(User user, string role, Guid? hospitalId = null);
    string HashRefreshToken(string refreshToken);
}