# Patient Dashboard

A Flutter-based patient dashboard application that provides secure access to patient information, medication tracking, and shipment history. Built with clean architecture principles and modern Flutter development practices.

## Features

- 🔐 **Secure Authentication** - User login with email/password validation
- 📊 **Patient Dashboard** - Overview of patient information and status
- 💊 **Medication Tracking** - View current medications and dosages
- 📦 **Shipment History** - Track medication shipments and delivery status
- 🎨 **Modern UI** - Clean, responsive design with gradient themes
- 📱 **Cross-Platform** - Works on iOS, Android, and Web

## Screenshots

_[Screenshots will be added here showing the login page, dashboard, and shipment history screens]_

## Setup Instructions

### Prerequisites

- Flutter SDK (3.7.2 or higher)
- Dart SDK (3.0.0 or higher)
- Android Studio / VS Code with Flutter extensions
- iOS development tools (for iOS builds)
- Git

### Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/your-username/patient_dashboard.git
   cd patient_dashboard
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Run the application**

   ```bash
   # For development
   flutter run

   # For specific platforms
   flutter run -d chrome  # Web
   flutter run -d ios     # iOS Simulator
   flutter run -d android # Android Emulator
   ```

### Development Setup

1. **Code Analysis**

   ```bash
   flutter analyze
   ```

2. **Run Tests**

   ```bash
   flutter test
   ```

3. **Build for Production**

   ```bash
   # Android APK
   flutter build apk --release

   # Android App Bundle
   flutter build appbundle --release

   # iOS
   flutter build ios --release

   # Web
   flutter build web --release
   ```

## Architecture

This project follows **Clean Architecture** principles with **BLoC pattern** for state management. The architecture is organized into layers:

### Project Structure

```
lib/
├── core/
│   ├── injection.dart          # Dependency injection setup
│   └── utils/
│       └── validators.dart     # Shared validation utilities
├── features/
│   ├── auth/                   # Authentication feature
│   │   ├── data/              # Data layer (repositories, datasources)
│   │   ├── domain/            # Business logic layer (entities, usecases)
│   │   └── presentation/      # UI layer (pages, widgets, cubits)
│   ├── dashboard/             # Patient dashboard feature
│   ├── home/                  # Home navigation feature
│   └── shipment_history/      # Shipment tracking feature
└── main.dart                  # App entry point
```

### Architectural Decisions

#### 1. **Clean Architecture**

- **Separation of Concerns**: Clear boundaries between data, domain, and presentation layers
- **Dependency Rule**: Dependencies point inward (presentation → domain → data)
- **Testability**: Each layer can be tested independently

#### 2. **BLoC Pattern with Cubit**

- **State Management**: Using `flutter_bloc` with Cubit for simpler state management
- **Predictable State**: Unidirectional data flow
- **Reactive UI**: UI automatically updates based on state changes

#### 3. **Dependency Injection**

- **GetIt**: Lightweight service locator for dependency injection
- **Lazy Loading**: Services are created only when needed
- **Testability**: Easy to mock dependencies for testing

#### 4. **Navigation**

- **GoRouter**: Declarative routing with deep linking support
- **Route Guards**: Authentication-based route protection
- **Type-Safe**: Compile-time route safety

#### 5. **Form Handling**

- **flutter_form_builder**: Advanced form management with validation
- **Custom Validators**: Reusable validation logic
- **User Experience**: Real-time validation feedback

### Key Dependencies

| Package                   | Purpose              | Version |
| ------------------------- | -------------------- | ------- |
| `flutter_bloc`            | State management     | ^9.1.1  |
| `go_router`               | Navigation           | ^16.0.0 |
| `get_it`                  | Dependency injection | ^8.0.3  |
| `equatable`               | Value equality       | ^2.0.7  |
| `shared_preferences`      | Local storage        | ^2.5.3  |
| `flutter_form_builder`    | Form handling        | ^9.3.1  |
| `form_builder_validators` | Form validation      | ^11.1.2 |

## Development Guidelines

### Code Style

- Follow Flutter's official style guide
- Use `flutter_lints` for consistent code quality
- Write meaningful commit messages

### Testing Strategy

- Unit tests for use cases and repositories
- Widget tests for UI components
- Integration tests for critical user flows

### State Management

- Keep controllers in providers (not UI widgets)
- Use Cubit for simple state management
- Emit states for all UI interactions

## Production Deployment Plan

### 1. CI/CD Workflow

#### GitHub Actions Workflow

```yaml
# .github/workflows/ci-cd.yml
name: CI/CD Pipeline

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: "3.7.2"
      - run: flutter pub get
      - run: flutter analyze
      - run: flutter test
      - run: flutter build apk --release
      - run: flutter build ios --release --no-codesign

  deploy-android:
    needs: test
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/main'
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
      - run: flutter build appbundle --release
      - uses: r0adkll/upload-google-play@v1
        with:
          serviceAccountJsonPlainText: ${{ secrets.GOOGLE_PLAY_SERVICE_ACCOUNT_JSON }}
          packageName: com.example.patient_dashboard
          releaseFiles: build/app/outputs/bundle/release/app-release.aab
          track: production

  deploy-ios:
    needs: test
    runs-on: macos-latest
    if: github.ref == 'refs/heads/main'
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
      - run: flutter build ios --release
      - uses: apple-actions/upload-testflight@v1
        with:
          app-path: build/ios/iphoneos/Runner.app
          api-key: ${{ secrets.APPLE_API_KEY }}
          api-key-id: ${{ secrets.APPLE_API_KEY_ID }}
          api-issuer-id: ${{ secrets.APPLE_ISSUER_ID }}
```

### 2. Automated App Store Submission

#### Android (Google Play)

- **Fastlane Integration**: Automated deployment to Google Play Console
- **Release Tracks**: Internal testing → Alpha → Beta → Production
- **Bundle Signing**: Automated APK/AAB signing with release keystore
- **Metadata Management**: Automated screenshots and store listing updates

#### iOS (App Store)

- **Fastlane Match**: Automated certificate and provisioning profile management
- **TestFlight**: Automated upload to TestFlight for beta testing
- **App Store Connect**: Automated submission to App Store Review
- **Code Signing**: Automated signing with distribution certificates

### 3. CI Secrets Management

#### Required Secrets

```bash
# Android
GOOGLE_PLAY_SERVICE_ACCOUNT_JSON    # Google Play Console service account
ANDROID_KEYSTORE_BASE64            # Release keystore file (base64 encoded)
ANDROID_KEYSTORE_PASSWORD          # Keystore password
ANDROID_KEY_ALIAS                  # Key alias
ANDROID_KEY_PASSWORD               # Key password

# iOS
APPLE_API_KEY                      # App Store Connect API key
APPLE_API_KEY_ID                   # API key identifier
APPLE_ISSUER_ID                    # Team issuer ID
APPLE_DEVELOPER_ACCOUNT            # Apple Developer account email
APPLE_APP_SPECIFIC_PASSWORD        # App-specific password
```

#### Security Best Practices

- **Secret Rotation**: Regular rotation of API keys and certificates
- **Access Control**: Minimal required permissions for service accounts
- **Audit Logging**: Track all deployment activities
- **Environment Separation**: Different secrets for staging/production

#### Deployment Strategy

1. **Staging Environment**: Automated deployment to TestFlight/Internal Testing
2. **Production Deployment**: Manual approval required for App Store/Google Play
3. **Rollback Plan**: Quick rollback capability for critical issues
4. **Monitoring**: Post-deployment monitoring and alerting

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

For support, email support@patientdashboard.com or create an issue in this repository.
