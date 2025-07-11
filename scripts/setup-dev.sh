#!/bin/bash

# TRUEFAM Contribution Tracker - Development Setup Script

set -e

echo "🚀 Setting up TRUEFAM Contribution Tracker development environment..."

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Check Node.js version
check_node() {
    echo -e "${BLUE}📋 Checking Node.js version...${NC}"
    
    if ! command -v node &> /dev/null; then
        echo -e "${RED}❌ Node.js is not installed${NC}"
        echo -e "${YELLOW}Please install Node.js 16+ from https://nodejs.org${NC}"
        exit 1
    fi
    
    NODE_VERSION=$(node -v | cut -d'v' -f2 | cut -d'.' -f1)
    if [ "$NODE_VERSION" -lt 16 ]; then
        echo -e "${RED}❌ Node.js version $NODE_VERSION is too old${NC}"
        echo -e "${YELLOW}Please upgrade to Node.js 16+ from https://nodejs.org${NC}"
        exit 1
    fi
    
    echo -e "${GREEN}✅ Node.js $(node -v) is installed${NC}"
}

# Install global dependencies
install_global_deps() {
    echo -e "${BLUE}📦 Installing global dependencies...${NC}"
    
    # Install Expo CLI
    if ! command -v expo &> /dev/null; then
        echo -e "${YELLOW}Installing Expo CLI...${NC}"
        npm install -g @expo/cli
    fi
    
    # Install EAS CLI
    if ! command -v eas &> /dev/null; then
        echo -e "${YELLOW}Installing EAS CLI...${NC}"
        npm install -g eas-cli
    fi
    
    echo -e "${GREEN}✅ Global dependencies installed${NC}"
}

# Install project dependencies
install_project_deps() {
    echo -e "${BLUE}📦 Installing project dependencies...${NC}"
    npm install
    echo -e "${GREEN}✅ Project dependencies installed${NC}"
}

# Setup environment file
setup_env() {
    echo -e "${BLUE}⚙️  Setting up environment configuration...${NC}"
    
    if [ ! -f ".env" ]; then
        cat > .env << EOL
# TRUEFAM Contribution Tracker Environment Configuration

# Google APIs
GOOGLE_SHEETS_API_KEY=your_google_sheets_api_key_here
GMAIL_CLIENT_ID=your_gmail_client_id_here
GMAIL_CLIENT_SECRET=your_gmail_client_secret_here

# App Configuration
APP_ENV=development
DEBUG_MODE=true

# Notification Settings
ENABLE_PUSH_NOTIFICATIONS=true
NOTIFICATION_SOUND=default

# Export Settings
DEFAULT_EXPORT_FORMAT=csv
MAX_EXPORT_RECORDS=10000

# Security
ENCRYPT_LOCAL_DATA=true
SESSION_TIMEOUT=3600

# Development
ENABLE_DEV_TOOLS=true
LOG_LEVEL=debug
EOL
        echo -e "${GREEN}✅ Environment file created (.env)${NC}"
        echo -e "${YELLOW}⚠️  Please update .env with your actual API keys${NC}"
    else
        echo -e "${YELLOW}⚠️  Environment file already exists${NC}"
    fi
}

# Setup Git hooks
setup_git_hooks() {
    echo -e "${BLUE}🔧 Setting up Git hooks...${NC}"
    
    # Create pre-commit hook
    mkdir -p .git/hooks
    cat > .git/hooks/pre-commit << 'EOL'
#!/bin/sh
# TRUEFAM Pre-commit hook

echo "🔍 Running pre-commit checks..."

# Run TypeScript type checking
echo "📝 Type checking..."
npm run type-check

# Run linting
echo "🧹 Linting..."
npm run lint

# Run tests
echo "🧪 Running tests..."
npm test -- --passWithNoTests

echo "✅ Pre-commit checks passed!"
EOL
    
    chmod +x .git/hooks/pre-commit
    echo -e "${GREEN}✅ Git hooks configured${NC}"
}

# Create necessary directories
create_directories() {
    echo -e "${BLUE}📁 Creating project directories...${NC}"
    
    mkdir -p assets/images
    mkdir -p assets/sounds
    mkdir -p assets/fonts
    mkdir -p src/components
    mkdir -p src/screens
    mkdir -p src/services
    mkdir -p src/utils
    mkdir -p src/types
    mkdir -p src/hooks
    mkdir -p src/context
    mkdir -p android/app/src/main/java/com/truefam/contributiontracker
    mkdir -p ios/TrueFamTracker
    mkdir -p docs
    mkdir -p scripts
    mkdir -p __tests__
    
    echo -e "${GREEN}✅ Project directories created${NC}"
}

# Setup VS Code configuration
setup_vscode() {
    echo -e "${BLUE}⚙️  Setting up VS Code configuration...${NC}"
    
    mkdir -p .vscode
    
    # VS Code settings
    cat > .vscode/settings.json << 'EOL'
{
  "typescript.preferences.importModuleSpecifier": "relative",
  "editor.formatOnSave": true,
  "editor.codeActionsOnSave": {
    "source.fixAll.eslint": true
  },
  "emmet.includeLanguages": {
    "typescript": "typescriptreact"
  },
  "files.associations": {
    "*.tsx": "typescriptreact"
  },
  "search.exclude": {
    "**/node_modules": true,
    "**/ios/build": true,
    "**/android/build": true,
    "**/.expo": true
  }
}
EOL
    
    # VS Code extensions recommendations
    cat > .vscode/extensions.json << 'EOL'
{
  "recommendations": [
    "ms-vscode.vscode-typescript-next",
    "esbenp.prettier-vscode",
    "dbaeumer.vscode-eslint",
    "bradlc.vscode-tailwindcss",
    "ms-vscode.vscode-json",
    "expo.vscode-expo-tools",
    "ms-vscode-remote.remote-containers"
  ]
}
EOL
    
    echo -e "${GREEN}✅ VS Code configuration created${NC}"
}

# Display next steps
show_next_steps() {
    echo -e "${GREEN}🎉 Development environment setup complete!${NC}"
    echo -e "${BLUE}================================================${NC}"
    echo -e "${YELLOW}Next steps:${NC}"
    echo "1. Update .env file with your API keys"
    echo "2. Configure Google Cloud Console for APIs"
    echo "3. Run 'expo start' to start development server"
    echo "4. Install Expo Go app on your device for testing"
    echo ""
    echo -e "${BLUE}Useful commands:${NC}"
    echo "• expo start          - Start development server"
    echo "• npm run android     - Run on Android"
    echo "• npm run ios         - Run on iOS"
    echo "• npm test            - Run tests"
    echo "• npm run lint        - Run linter"
    echo "• npm run build       - Build for production"
    echo ""
    echo -e "${GREEN}Happy coding! 🚀${NC}"
}

# Main execution
main() {
    echo -e "${GREEN}🎯 TRUEFAM Contribution Tracker Setup${NC}"
    echo -e "${BLUE}=====================================${NC}"
    
    check_node
    install_global_deps
    install_project_deps
    setup_env
    create_directories
    setup_git_hooks
    setup_vscode
    show_next_steps
}

# Run the script
main "$@"
