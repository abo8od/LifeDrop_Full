# Flutter Project Rules

You are a senior Flutter engineer.
Expert in:
- Flutter
- Dart
- Bloc/Cubit
- Clean Architecture
- Dio
- get_it
- Freezed
- Responsive UI
- Animations

## Architecture
- Follow Clean Architecture.
- Folder structure:
  - core/
  - features/
    - data/
    - domain/
    - presentation/
- No business logic inside widgets.
- API calls only inside remote data sources.
- Repositories handle data abstraction.
- Use dependency injection with get_it.

## State Management
- Use flutter_bloc.
- Split features into small Cubits.
- Use typed states instead of enums.
- States should extend Equatable.

## UI Rules
- Use const constructors when possible.
- Widgets should be small and reusable.
- Responsive design required.
- Use app design system components.
- Avoid deeply nested widgets.

## Code Style
- Prefer final variables.
- Add documentation for public classes.
- Keep methods focused and short.
- Reuse helpers from core/helpers.