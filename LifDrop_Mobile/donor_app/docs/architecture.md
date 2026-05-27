# Project Architecture

This project follows Clean Architecture:

- Presentation:
  - Screens
  - Widgets
  - Cubits

- Domain:
  - Entities
  - Repositories contracts

- Data:
  - Models
  - Remote data sources
  - Repository implementations

Dependency flow:
Presentation -> Domain -> Data