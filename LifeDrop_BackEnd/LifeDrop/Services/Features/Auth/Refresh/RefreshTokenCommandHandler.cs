using Core.Common;
using Core.Common.Errors;
using Core.Entities;
using Services.Interfaces;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Services.Abstractions.Persistence;
using Services.Features.Auth;
using Microsoft.Extensions.Logging;

namespace Services.Features.Auth.Refresh;

public class RefreshTokenCommandHandler : IRequestHandler<RefreshTokenCommand, Result<AuthResponse>>
{
    private readonly IUnitOfWork _unitOfWork;
    private readonly IJwtTokenGenerator _jwtTokenGenerator;
    private readonly ILogger<RefreshTokenCommandHandler> _logger;

    public RefreshTokenCommandHandler(
        IUnitOfWork unitOfWork,
        IJwtTokenGenerator jwtTokenGenerator,
        ILogger<RefreshTokenCommandHandler> logger)
    {
        _unitOfWork = unitOfWork;
        _jwtTokenGenerator = jwtTokenGenerator;
        _logger = logger;
    }

    public async Task<Result<AuthResponse>> Handle(RefreshTokenCommand request, CancellationToken cancellationToken)
    {
        var hashedToken = _jwtTokenGenerator.HashRefreshToken(request.RefreshToken);

        var refreshToken = await _unitOfWork.RefreshTokens
            .Query()
            .Include(rt => rt.User)
            .ThenInclude(u => u.HospitalEmployeeProfile)
            .FirstOrDefaultAsync(rt => rt.Token == hashedToken, cancellationToken);

        if (refreshToken == null)
        {
            _logger.LogWarning("Token refresh failed: token not found.");
            return Result<AuthResponse>.Failure(AuthenticationErrors.InvalidToken);
        }

        if (refreshToken.ExpiryDate < DateTime.UtcNow)
        {
            _logger.LogWarning("Token refresh failed: token expired for user {UserId}.", refreshToken.UserId);
            return Result<AuthResponse>.Failure(AuthenticationErrors.ExpiredToken);
        }

        if (refreshToken.IsUsed)
        {
            _logger.LogWarning("Token refresh failed: token already used for user {UserId}.", refreshToken.UserId);
            return Result<AuthResponse>.Failure(AuthenticationErrors.TokenAlreadyUsed);
        }

        if (refreshToken.IsRevoked)
        {
            _logger.LogWarning("Token refresh failed: token revoked for user {UserId}.", refreshToken.UserId);
            return Result<AuthResponse>.Failure(AuthenticationErrors.TokenRevoked);
        }

        var user = refreshToken.User;
        if (user == null || !user.IsActive)
        {
            _logger.LogWarning("Token refresh failed: user {UserId} is inactive.", refreshToken.UserId);
            return Result<AuthResponse>.Failure(UserErrors.InactiveUser);
        }

        refreshToken.IsUsed = true;
        _unitOfWork.RefreshTokens.Update(refreshToken);

        var role = user.Role.ToString();
        var hospitalId = user.HospitalEmployeeProfile?.HospitalId;

        var tokenPair = _jwtTokenGenerator.CreateTokenPair(user, role, hospitalId);
        var newHashedRefreshToken = _jwtTokenGenerator.HashRefreshToken(tokenPair.RefreshToken);

        var newRefreshToken = new RefreshToken
        {
            Token = newHashedRefreshToken,
            UserId = user.Id,
            JwtId = Guid.NewGuid(),
            CreationDate = DateTime.UtcNow,
            ExpiryDate = tokenPair.RefreshTokenExpiresAt,
            IsUsed = false,
            IsRevoked = false
        };

        await _unitOfWork.RefreshTokens.AddAsync(newRefreshToken);
        await _unitOfWork.SaveChangesAsync(cancellationToken);

        _logger.LogInformation("Token refreshed successfully for user {UserId}.", user.Id);

        return Result<AuthResponse>.Success(new AuthResponse(tokenPair.AccessToken, tokenPair.RefreshToken));
    }
}