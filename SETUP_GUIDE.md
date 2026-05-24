# Futuristic PDF Reader - Setup & Installation Guide

## Project Overview

**Neon Archive** is a premium cyberpunk-inspired Flutter PDF reader application featuring:
- Futuristic glassmorphism UI with neon blue/purple gradients
- Smooth animations and transitions
- Local PDF scanning and management
- Advanced PDF reading with search, bookmarks, and fullscreen modes
- Dark theme with glowing UI effects
- Responsive design for mobile and desktop
- State management with Provider

## ✨ Key Features Implemented

### Home Dashboard
- Modern futuristic dashboard with gradient backgrounds
- Recent PDFs carousel with animated cards
- Favorites grid view
- Quick document list with sorting (Name, Date, Size)
- Beautiful glassmorphism cards with soft shadows
- Search functionality across all PDFs
- Statistics display (recent count, favorites count)

### PDF Reader
- Smooth PDF rendering with page navigation
- Full-text search inside PDFs
- Bookmark management
- Fullscreen reading mode
- Page slider with thumbnail navigation
- Gesture controls for swipe navigation
- Animated toolbar with glow effects
- Current page indicator

### Navigation & UI
- Futuristic animated splash screen
- Side navigation drawer
- Bottom navigation bar
- Settings screen with theme toggle
- Reading statistics tracking
- Smooth page transition animations

### Local Storage
- Hive database for persistent storage
- Recent files tracking (up to 10 items)
- Favorite PDFs management
- Bookmark storage per document
- App settings persistence
- Session counter

### File Management
- Automatic PDF scanning from device storage
- External file picker for manual PDF selection
- File sorting by name, date, and size
- Document metadata (size, modification date)
- Permission handling for storage access

## 🛠 Tech Stack

```yaml
Flutter: Latest stable
Dart: >=2.19.0
State Management: Provider 6.0.5+
Local Storage: Hive 2.2.3
PDF Viewer: Syncfusion 33.2.7
File Handling: file_picker 5.3.4, path_provider 2.0.18
Permissions: permission_handler 11.0.0+
```

## 📁 Project Structure

```
lib/
├── main.dart                 # App entry point
├── app.dart                  # App configuration & routing
├── models/
│   ├── pdf_document.dart     # PDF document data model
│   └── bookmark.dart         # Bookmark data model
├── providers/
│   ├── app_provider.dart     # App-wide state (theme, stats)
│   └── pdf_provider.dart     # PDF management state
├── services/
│   ├── storage_service.dart  # Hive database operations
│   └── file_service.dart     # File system operations
├── screens/
│   ├── splash_screen.dart    # Animated splash screen
│   ├── home_screen.dart      # Main dashboard
│   ├── pdf_reader_screen.dart # PDF reading interface
│   └── settings_screen.dart  # Settings & preferences
├── widgets/
│   ├── glass_card.dart       # Glassmorphism container
│   ├── pdf_card.dart         # Document card widget
│   ├── futuristic_app_bar.dart
│   ├── search_bar.dart
│   ├── section_header.dart
│   ├── side_drawer.dart
│   ├── bottom_navigation.dart
│   ├── animated_loader.dart
│   └── thumbnail_slider.dart
├── themes/
│   └── app_theme.dart        # Dark theme configuration
└── utils/
    ├── constants.dart        # App constants
    └── formatters.dart       # Utility formatters

assets/
├── icons/                    # Icon assets (ready for use)
└── images/                   # Image assets (ready for use)

pubspec.yaml                  # Dependencies configuration
```

## 🚀 Installation & Setup

### Prerequisites
- Flutter SDK (3.10.0 or higher)
- Dart SDK (included with Flutter)
- Android Studio or Xcode (for iOS development)

### Step 1: Clone/Access the Project
```bash
cd /home/khalifah/Desktop/pdf\ reader
```

### Step 2: Get Dependencies
```bash
flutter pub get
```

### Step 3: Generate Build Files
```bash
flutter pub get
flutter clean  # Optional, for clean build
```

### Step 4: Run the Application

**On Android Emulator:**
```bash
flutter emulators --launch <emulator_name>
flutter run
```

**On Physical Android Device:**
```bash
flutter run
```

**On Linux Desktop (enabled):**
```bash
flutter run -d linux
```

**With Debug Output:**
```bash
flutter run -v
```

## 🎨 UI Design Specifications

### Color Palette
- **Background**: `#050812` (Deep Space Black)
- **Surface**: `#0F172A` (Dark Blue)
- **Neon Blue**: `#48D1FF` (Bright Cyan)
- **Neon Purple**: `#9B5CFF` (Vibrant Purple)
- **Card**: `#111A2E` (Dark Card Background)
- **Border**: `#2E3A59` (Subtle Border)

### Typography
- **Headlines**: Orbitron (futuristic monospace font)
- **Body Text**: Inter (system font fallback)
- **Weights**: Bold (700), Semi-bold (600), Regular (400)

### Components
- **Glassmorphism**: 6% white opacity with gradient overlay
- **Corner Radius**: 24-28px for cards, 18-22px for smaller elements
- **Shadows**: Soft 20px blur with 12px offset
- **Animations**: 300-400ms duration with easeOutQuad curves

## 📱 Supported Platforms

- ✅ **Android** (API 21+) - Recommended for full features
- ✅ **iOS** (12.0+) - Full feature support
- ✅ **Linux Desktop** - Functional with desktop optimizations
- ✅ **Windows Desktop** - Basic support
- ✅ **macOS** - Full support (requires Xcode)
- ⚠️ **Web** - Limited support (PDF viewer restrictions)

## 🔐 Permissions Required

### Android (AndroidManifest.xml)
```xml
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.MANAGE_EXTERNAL_STORAGE"/>
```

### iOS (Info.plist)
```xml
<key>NSLocalizedDescription</key>
<string>Access PDF files from your device</string>
```

## 🗄 Local Storage Schema

### Hive Boxes
1. **recent_pdfs**: List of recently opened PDFs (max 10)
2. **favorite_pdfs**: List of favorite PDFs
3. **pdf_bookmarks**: Map of document paths to bookmarks
4. **app_settings**: App preferences (theme, statistics)

## 🎯 Usage Guide

### Opening PDFs
1. Tap "Open PDF" floating action button
2. Select a PDF from your device
3. Document appears in Recent & All Documents sections

### Reading PDFs
1. Tap any PDF card to open the reader
2. Tap to show/hide controls
3. Use arrow buttons to navigate pages
4. Search text with search bar
5. Add bookmarks with bookmark button
6. Toggle fullscreen mode

### Managing Library
1. Mark favorites by tapping heart icon
2. Sort documents (Name/Date/Size)
3. Search across all PDFs
4. View reading statistics in Settings

### Customization
1. Open Settings (bottom nav)
2. Toggle dark mode
3. View reading statistics
4. Manage app preferences

## ⚙️ Common Issues & Solutions

### Issue: PDFs not found
**Solution**: Check storage permissions in device settings
- Android: Settings → Apps → Permissions → Storage
- iOS: Settings → Privacy → Files and Folders

### Issue: Slow PDF loading
**Solution**: Clear app cache
```bash
flutter clean
flutter pub get
flutter run
```

### Issue: Syncfusion license warning
**Solution**: This is normal for trial version. No action needed for development.

### Issue: File picker not opening
**Solution**: Rebuild the app
```bash
flutter clean
flutter pub get
flutter run
```

## 🔧 Development Commands

```bash
# Clean build
flutter clean

# Get dependencies
flutter pub get

# Run code analysis
flutter analyze

# Format code
flutter format lib/

# Build APK (Android)
flutter build apk --release

# Build AAB (Google Play)
flutter build appbundle --release

# Build for iOS
flutter build ios --release

# Run tests
flutter test

# Generate code documentation
dartdoc
```

## 📊 Performance Optimization

### Memory Management
- PDF caching handled by Syncfusion
- Recent files limited to 10 items
- Images optimized for display
- State management prevents rebuilds

### Navigation
- Lazy loading of document lists
- Efficient page rendering
- Smooth transitions with GPU acceleration

### Storage
- Hive provides fast local access
- Minimal database footprint
- Efficient serialization

## 🎁 Future Enhancement Ideas

1. PDF annotation tools
2. Reading time statistics
3. Cloud backup integration
4. PDF sharing capabilities
5. Text extraction and export
6. Reading lists/collections
7. Advanced search filters
8. Dark/light mode auto-scheduling
9. Voice control integration
10. Social sharing features

## 📦 Building for Release

### Android Release
```bash
flutter build apk --split-per-abi --release
flutter build appbundle --release
```

### iOS Release
```bash
flutter build ios --release
# Then upload via Xcode
```

### Linux Desktop Release
```bash
flutter build linux --release
# Binary: build/linux/release/bundle/
```

## 📞 Support & Troubleshooting

For Flutter documentation: https://flutter.dev/docs
For Syncfusion PDF Viewer: https://www.syncfusion.com/flutter-widgets/flutter-pdf-viewer

## 📝 Notes

- App uses Material 3 design language
- Dark theme is the default and optimized
- All animations use 60fps for smoothness
- Responsive design scales to all screen sizes
- LocalStorage persists across app restarts

## ✅ Checklist Before Deployment

- [ ] Test on minimum supported Android version
- [ ] Test on multiple device sizes
- [ ] Verify all permissions work correctly
- [ ] Check dark mode appearance
- [ ] Test PDF searching and bookmarking
- [ ] Verify storage access
- [ ] Profile performance with large PDFs
- [ ] Test app lifecycle transitions
- [ ] Verify UI doesn't overflow on small screens

---

**Built with ❤️ using Flutter & Dart**  
**Cyberpunk Design Inspired | Production Ready**
