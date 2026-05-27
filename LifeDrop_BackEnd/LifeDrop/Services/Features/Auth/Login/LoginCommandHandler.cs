using Core.Common;
using Core.Common.Errors;
using Core.Entities;
using Services.Interfaces;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Services.Abstractions.Persistence;
using Services.Features.Auth;
using Microsoft.Extensions.Logging;
using Core.Enums;

namespace Services.Features.Auth.Login;

public class LoginCommandHandler : IRequestHandler<LoginCommand, Result<AuthResponse>>
{
    private readonly IUnitOfWork _unitOfWork;
    private readonly IPasswordHasher _passwordHasher;
    private readonly IJwtTokenGenerator _jwtTokenGenerator;
    private readonly LoginPolicy _loginPolicy;
    private readonly ILogger<LoginCommandHandler> _logger;

    public LoginCommandHandler(
        IUnitOfWork unitOfWork,
        IPasswordHasher passwordHasher,
        IJwtTokenGenerator jwtTokenGenerator,
        LoginPolicy loginPolicy,
        ILogger<LoginCommandHandler> logger)
    {
        _unitOfWork = unitOfWork;
        _passwordHasher = passwordHasher;
        _jwtTokenGenerator = jwtTokenGenerator;
        _loginPolicy = loginPolicy;
        _logger = logger;
    }

    public async Task<Result<AuthResponse>> Handle(LoginCommand request, CancellationToken cancellationToken)
    {
        var emailLower = request.Email.ToLower();
        var user = await _unitOfWork.Users
            .Query()
            .AsNoTracking()
            .Include(u => u.HospitalEmployeeProfile)
                .ThenInclude(hep => hep!.Hospital)
            .FirstOrDefaultAsync(u => u.Email == emailLower, cancellationToken);

        if (user == null || !user.IsActive)
        {
            _logger.LogWarning("Login failed: user not found or inactive for email {Email}.", request.Email);
            return Result<AuthResponse>.Failure(AuthenticationErrors.InvalidCredentials);
        }

        if (!user.EmailVerified && user.Role == Role.Donor)
        {
            _logger.LogWarning("Login failed: email not verified for {Email}.", request.Email);
            return Result<AuthResponse>.Failure(UserErrors.NotVerified);
        }

        // BCrypt.Verify is intentionally slow (~100-300ms). Offloading to Task.Run releases
        // the ASP.NET thread pool thread during the CPU-bound hash computation.
        var passwordValid = await Task.Run(
            () => _passwordHasher.VerifyPassword(request.Password, user.PasswordHash),
            cancellationToken);

        if (!passwordValid)
        {
            _logger.LogWarning("Login failed: invalid credentials for {Email}.", request.Email);
            return Result<AuthResponse>.Failure(AuthenticationErrors.InvalidCredentials);
        }

        // Apply business rules via LoginPolicy
        var hospital = user.HospitalEmployeeProfile?.Hospital;
        var policyResult = _loginPolicy.Evaluate(user, hospital);
        if (!policyResult.IsSuccess)
        {
            _logger.LogWarning("Login failed: policy violation for {Email}. Error: {ErrorCode}.", 
                request.Email, policyResult.Error?.Code);
            return Result<AuthResponse>.Failure(policyResult.Error!);
        }

        var role = user.Role.ToString();
        var hospitalId = user.HospitalEmployeeProfile?.HospitalId;

        var tokenPair = _jwtTokenGenerator.CreateTokenPair(user, role, hospitalId);
        var hashedRefreshToken = _jwtTokenGenerator.HashRefreshToken(tokenPair.RefreshToken);

        var refreshToken = new RefreshToken
        {
            Token = hashedRefreshToken,
            UserId = user.Id,
            JwtId = Guid.NewGuid(),
            CreationDate = DateTime.UtcNow,
            ExpiryDate = tokenPair.RefreshTokenExpiresAt,
            IsUsed = false,
            IsRevoked = false
        };

        await _unitOfWork.RefreshTokens.AddAsync(refreshToken);
        await _unitOfWork.SaveChangesAsync(cancellationToken);

        _logger.LogInformation("User {UserId} ({Email}) logged in successfully.", user.Id, user.Email);

        return Result<AuthResponse>.Success(new AuthResponse(tokenPair.AccessToken, tokenPair.RefreshToken));
    }
}