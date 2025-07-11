#!/bin/bash

# TRUEFAM Contribution Tracker - APK Build Script
# This script builds a production-ready APK for Android

set -e

echo "🚀 Starting TRUEFAM Contribution Tracker APK Build..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check if required tools are installed
check_requirements() {
    echo -e "${BLUE}📋 Checking requirements...${NC}"
    
    if ! command -v node &> /dev/null; then
        echo -e "${RED}❌ Node.js is not installed${NC}"
        exit 1
    fi
    
    if ! command -v npm &> /dev/null; then
        echo -e "${RED}❌ npm is not installed${NC}"
        exit 1
    fi
    
    if ! command -v expo &> /dev/null; then
        echo -e "${YELLOW}⚠️  Expo CLI not found, installing...${NC}"
        npm install -g @expo/cli
    fi
    
    echo -e "${GREEN}✅ All requirements met${NC}"
}

# Install dependencies
install_dependencies() {
    echo -e "${BLUE}📦 Installing dependencies...${NC}"
    npm install
    echo -e "${GREEN}✅ Dependencies installed${NC}"
}

# Build APK using EAS
build_with_eas() {
    echo -e "${BLUE}🔨 Building APK with EAS Build...${NC}"
    
    # Check if EAS CLI is installed
    if ! command -v eas &> /dev/null; then
        echo -e "${YELLOW}⚠️  EAS CLI not found, installing...${NC}"
        npm install -g eas-cli
    fi
    
    # Login to EAS (if not already logged in)
    echo -e "${BLUE}🔐 Checking EAS authentication...${NC}"
    if ! eas whoami &> /dev/null; then
        echo -e "${YELLOW}⚠️  Please login to EAS:${NC}"
        eas login
    fi
    
    # Configure EAS if not already configured
    if [ ! -f "eas.json" ]; then
        echo -e "${BLUE}⚙️  Configuring EAS...${NC}"
        eas build:configure
    fi
    
    # Build the APK
    echo -e "${BLUE}🏗️  Starting APK build...${NC}"
    eas build --platform android --profile production --non-interactive
    
    echo -e "${GREEN}✅ APK build completed!${NC}"
    echo -e "${BLUE}📱 You can download your APK from the EAS dashboard${NC}"
}

# Build APK locally (alternative method)
build_locally() {
    echo -e "${BLUE}🔨 Building APK locally...${NC}"
    
    # Prebuild the project
    echo -e "${BLUE}⚙️  Prebuilding project...${NC}"
    expo prebuild --platform android
    
    # Build the APK
    echo -e "${BLUE}🏗️  Building APK...${NC}"
    cd android
    ./gradlew assembleRelease
    cd ..
    
    # Copy APK to root directory
    APK_PATH="android/app/build/outputs/apk/release/app-release.apk"
    if [ -f "$APK_PATH" ]; then
        cp "$APK_PATH" "./truefam-tracker-v1.0.0.apk"
        echo -e "${GREEN}✅ APK built successfully!${NC}"
        echo -e "${BLUE}📱 APK location: ./truefam-tracker-v1.0.0.apk${NC}"
    else
        echo -e "${RED}❌ APK build failed${NC}"
        exit 1
    fi
}

# Main execution
main() {
    echo -e "${GREEN}🎯 TRUEFAM Contribution Tracker APK Builder${NC}"
    echo -e "${BLUE}================================================${NC}"
    
    check_requirements
    install_dependencies
    
    # Ask user for build method
    echo -e "${YELLOW}Choose build method:${NC}"
    echo "1) EAS Build (Recommended - Cloud build)"
    echo "2) Local Build (Requires Android SDK)"
    read -p "Enter your choice (1 or 2): " choice
    
    case $choice in
        1)
            build_with_eas
            ;;
        2)
            build_locally
            ;;
        *)
            echo -e "${RED}❌ Invalid choice${NC}"
            exit 1
            ;;
    esac
    
    echo -e "${GREEN}🎉 Build process completed!${NC}"
}

# Run the script
main "$@"
