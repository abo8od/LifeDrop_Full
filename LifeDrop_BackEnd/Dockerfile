# Stage 1: Build and publish
FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src

# Copy project files first so restore is cached separately from source changes
# Source paths are prefixed with LifeDrop/ because the build context is the repo root
COPY ["LifeDrop/Api/Api.csproj", "Api/"]
COPY ["LifeDrop/Core/Core.csproj", "Core/"]
COPY ["LifeDrop/Services/Services.csproj", "Services/"]
COPY ["LifeDrop/infrastructure/infrastructure.csproj", "infrastructure/"]
COPY ["LifeDrop/Shared/Shared.csproj", "Shared/"]

RUN dotnet restore "Api/Api.csproj"

# Copy only the solution source — not scripts, docs, or other repo files
COPY LifeDrop/ .

# Publish in Release without AOT
RUN dotnet publish "Api/Api.csproj" \
    -c Release \
    -o /app/publish \
    --no-restore \
    /p:PublishAot=false

# Stage 2: Runtime image
FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS final

WORKDIR /app

# Install required libraries
RUN apt-get update && apt-get install -y \
    libpq5 \
    ca-certificates \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Copy published application
# Use the existing 'app' user (already in aspnet:10.0 image)
COPY --from=build --chown=app:app /app/publish .

# Set user (use existing app user, not creating new one)
USER app

# Environment variables
ENV ASPNETCORE_ENVIRONMENT=Production
ENV ASPNETCORE_URLS=http://+:8080

EXPOSE 8080

# Health check (optional but recommended)
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:8080/health || exit 1

ENTRYPOINT ["dotnet", "Api.dll"]