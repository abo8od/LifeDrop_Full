using Core.Common;
using Core.Common.Errors;
using Core.Entities;
using Core.Enums;
using Services.Interfaces;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Services.Abstractions.Persistence;
using Microsoft.Extensions.Logging;

namespace Services.Features.Auth.Bootstrap;

public class BootstrapCommandHandler : IRequestHandler<BootstrapCommand, Result<BootstrapResult>>
{
    private readonly IUnitOfWork _unitOfWork;
    private readonly IPasswordHasher _passwordHasher;
    private readonly IConfiguration _configuration;
    private readonly ILogger<BootstrapCommandHandler> _logger;

    public BootstrapCommandHandler(IUnitOfWork unitOfWork, IPasswordHasher passwordHasher, IConfiguration configuration, ILogger<BootstrapCommandHandler> logger)
    {
        _unitOfWork = unitOfWork;
        _passwordHasher = passwordHasher;
        _configuration = configuration;
        _logger = logger;
    }

    public async Task<Result<BootstrapResult>> Handle(BootstrapCommand request, CancellationToken cancellationToken)
    {
        var bootstrapSecret = _configuration["BootstrapSecret"];
        if (string.IsNullOrEmpty(bootstrapSecret) || request.BootstrapSecret != bootstrapSecret)
        {
            _logger.LogWarning("Bootstrap failed: invalid bootstrap secret.");
            return Result<BootstrapResult>.Failure(AuthenticationErrors.BootstrapInvalidSecret);
        }

        var existingAdmin = await _unitOfWork.Users
            .Query()
            .FirstOrDefaultAsync(u => u.Role == Role.SystemAdmin, cancellationToken);

        if (existingAdmin != null)
        {
            _logger.LogWarning("Bootstrap failed: system admin already exists.");
            return Result<BootstrapResult>.Failure(AuthenticationErrors.BootstrapAlreadyExists);
        }

        var user = new User
        {
            FirstName = "System",
            LastName = "Admin",
            Email = request.Email,
            PasswordHash = _passwordHasher.HashPassword(request.Password),
            Role = Role.SystemAdmin,
            IsActive = true
        };

        await _unitOfWork.Users.AddAsync(user);
        await _unitOfWork.SaveChangesAsync(cancellationToken);

        _logger.LogInformation("System admin bootstrapped successfully with email {Email}.", request.Email);

        return Result<BootstrapResult>.Success(new BootstrapResult("System admin created successfully."));
    }
}
