# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

Flutter app (display name "Pocket OMR"), package name `pocket_omr`. Bundle id is still `com.fluttermap.flutter_test_22`. Flutter SDK `^3.11.1`. Targets Android, iOS, web, macOS, Linux, Windows.

## Commands

- Install deps: `flutter pub get`
- Run (default device): `flutter run`
- Run on a specific device: `flutter run -d chrome` / `-d ios` / `-d android`
- Analyze / lint: `flutter analyze` (uses `analysis_options.yaml` → `flutter_lints`)
- Format: `dart format lib test`
- All tests: `flutter test`
- Single test file: `flutter test test/widget_test.dart`
- Single test by name: `flutter test --plain-name "test name"`
- Build release: `flutter build apk` / `flutter build ios` / `flutter build web`

## Architecture

Feature-first layout under `lib/`:

- `lib/main.dart` — real entry point. Wraps `MyApp` in a `MultiProvider` with `AuthProvider`, theme from `AppColors.primaryBlue`, home = `SplashScreen`. `SplashScreen` branches on `AuthProvider.status` to route to login vs. home.
- `lib/app.dart` — **stale/alternate** `App` widget that imports `core/theme/app_theme.dart` (does not exist) and jumps straight to `HomePage`. Not wired into `main()`. Treat as dead code unless intentionally revived; prefer editing `main.dart`.
- `lib/core/` — cross-cutting infra:
  - `network/` — `ApiConstants` (base URL `http://localhost:8000/api/v1`; note comment: use `10.0.2.2` on Android emulator), `DioClient` (Dio with auth interceptor that injects `Bearer` token from `TokenManager`; 401 handling is a TODO), `TokenManager`.
  - `theme/app_colors.dart` — central color palette (`AppColors.primaryBlue`, etc.).
  - `widgets/` — shared primitives (`CurvedHeader`, `CustomButton`, `CustomTextField`, `LogoWidget`, …). Reuse these before inventing new ones.
- `lib/features/<feature>/` — each feature owns `models/`, `providers/`, `screens/` (or `pages/`), `services/`, `widgets/`. Current features: `auth`, `home`, `profile`.
- `lib/shared/widgets/` — widgets shared across features (distinct from `core/widgets`, which are lower-level primitives).

### State management

`provider` + `ChangeNotifier`. The canonical example is `features/auth/providers/auth_provider.dart`: exposes an `AuthStatus` enum (`initial`/`loading`/`authenticated`/`unauthenticated`/`error`) and delegates network work to a `Service` class. New features should follow the **Provider → Service → DioClient** layering — screens call provider methods, providers call services, services call `DioClient`. Don't call Dio directly from widgets.

### Auth flow

`AuthProvider` calls `AuthService`, which uses `DioClient` (auto-attaches bearer token) and persists tokens via `TokenManager`. On startup `_checkAuthStatus()` runs `checkAuth()` → `getProfile()` to hydrate the session; `SplashScreen` reads the resulting status to route.

## Key dependencies

`provider` (state), `dio` (HTTP), `shared_preferences` (token persistence via `TokenManager`), `image_picker`. All declared in `pubspec.yaml`.

## Assets

Registered in `pubspec.yaml` under `flutter/assets` (e.g. `assets/images/quizor_logo.png`, `profile_back.png`, `edit_profile_back.png`). Add new assets there or they won't bundle.
