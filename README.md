# TraceBack - Lost & Found App

**TraceBack Ethiopia** is a Flutter-based mobile application that connects people who have lost items with those who have found them. The app features a secure verification system, in-app messaging, reward management, and multiple payment gateway integrations.

## 🎯 Key Features

### ✅ Implemented
- **User Authentication**: Sign up, sign in, and session management
- **Feed System**: Browse recently found items with details and location
- **Post Found Items**: Finders can post items with verification questions
- **Claim & Verification**: Losers answer verification questions to claim items
- **In-App Chat**: Secure messaging between finders and losers
- **Payment Gateway**: Integration with Telebirr and CBE Birr for Ethiopian users
- **Reward Management**: Track pending rewards and compensation
- **Beautiful UI**: Material Design 3 with custom theming

### 🚧 In Development
- [ ] Search & Filter Screen (by category, location, date range)
- [ ] User Profile Management (edit profile, view history)
- [ ] Notification System (push notifications, real-time alerts)
- [ ] Firebase Database Integration (replace local storage)
- [ ] Image Compression (auto-compress on upload)
- [ ] Image Upload from Camera/Gallery (actual file picker)
- [ ] OTP SMS Verification for phone numbers
- [ ] Lost Item Postings (for losers to post missing items)

## 📦 Project Structure

```
traceback/
├── lib/
│   ├── main.dart                 # Main app entry & core screens
│   ├── screens/
│   │   ├── auth/
│   │   │   ├── auth_screen.dart
│   │   │   ├── welcome_screen.dart
│   │   │   └── user_profile.dart        # TODO
│   │   ├── home/
│   │   │   ├── feed_screen.dart
│   │   │   ├── search_filter_screen.dart # TODO
│   │   │   └── notifications_screen.dart # TODO
│   │   ├── post/
│   │   │   ├── post_item_screen.dart
│   │   │   └── image_compression.dart    # TODO
│   │   └── chat/
│   │       ├── chat_dashboard.dart
│   │       ├── chat_room.dart
│   │       └── payment_gateway.dart
│   ├── models/
│   │   ├── user_model.dart              # TODO
│   │   ├── item_model.dart              # TODO
│   │   ├── claim_model.dart             # TODO
│   │   └── message_model.dart           # TODO
│   ├── services/
│   │   ├── firebase_service.dart        # TODO
│   │   ├── notification_service.dart    # TODO
│   │   ├── image_service.dart           # TODO
│   │   └── payment_service.dart         # TODO
│   └── utils/
│       ├── constants.dart               # TODO
│       ├── validators.dart              # TODO
│       └── helpers.dart                 # TODO
├── assets/
│   ├── images/
│   └── icons/
├── pubspec.yaml
└── README.md
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK: `^3.2.0`
- Dart SDK (included with Flutter)
- Android Studio / Xcode (for emulators)
- Firebase project (for backend)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/selamgetahun48-source/traceback-lost-found.git
   cd traceback-lost-found
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase**
   - Create a Firebase project at [firebase.google.com](https://firebase.google.com)
   - Follow the [FlutterFire setup guide](https://firebase.flutter.dev/docs/overview)
   - Download and configure `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)

4. **Run the app**
   ```bash
   flutter run
   ```

## 🔧 Configuration

### Firebase Setup
```dart
// In lib/services/firebase_service.dart
future void initFirebase() async {
  await Firebase.initializeApp();
  // Additional configuration
}
```

### Environment Variables
Create a `.env` file for sensitive configuration:
```
FIREBASE_PROJECT_ID=your_project_id
TELEBIRR_API_KEY=your_telebirr_key
CBE_API_KEY=your_cbe_key
```

## 📋 User Flows

### Finder's Flow
1. Sign in to the app
2. Click "+ Post Found" button
3. Upload item photo and fill details
4. Set verification question (e.g., "What color is the case?")
5. Submit to publish on feed
6. Receive notifications when claims are made
7. Review claim answers and approve valid ones
8. Chat with finder and receive payment

### Loser's Flow
1. Sign in to the app
2. Browse feed or use search/filter
3. Find matching item and click "This is Mine!"
4. Answer the finder's verification question
5. If correct, open chat with finder
6. Negotiate meeting location (safe public place)
7. Send payment (Telebirr/CBE Birr)
8. Complete handoff

## 🔐 Security Features

- ✅ Password encryption using Firebase Auth
- ✅ Verification questions to prevent fake claims
- ✅ Secure in-app messaging (no direct phone number exposure)
- ✅ Payment verification system
- 🚧 End-to-end encryption for chats (TODO)
- 🚧 User reputation system (TODO)
- 🚧 Report/block functionality (TODO)

## 📱 UI/UX Features

- Material Design 3 compliant
- Custom color scheme:
  - Primary: `#1E3A8A` (Deep Blue)
  - Secondary: `#10B981` (Green)
  - Background: `#F8FAFC` (Light Gray)
- Responsive design for all screen sizes
- Smooth animations and transitions
- Bottom navigation with 3 main sections

## 📊 Database Schema (Firebase Firestore)

### Collections
```
users/
├── {userId}
│   ├── name: string
│   ├── email: string
│   ├── phone: string
│   ├── profileImage: string (URL)
│   ├── createdAt: timestamp
│   └── rating: number

found_items/
├── {itemId}
│   ├── title: string
│   ├── category: string
│   ├── description: string
│   ├── location: string
│   ├── latitude: number
│   ├── longitude: number
│   ├── images: [string] (URLs)
│   ├── verificationQuestion: string
│   ├── verificationAnswer: string
│   ├── reward: number
│   ├── finderId: string (reference to users)
│   ├── status: string ("open", "claimed", "returned")
│   ├── createdAt: timestamp
│   └── claimedBy: string (userId)

claims/
├── {claimId}
│   ├── itemId: string (reference)
│   ├── loserId: string (reference)
│   ├── answer: string
│   ├── isCorrect: boolean
│   ├── status: string ("pending", "approved", "rejected")
│   └── createdAt: timestamp

messages/
├── {chatId}
│   ├── itemId: string
│   ├── finderId: string
│   ├── loserId: string
│   ├── messages: [
│   │   {
│   │     senderId: string,
│   │     text: string,
│   │     timestamp: timestamp
│   │   }
│   │ ]
│   └── status: string ("active", "completed")

notifications/
├── {userId}
│   └── {notificationId}
│       ├── type: string ("claim", "message", "payment")
│       ├── title: string
│       ├── message: string
│       ├── read: boolean
│       └── createdAt: timestamp
```

## 🗺️ Development Roadmap

### Phase 1: MVP (Current)
- [x] Basic auth and navigation
- [x] Post found items
- [x] Claim verification
- [x] Chat system
- [x] Payment integration
- [ ] Firebase backend integration

### Phase 2: Enhanced Features
- [ ] Search & filter by category, location, date
- [ ] User profiles with history
- [ ] Real-time notifications
- [ ] Image compression
- [ ] Lost item postings
- [ ] User ratings/reputation

### Phase 3: Advanced
- [ ] Map integration (show item locations)
- [ ] Report/block users
- [ ] Dispute resolution system
- [ ] Admin dashboard
- [ ] Analytics
- [ ] Multi-language support (Amharic, English, Oromo)

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 🐛 Issues & Bugs

Found a bug? Please create an issue on GitHub:
- Use a clear, descriptive title
- Provide steps to reproduce
- Include screenshots if applicable
- Mention your device and Flutter version

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 👨‍💻 Author

**Selam Getahun**
- GitHub: [@selamgetahun48-source](https://github.com/selamgetahun48-source)
- Location: Ethiopia 🇪🇹

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Firebase for backend services
- Ethiopian payment providers (Telebirr, CBE)
- Community feedback and contributions

---

**Made with ❤️ in Ethiopia**
