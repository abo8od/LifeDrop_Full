namespace Services.Features.Auth;

public record AuthResponse(string AccessToken, string RefreshToken);