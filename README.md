# README - Neon Archive: Futuristic PDF Reader

<div align="center">

![Neon Archive](https://img.shields.io/badge/Neon%20Archive-Futuristic%20PDF%20Reader-blueviolet?style=flat-square)
![Flutter](https://img.shields.io/badge/Flutter-3.0%2B-blue?style=flat-square&logo=flutter)
![Dart](https://img.shields.io/badge/Dart-2.19%2B-0175C2?style=flat-square&logo=dart)
![License](https://img.shields.io/badge/License-MIT-green?style=flat-square)

**A cyberpunk-inspired premium PDF reader with glassmorphism UI, smooth animations, and futuristic design elements.**

[Features](#-features) • [Installation](#-installation) • [Usage](#-usage) • [Architecture](#-architecture) • [API](#-api)

</div>

---

## ✨ Features

### 🎨 UI/UX Excellence
- **Glassmorphism Design**: Modern frosted glass effect with transparency
- **Neon Color Palette**: Vibrant blue (#48D1FF) and purple (#9B5CFF) gradients
- **Smooth Animations**: 300-400ms transitions with easeOutQuad curves
- **Dark Theme**: Optimized for eye comfort and cyberpunk aesthetics
- **Responsive Layout**: Adapts to mobile, tablet, and desktop screens

### 📚 PDF Management
- **Auto Scan**: Automatically detects all PDFs on device storage
- **Smart Organization**: Recent files, favorites, and all documents sections
- **Document Search**: Full-text search capability within PDFs
- **Quick Sorting**: Sort by name, date, or file size
- **File Metadata**: View document size and modification date

### 📖 Reading Experience
- **Smooth Rendering**: Fast, responsive PDF page rendering
- **Page Navigation**: Arrow buttons, page slider, and swipe gestures
- **Bookmarks**: Save important pages for quick reference
- **Fullscreen Mode**: Immersive reading without distractions
- **Search Integration**: Find text within documents
- **Page Thumbnails**: Quick access to document pages

### 🏠 Dashboard
- **Welcome Section**: Personalized greeting with statistics
- **Recent Carousel**: Quick access to previously opened PDFs
- **Favorites Grid**: One-tap access to your top reads
- **Statistics**: Track reading sessions and pages read

### ⚙️ Customization
- **Theme Toggle**: Switch between dark and light modes
- **Reading Stats**: Monitor your reading activity
- **Persistent Storage**: All preferences saved locally
- **Session Tracking**: Number of app opens recorded

---

## 🚀 Quick Start

### Prerequisites
```bash
Flutter SDK: >=3.0.0
Dart: >=2.19.0
Android: API 21+ or iOS: 12.0+
```

### Installation

1. **Clone the repository**
```bash
cd /path/to/project
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Run the app**
```bash
flutter run
```

### Build for Release

**Android APK:**
```bash
flutter build apk --release --split-per-abi
```

**Android App Bundle (Google Play):**
```bash
flutter build appbundle --release
```

**iOS:**
```bash
flutter build ios --release
```

---

## 📱 Usage Guide

### Opening PDFs

1. Tap the **"Open PDF"** floating action button
2. Select a PDF file from your device
3. The document will appear in "Recent PDFs"

### Reading PDFs

- **Navigate**: Use arrow buttons or swipe gestures
- **Search**: Type in the search bar to find text
- **Bookmark**: Click bookmark icon to save current page
- **Fullscreen**: Toggle fullscreen mode from toolbar
- **Page Slider**: Use thumbnail slider for quick navigation

### Managing Your Library

- **Favorites**: Tap heart icon to mark/unmark favorites
- **Search**: Use the top search bar to filter documents
- **Sort**: Click "Sort" to arrange by name, date, or size
- **Settings**: Access preferences from bottom navigation

### Customization

1. Open **Settings** (bottom right navigation)
2. Toggle **Dark Mode** for theme preference
3. View **Reading Statistics**
4. Access app information

---

## 📂 Project Structure

```
lib/
├── main.dart                 # App initialization
├── app.dart                  # App routing and configuration
├── models/                   # Data models
│   ├── pdf_document.dart
│   └── bookmark.dart
├── providers/                # State management
│   ├── app_provider.dart
│   └── pdf_provider.dart
├── services/                 # Business logic
│   ├── storage_service.dart
│   └── file_service.dart
├── screens/                  # Screen widgets
│   ├── splash_screen.dart
│   ├── home_screen.dart
│   ├── pdf_reader_screen.dart
│   └── settings_screen.dart
├── widgets/                  # Reusable components
│   ├── glass_card.dart
│   ├── pdf_card.dart
│   ├── animated_loader.dart
│   └── ... (other widgets)
├── themes/                   # Theme configuration
│   └── app_theme.dart
└── utils/                    # Utilities
    ├── constants.dart
    └── formatters.dart

assets/
├── icons/
└── images/
```

---

## 🏗 Architecture

**Clean Architecture** with clear separation of concerns:

```
┌─────────────────────────┐
│  Presentation Layer     │ (UI/Screens/Widgets)
├─────────────────────────┤
│  State Management       │ (Provider Pattern)
├─────────────────────────┤
│  Business Logic         │ (Services)
├─────────────────────────┤
│  Data Layer             │ (Models/Storage)
└─────────────────────────┘
```

### Data Flow
```
User Interaction → Provider Method → Update State → 
Persist Storage → Notify Listeners → UI Rebuild
```

For detailed architecture documentation, see [ARCHITECTURE.md](ARCHITECTURE.md)

---

## 🎨 Design System

### Colors
| Color | Hex | Usage |
|-------|-----|-------|
| Background | #050812 | Screen background |
| Surface | #0F172A | Secondary background |
| Neon Blue | #48D1FF | Primary accent |
| Neon Purple | #9B5CFF | Secondary accent |
| Card | #111A2E | Card backgrounds |

### Typography
- **Headlines**: Orbitron (Futuristic monospace)
- **Body**: Inter (Readable system font)
- **Weights**: Regular (400), Semi-bold (600), Bold (700)

### Components
- Corner Radius: 24-28px (rounded)
- Shadows: 20px blur, 12px offset
- Glassmorphism: 6% white opacity

---

## 🔌 API Reference

### PdfProvider

```dart
// Get all PDFs
List<PdfDocument> get allPdfs;

// Get recent PDFs
List<PdfDocument> get recentPdfs;

// Get favorite PDFs
List<PdfDocument> get favorites;

// Scan device storage
Future<void> scanStorage();

// Add to recent
void addRecent(PdfDocument document);

// Toggle favorite status
void toggleFavorite(PdfDocument document);

// Check if favorite
bool isFavorite(PdfDocument document);

// Add bookmark
Future<void> addBookmark(String filePath, int page);

// Open PDF file picker
Future<PdfDocument?> openExternalPdf();

// Sort documents
void setSortBy(String field);
```

### AppProvider

```dart
// Get current theme mode
ThemeMode get themeMode;

// Toggle theme
void toggleTheme();

// Update pages read
void updatePagesRead(int count);

// Register session
void registerSession();

// Get total pages read
int get totalPagesRead;
```

---

## 🛠 Development

### Code Quality

```bash
# Analyze code
flutter analyze

# Format code
flutter format lib/

# Run tests
flutter test

# Build documentation
dartdoc
```

### Dependencies

```yaml
provider: ^6.0.5
hive_flutter: ^1.1.0
permission_handler: ^11.0.3
file_picker: ^5.3.4
syncfusion_flutter_pdfviewer: ^33.2.7
path_provider: ^2.0.18
```

---

## 📊 Performance

- **Memory**: Efficient state management with Provider
- **Speed**: 60fps smooth animations
- **Startup**: Sub-1 second app launch
- **PDF Rendering**: Syncfusion optimized viewer
- **Storage**: Hive for fast local persistence

---

## 🔐 Permissions

### Android
```xml
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.MANAGE_EXTERNAL_STORAGE"/>
```

### iOS
```xml
<key>NSLocalizedDescription</key>
<string>Access PDF files from your device</string>
```

---

## ⚠️ Known Issues

- RadioListTile uses deprecated groupValue (Migration in progress)
- File picker platform-specific implementations for desktop
- Syncfusion uses trial license watermark (development mode)

---

## 🚧 Roadmap

- [ ] PDF annotation tools
- [ ] Reading time tracking
- [ ] Cloud synchronization
- [ ] PDF sharing capabilities
- [ ] Text extraction
- [ ] Advanced search filters
- [ ] Voice command support
- [ ] Social features

---

## 📝 License

MIT License - See LICENSE file for details

---

## 🙋 Support

For issues and questions:
- Check [SETUP_GUIDE.md](SETUP_GUIDE.md) for troubleshooting
- Review [ARCHITECTURE.md](ARCHITECTURE.md) for technical details
- Flutter Docs: https://flutter.dev/docs

---

## 🎓 Technologies Used

- **Flutter**: Cross-platform UI framework
- **Dart**: Programming language
- **Provider**: State management
- **Hive**: Local storage database
- **Syncfusion**: PDF rendering engine
- **Material 3**: Design system

---

<div align="center">

**Built with ❤️ using Flutter & Dart**

Cyberpunk Design Inspired | Production Ready | Open Source

</div>
