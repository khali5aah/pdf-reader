# Neon Archive - Quick Reference

## 🚀 Commands

```bash
# Setup
flutter pub get                          # Install dependencies
flutter clean                            # Clean build artifacts

# Development
flutter run                              # Run app
flutter run -v                           # Run with verbose logging
flutter run -d <device_id>              # Run on specific device

# Testing
flutter analyze                          # Lint code
flutter format lib/                     # Format code
flutter test                            # Run unit tests

# Building
flutter build apk --release             # Android APK
flutter build ios --release             # iOS
flutter build linux --release           # Linux desktop
flutter build appbundle --release       # Google Play Bundle
```

## 📚 File Locations

| File | Purpose |
|------|---------|
| `lib/main.dart` | App entry point |
| `lib/providers/pdf_provider.dart` | PDF state management |
| `lib/screens/home_screen.dart` | Main dashboard |
| `lib/screens/pdf_reader_screen.dart` | PDF viewer |
| `lib/themes/app_theme.dart` | Theme configuration |
| `pubspec.yaml` | Dependencies |

## 🎨 Common UI Components

```dart
// Glassmorphism card
GlassCard(child: Widget())

// PDF card with image
PdfCard(document: pdfDoc, onTap: () {})

// Futuristic app bar
FuturisticAppBar(title: 'Title')

// Animated loading spinner
AnimatedLoader()

// Section divider with action
SectionHeader(title: 'Title', actionText: 'Action', onActionTap: () {})
```

## 🔧 Provider Usage

```dart
// Read state (listen)
Consumer<PdfProvider>(
  builder: (context, pdfState, child) => Text(),
)

// Read state (no listen)
Provider.of<PdfProvider>(context, listen: false)

// Call provider method
Provider.of<PdfProvider>(context, listen: false).toggleFavorite(doc);

// Multiple providers
Consumer2<PdfProvider, AppProvider>(
  builder: (context, pdfState, appState, child) => Widget(),
)
```

## 💾 Storage Operations

```dart
// Save recent PDFs
StorageService.saveDocumentList(StorageService.recentBox, docs);

// Load recent PDFs
List<PdfDocument> recent = await StorageService.loadDocumentList(
  StorageService.recentBox
);

// Save settings
StorageService.saveSettings({'useDarkMode': true});

// Get all settings
Map settings = await StorageService.getSettings();
```

## 📱 Screen Navigation

```dart
// Push new screen
Navigator.push(
  context,
  MaterialPageRoute(builder: (_) => NewScreen()),
);

// Named route
Navigator.pushNamed(context, SettingsScreen.routeName);

// Pop back
Navigator.pop(context);
```

## 🎨 Color Constants

```dart
Color background = Color(0xFF050812);
Color surface = Color(0xFF0F172A);
Color neonBlue = Color(0xFF48D1FF);
Color neonPurple = Color(0xFF9B5CFF);
Color card = Color(0xFF111A2E);
```

## 📐 Common Spacing

```dart
SizedBox(height: 8);   // Tiny
SizedBox(height: 14);  // Small
SizedBox(height: 18);  // Base
SizedBox(height: 26);  // Large
```

## 🔄 Model Examples

```dart
// Create PDF document
PdfDocument(
  filePath: '/path/to/file.pdf',
  name: 'Document.pdf',
  size: 1024000,
  updatedAt: DateTime.now(),
)

// Create bookmark
Bookmark(
  documentPath: '/path/to/file.pdf',
  page: 42,
)
```

## 🐛 Debugging Tips

```bash
# View device logs
flutter logs

# Enable debug prints
flutter run -v

# Check frame rate
flutter run --profile

# Analyze performance
flutter run --trace-startup

# Create release build for testing
flutter build apk --release --analyze-size
```

## 🎯 State Management Pattern

```dart
// 1. Define state in Provider
class MyProvider extends ChangeNotifier {
  String _data = '';
  String get data => _data;
  
  void updateData(String newData) {
    _data = newData;
    notifyListeners(); // Rebuild UI
  }
}

// 2. Add to MultiProvider in main.dart
MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (_) => MyProvider()),
  ],
  child: const FuturisticPdfApp(),
)

// 3. Use in UI
Consumer<MyProvider>(
  builder: (context, provider, child) {
    return Text(provider.data);
  },
)
```

## ✅ Checklist for New Features

- [ ] Create model if needed (`models/`)
- [ ] Add state to provider (`providers/`)
- [ ] Create service if needed (`services/`)
- [ ] Build UI component (`widgets/`)
- [ ] Add screen or update existing (`screens/`)
- [ ] Update navigation in `app.dart`
- [ ] Test on device
- [ ] Run `flutter analyze`
- [ ] Format code with `flutter format`

## 🎨 TextStyle Presets

```dart
// Large title
TextStyle(fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 0.4)

// Section title
TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white)

// Body text
TextStyle(color: Colors.white70, fontSize: 14)

// Subtitle
TextStyle(color: Colors.white54, fontSize: 12)

// Futuristic title
TextStyle(fontFamily: 'Orbitron', fontSize: 32, letterSpacing: 1.2)
```

## 📦 Asset Paths

```dart
// Images
Image.asset('assets/images/filename.png')

// Icons
Icon(Icons.pdf_icon_name)

// Custom fonts
'fontFamily': 'Orbitron' // in TextStyle
```

## 🔐 Permission Handling

```dart
// Request storage permission
PermissionStatus status = await Permission.storage.request();
if (status.isGranted) {
  // Access granted
} else if (status.isDenied) {
  // Access denied
}
```

## 🎬 Animation Templates

```dart
// Slide transition
SlideTransition(
  position: animation.drive(tween),
  child: widget,
)

// Fade transition
FadeTransition(opacity: animation, child: widget)

// Scale animation
ScaleTransition(scale: animation, child: widget)

// Rotation animation
RotationTransition(turns: animation, child: widget)
```

## 📊 Key Metrics

| Metric | Target |
|--------|--------|
| Frame Rate | 60 fps |
| Startup Time | < 1s |
| Memory | < 150MB |
| APK Size | < 50MB |
| Build Time | < 60s |

## 🆘 Common Issues & Fixes

```bash
# Build fails - clean and rebuild
flutter clean && flutter pub get && flutter run

# Hot reload not working
# → Stop and restart: flutter run

# Permissions not working
# → Check AndroidManifest.xml and Info.plist

# PDF not rendering
# → Ensure Syncfusion license (trial is ok)

# Slow performance
# → Use flutter run --profile to analyze
```

---

**For more info: See SETUP_GUIDE.md and ARCHITECTURE.md**
