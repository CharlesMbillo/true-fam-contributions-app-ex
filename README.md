# TRUEFAM Contribution Tracker

A React Native Expo application for tracking and managing financial contributions through SMS, email, and WhatsApp notifications.

## 🚀 Features

- **Multi-Platform Monitoring**: Track contributions from Zelle, Venmo, CashApp, M-Pesa, and more
- **SMS Integration**: Automatic parsing of SMS notifications from financial apps
- **Email Monitoring**: Gmail API integration for email-based notifications
- **WhatsApp Support**: Parse WhatsApp notifications for contribution tracking
- **Google Sheets Integration**: Automatic data synchronization with Google Sheets
- **Export Functionality**: Generate CSV and PDF reports with advanced filtering
- **Real-time Dashboard**: Live monitoring and statistics
- **Background Processing**: Continuous monitoring even when app is closed

## 📱 Screenshots

[Add screenshots here]

## 🛠 Installation

### Prerequisites

- Node.js (v16 or higher)
- npm or yarn
- Expo CLI
- Android Studio (for Android development)
- Xcode (for iOS development, macOS only)

### Setup

1. **Clone the repository**
   \`\`\`bash
   git clone https://github.com/yourusername/truefam-tracker.git
   cd truefam-tracker
   \`\`\`

2. **Install dependencies**
   \`\`\`bash
   npm install
   # or
   yarn install
   \`\`\`

3. **Install Expo CLI globally**
   \`\`\`bash
   npm install -g @expo/cli
   \`\`\`

4. **Configure environment variables**
   \`\`\`bash
   cp .env.example .env
   \`\`\`
   Edit `.env` with your configuration:
   \`\`\`
   GOOGLE_SHEETS_API_KEY=your_api_key_here
   GMAIL_CLIENT_ID=your_gmail_client_id
   GMAIL_CLIENT_SECRET=your_gmail_client_secret
   \`\`\`

5. **Start the development server**
   \`\`\`bash
   expo start
   \`\`\`

## 🔧 Configuration

### Google Sheets Setup

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select existing one
3. Enable Google Sheets API and Gmail API
4. Create credentials (OAuth 2.0 Client ID)
5. Add your credentials to the `.env` file

### Android Permissions

The app requires the following permissions:
- `READ_SMS` - To read SMS notifications
- `RECEIVE_SMS` - To receive new SMS messages
- `BIND_NOTIFICATION_LISTENER_SERVICE` - To access notifications
- `INTERNET` - For API calls
- `WAKE_LOCK` - For background processing
- `FOREGROUND_SERVICE` - For continuous monitoring

## 📦 Building

### Development Build

\`\`\`bash
# For Android
expo run:android

# For iOS
expo run:ios
\`\`\`

### Production Build

\`\`\`bash
# Build for Android (APK)
eas build --platform android --profile production

# Build for iOS
eas build --platform ios --profile production
\`\`\`

### Local Android APK Build

\`\`\`bash
# Generate Android APK locally
expo build:android -t apk
\`\`\`

## 🚀 Deployment

### Using EAS Build

1. **Install EAS CLI**
   \`\`\`bash
   npm install -g eas-cli
   \`\`\`

2. **Login to Expo**
   \`\`\`bash
   eas login
   \`\`\`

3. **Configure EAS**
   \`\`\`bash
   eas build:configure
   \`\`\`

4. **Build for production**
   \`\`\`bash
   eas build --platform android --profile production
   \`\`\`

### Manual APK Generation

1. **Generate signed APK**
   \`\`\`bash
   cd android
   ./gradlew assembleRelease
   \`\`\`

2. **APK location**
   \`\`\`
   android/app/build/outputs/apk/release/app-release.apk
   \`\`\`

## 📊 Usage

### Starting Monitoring

1. Open the app and navigate to Settings
2. Configure your Google Sheets URL
3. Set up your phone number for SMS monitoring
4. Enable monitoring from the dashboard
5. Grant necessary permissions when prompted

### Adding Manual Contributions

1. Tap "Manual Entry" on the dashboard
2. Fill in contribution details
3. Select the appropriate platform
4. Save the contribution

### Exporting Data

1. Navigate to Export screen
2. Choose export format (CSV or PDF)
3. Set date range and filters
4. Select report type
5. Generate and share the report

## 🔒 Security

- All sensitive data is encrypted
- API keys are stored securely
- SMS data is processed locally
- Google Sheets integration uses OAuth 2.0
- No sensitive data is logged

## 🧪 Testing

\`\`\`bash
# Run tests
npm test

# Run with coverage
npm run test:coverage

# Run E2E tests
npm run test:e2e
\`\`\`

## 📝 API Documentation

### Contribution Object

\`\`\`typescript
interface Contribution {
  id: string;
  amount: number;
  senderName: string;
  memberId: string;
  date: string;
  platform: 'Zelle' | 'Venmo' | 'CashApp' | 'M-Pesa' | 'Other';
  source: 'SMS' | 'Email' | 'WhatsApp' | 'Manual';
  rawMessage?: string;
}
\`\`\`

### Export Options

\`\`\`typescript
interface ExportOptions {
  format: 'csv' | 'pdf';
  dateRange: {
    startDate: string;
    endDate: string;
  };
  platforms?: string[];
  memberIds?: string[];
  reportType: 'detailed' | 'summary' | 'by-platform' | 'by-member';
  includeRawMessages?: boolean;
  groupByDate?: boolean;
}
\`\`\`

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Development Guidelines

- Follow TypeScript best practices
- Use meaningful commit messages
- Add tests for new features
- Update documentation as needed
- Follow the existing code style

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Support

For support, email support@truefam.com or create an issue in this repository.

## 🔄 Changelog

### v1.0.0 (Latest)
- Initial release
- SMS monitoring functionality
- Google Sheets integration
- Export to CSV and PDF
- WhatsApp notification support
- Background processing

### v0.9.0
- Beta release
- Core functionality implementation
- Basic UI/UX

## 🙏 Acknowledgments

- Expo team for the amazing framework
- React Native community
- Google for APIs
- All contributors and testers

## 📞 Contact

- **Project Maintainer**: [Your Name]
- **Email**: your.email@example.com
- **Website**: https://truefam.com
- **Twitter**: [@truefam](https://twitter.com/truefam)

---

Made with ❤️ by the TRUEFAM team
