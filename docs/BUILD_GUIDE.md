# TRUEFAM Contribution Tracker - Build Guide

This guide will help you build the TRUEFAM Contribution Tracker app for Android and iOS platforms.

## 📋 Prerequisites

### Required Software
- **Node.js** (v16 or higher) - [Download](https://nodejs.org/)
- **npm** or **yarn** - Package manager
- **Git** - Version control
- **Expo CLI** - React Native development platform
- **EAS CLI** - Expo Application Services

### For Android Development
- **Android Studio** - Android development environment
- **Java Development Kit (JDK)** - Version 11 or higher
- **Android SDK** - API level 31 or higher

### For iOS Development (macOS only)
- **Xcode** - iOS development environment
- **iOS Simulator** - For testing
- **Apple Developer Account** - For distribution

## 🚀 Quick Start

### 1. Clone and Setup

\`\`\`bash
# Clone the repository
git clone https://github.com/yourusername/truefam-tracker.git
cd truefam-tracker

# Run setup script (recommended)
chmod +x scripts/setup-dev.sh
./scripts/setup-dev.sh

# Or manual setup
npm install
npm install -g @expo/cli eas-cli
\`\`\`

### 2. Configure Environment

\`\`\`bash
# Copy environment template
cp .env.example .env

# Edit .env with your configuration
nano .env
\`\`\`

Required environment variables:
\`\`\`env
GOOGLE_SHEETS_API_KEY=your_api_key
GMAIL_CLIENT_ID=your_client_id
GMAIL_CLIENT_SECRET=your_client_secret
\`\`\`

### 3. Start Development Server

\`\`\`bash
# Start Expo development server
expo start

# Or with specific platform
expo start --android
expo start --ios
\`\`\`

## 🔨 Building APK (Android)

### Method 1: EAS Build (Recommended)

\`\`\`bash
# Login to Expo
eas login

# Configure EAS (first time only)
eas build:configure

# Build production APK
eas build --platform android --profile production

# Build preview APK (for testing)
eas build --platform android --profile preview
\`\`\`

### Method 2: Local Build

\`\`\`bash
# Prebuild the project
expo prebuild --platform android

# Build APK using Gradle
cd android
./gradlew assembleRelease
cd ..

# APK location: android/app/build/outputs/apk/release/app-release.apk
\`\`\`

### Method 3: Using Build Script

\`\`\`bash
# Make script executable
chmod +x scripts/build-apk.sh

# Run build script
./scripts/build-apk.sh
\`\`\`

## 📱 Building for iOS

### EAS Build

\`\`\`bash
# Build for iOS
eas build --platform ios --profile production

# Build for iOS Simulator
eas build --platform ios --profile preview
\`\`\`

### Local Build

\`\`\`bash
# Prebuild the project
expo prebuild --platform ios

# Open in Xcode
open ios/TrueFamTracker.xcworkspace

# Build using Xcode or command line
xcodebuild -workspace ios/TrueFamTracker.xcworkspace \
           -scheme TrueFamTracker \
           -configuration Release \
           -destination generic/platform=iOS \
           archive
\`\`\`

## ⚙️ Build Profiles

### Development Profile
- **Purpose**: Development and debugging
- **Features**: Development client, debugging tools
- **Distribution**: Internal only

\`\`\`json
"development": {
  "developmentClient": true,
  "distribution": "internal"
}
\`\`\`

### Preview Profile
- **Purpose**: Testing and QA
- **Features**: Production-like build, internal distribution
- **Distribution**: Internal testing

\`\`\`json
"preview": {
  "distribution": "internal",
  "android": {
    "buildType": "apk"
  }
}
\`\`\`

### Production Profile
- **Purpose**: App store release
- **Features**: Optimized, signed for distribution
- **Distribution**: App stores

\`\`\`json
"production": {
  "android": {
    "buildType": "apk"
  }
}
\`\`\`

## 🔐 Code Signing

### Android Signing

1. **Generate Keystore**
\`\`\`bash
keytool -genkey -v -keystore truefam-release-key.keystore \
        -alias truefam-key-alias -keyalg RSA -keysize 2048 \
        -validity 10000
\`\`\`

2. **Configure in EAS**
\`\`\`json
{
  "build": {
    "production": {
      "android": {
        "buildType": "apk",
        "credentialsSource": "local"
      }
    }
  }
}
\`\`\`

### iOS Signing

1. **Apple Developer Account**: Required for distribution
2. **Certificates**: Development and distribution certificates
3. **Provisioning Profiles**: App-specific profiles
4. **EAS handles signing automatically** with proper credentials

## 📦 Distribution

### Android Distribution

1. **Google Play Store**
\`\`\`bash
# Build AAB for Play Store
eas build --platform android --profile production

# Submit to Play Store
eas submit --platform android
\`\`\`

2. **Direct APK Distribution**
\`\`\`bash
# Build APK
eas build --platform android --profile production

# Share APK file directly
\`\`\`

### iOS Distribution

1. **App Store**
\`\`\`bash
# Build for App Store
eas build --platform ios --profile production

# Submit to App Store
eas submit --platform ios
\`\`\`

2. **TestFlight**
\`\`\`bash
# Build for TestFlight
eas build --platform ios --profile preview

# Submit to TestFlight
eas submit --platform ios --profile preview
\`\`\`

## 🧪 Testing Builds

### Android Testing

1. **Install APK on Device**
\`\`\`bash
# Enable "Unknown Sources" in Android settings
# Install APK file
adb install truefam-tracker.apk
\`\`\`

2. **Test Key Features**
- SMS permission requests
- Google Sheets integration
- Export functionality
- Background processing

### iOS Testing

1. **TestFlight Distribution**
- Upload to TestFlight
- Invite beta testers
- Collect feedback

2. **Direct Installation**
- Install via Xcode
- Test on physical device
- Verify all permissions

## 🔧 Troubleshooting

### Common Build Issues

1. **Node.js Version**
\`\`\`bash
# Check Node.js version
node --version

# Use Node Version Manager if needed
nvm use 18
\`\`\`

2. **Clear Cache**
\`\`\`bash
# Clear npm cache
npm cache clean --force

# Clear Expo cache
expo r -c

# Clear Metro cache
npx react-native start --reset-cache
\`\`\`

3. **Android Build Issues**
\`\`\`bash
# Clean Android build
cd android
./gradlew clean
cd ..

# Rebuild
expo run:android
\`\`\`

4. **iOS Build Issues**
\`\`\`bash
# Clean iOS build
cd ios
xcodebuild clean
cd ..

# Clear derived data
rm -rf ~/Library/Developer/Xcode/DerivedData

# Rebuild
expo run:ios
\`\`\`

### Permission Issues

1. **Android Permissions**
- Ensure all required permissions are in AndroidManifest.xml
- Test permission requests on different Android versions
- Handle permission denials gracefully

2. **iOS Permissions**
- Add usage descriptions to Info.plist
- Test on different iOS versions
- Handle permission denials gracefully

## 📊 Build Optimization

### Bundle Size Optimization

1. **Analyze Bundle**
\`\`\`bash
# Analyze bundle size
npx react-native-bundle-visualizer
\`\`\`

2. **Remove Unused Dependencies**
\`\`\`bash
# Find unused dependencies
npx depcheck
\`\`\`

3. **Enable Hermes** (Android)
\`\`\`json
{
  "expo": {
    "android": {
      "jsEngine": "hermes"
    }
  }
}
\`\`\`

### Performance Optimization

1. **Enable Proguard** (Android)
\`\`\`json
{
  "expo": {
    "android": {
      "proguardVersion": "7.2.1"
    }
  }
}
\`\`\`

2. **Optimize Images**
- Use WebP format for Android
- Optimize PNG/JPEG sizes
- Use vector icons when possible

## 📈 Monitoring and Analytics

### Build Monitoring

1. **EAS Build Dashboard**
- Monitor build status
- Download build artifacts
- View build logs

2. **GitHub Actions**
- Automated builds on push
- Test automation
- Artifact storage

### App Analytics

1. **Expo Analytics**
- User engagement metrics
- Crash reporting
- Performance monitoring

2. **Custom Analytics**
- Track contribution parsing accuracy
- Monitor export usage
- User behavior analysis

## 🚀 Deployment Automation

### CI/CD Pipeline

\`\`\`yaml
# .github/workflows/deploy.yml
name: Deploy TRUEFAM Tracker

on:
  push:
    tags:
      - 'v*'

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: 18
      - name: Install dependencies
        run: npm ci
      - name: Build and deploy
        run: |
          eas build --platform all --non-interactive
          eas submit --platform all --non-interactive
\`\`\`

### Release Management

1. **Version Bumping**
\`\`\`bash
# Bump version
npm version patch  # or minor, major

# Update app.json version
# Create git tag
# Push to repository
\`\`\`

2. **Release Notes**
- Document new features
- List bug fixes
- Include breaking changes
- Provide upgrade instructions

This build guide provides comprehensive instructions for building and distributing the TRUEFAM Contribution Tracker app across different platforms and environments.
