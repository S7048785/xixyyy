# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Flutter mobile application for XiXunYun (习讯云) sign-in automation. The app provides user login, automatic sign-in, record viewing, and profile management functionality.

## Common Commands

```bash
# Install dependencies
flutter pub get

# Run the app
flutter run

# Build for Android
flutter build apk

# Build for iOS
flutter build ios

# Run code generation (for drift database)
flutter pub run build_runner build

# Run linter
flutter analyze

# Run tests
flutter test
```

## Architecture

This is a **GetX-based Flutter app** with clean architecture:

- **lib/pages/** - UI pages with GetX controllers (login, sign, record, me, frame)
- **lib/controllers/** - GetX controllers for business logic
- **lib/models/** - Data models (SchoolInfo, SignIn, LoginResponse)
- **lib/services/** - API services (ApiService using Dio)
- **lib/stores/** - GetX state management (UserStore, SignStore)
- **lib/utils/** - Utilities (CryptoUtils for RSA encryption)
- **lib/constants/** - Constants (API endpoints)

### Key Dependencies

- **dio** - HTTP client for API calls
- **get** - State management, routing, and dependency injection
- **shadcn_ui** - UI component library
- **encrypt + pointycastle** - RSA encryption for sign-in location data
- **supabase_flutter** - Backend storage
- **drift_dev** - Database code generation

### API Integration

The app communicates with XiXunYun API. Key points:
- Login requires plaintext password (not encrypted)
- Sign-in requires RSA-encrypted latitude/longitude using the public key in `lib/utils/crypto_util.dart`
- See `dev_guide/FLUTTER_CRYPTO_NOTES.md` for encryption implementation details
