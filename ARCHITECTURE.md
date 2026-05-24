# Futuristic PDF Reader - Code Architecture

## 📐 Architecture Overview

This Flutter application follows **Clean Architecture** with clear separation of concerns:

```
Presentation Layer (UI)
        ↓
State Management Layer (Provider)
        ↓
Business Logic Layer (Services)
        ↓
Data Layer (Models & Storage)
```

## 🏗 Layer Breakdown

### 1. **Data Layer** (`models/`, `services/`)

**Models** define data structures:
- `PdfDocument`: Represents a PDF file with metadata
- `Bookmark`: Stores page bookmarks for PDFs

**Services** handle data persistence and filesystem:
- `StorageService`: Hive database operations (CRUD)
- `FileService`: PDF scanning and file picking

### 2. **State Management Layer** (`providers/`)

Using **Provider** pattern for reactive state:

- `AppProvider`: Global app state (theme, statistics)
- `PdfProvider`: PDF management state (documents, favorites, recent)

**Benefits**:
- No boilerplate code
- Automatic UI rebuilds on state change
- Efficient rebuild with Consumer widgets
- Easy to test

### 3. **Presentation Layer** (`screens/`, `widgets/`)

**Screens**: Full-page UI components
- `SplashScreen`: Animated entry point
- `HomeScreen`: Main dashboard
- `PdfReaderScreen`: PDF viewer interface
- `SettingsScreen`: App preferences

**Widgets**: Reusable components
- `GlassCard`: Glassmorphism container
- `PdfCard`: Document card
- `AnimatedLoader`: Loading indicator
- Navigation & UI components

### 4. **Theme & Utils**

- `AppTheme`: Centralized Material 3 theme
- `Constants`: App-wide constants
- `Formatters`: Utility functions

## 🔄 Data Flow

### Opening a PDF
```
UI (HomeScreen)
  ↓ (User tap)
PdfProvider.openExternalPdf()
  ↓
FileService.pickPdfFile()
  ↓ (File selected)
PdfProvider.addRecent()
  ↓
StorageService.saveDocumentList()
  ↓
UI Rebuilds (Consumer listens to PdfProvider)
```

### Reading Statistics
```
PdfReaderScreen._onPageChanged()
  ↓
AppProvider.updatePagesRead()
  ↓
StorageService.saveSettings()
  ↓
AppProvider notifies listeners
  ↓
UI updates stats
```

## 💾 Data Persistence

**Hive Storage Structure**:
```
┌─ recent_pdfs (List<PdfDocument>)
│  └─ items: []
├─ favorite_pdfs (List<PdfDocument>)
│  └─ items: []
├─ pdf_bookmarks (Map<String, List<Bookmark>>)
│  └─ /path/to/pdf.pdf: [Bookmark, Bookmark...]
└─ app_settings (Map<String, dynamic>)
   ├─ useDarkMode: true
   ├─ pagesRead: 4250
   └─ openSessions: 3
```

## 🎨 UI Component Hierarchy

```
MaterialApp
├─ SplashScreen
│  └─ Animated Container
├─ Home
│  ├─ Scaffold
│  │  ├─ AppBar (Futuristic)
│  │  ├─ DrawerWidget (Side Navigation)
│  │  ├─ Body (SafeArea + ListView)
│  │  │  ├─ SearchInput
│  │  │  ├─ OverviewCard (GlassCard)
│  │  │  ├─ RecentCarousel
│  │  │  │  └─ PdfCard[]
│  │  │  ├─ FavoritesGrid
│  │  │  │  └─ PdfCard[]
│  │  │  └─ DocumentList
│  │  │     └─ GlassCard[DocumentItem]
│  │  ├─ BottomNavigationBar
│  │  └─ FloatingActionButton
├─ PdfReaderScreen
│  ├─ Stack
│  │  ├─ SfPdfViewer
│  │  ├─ Top Controls (GlassCard + Toolbar)
│  │  ├─ Bottom Controls (Search + Navigation)
│  │  └─ Quick Navigation (Right Side)
└─ SettingsScreen
   ├─ Scaffold
   └─ GlassCard[SettingsItem][]
```

## 🔐 State Management Pattern

### Provider Usage Example

**Reading State**:
```dart
// Listen to changes
Consumer<PdfProvider>(
  builder: (context, pdfState, child) {
    return Text('Recents: ${pdfState.recentPdfs.length}');
  },
)

// Multiple providers
Consumer2<PdfProvider, AppProvider>(
  builder: (context, pdfState, appState, child) {
    // Access both providers
  },
)
```

**Modifying State**:
```dart
// Direct method calls
Provider.of<PdfProvider>(context, listen: false).toggleFavorite(doc);

// From within provider
notifyListeners(); // Trigger UI rebuild
```

## 🎯 Key Design Patterns

### 1. **Separation of Concerns**
- Business logic in providers
- UI in widgets/screens
- Data operations in services
- Styling in themes

### 2. **Reactive Programming**
- State changes trigger UI updates
- No manual setState calls
- Automatic rebuild optimization

### 3. **Dependency Injection**
- Provider-based DI via MultiProvider
- Services injected at app level
- Easy to mock for testing

### 4. **Model-Driven UI**
- UI driven by data models
- Single source of truth
- Predictable updates

## 🧪 Testing Strategy

### Unit Tests
```dart
test('PdfProvider sorts documents by name', () {
  final provider = PdfProvider();
  provider.setSortBy('Name');
  // Assert ordering
});
```

### Widget Tests
```dart
testWidgets('HomeScreen displays PDFs', (WidgetTester tester) async {
  await tester.pumpWidget(const FuturisticPdfApp());
  expect(find.byType(PdfCard), findsWidgets);
});
```

### Integration Tests
- End-to-end user flows
- Permission handling
- Database operations

## 🚀 Performance Considerations

### Optimization Techniques

1. **Lazy Loading**: Documents loaded on demand
2. **Caching**: Recent files cached in memory
3. **Efficient Rebuilds**: Consumer only rebuilds when data changes
4. **Async Operations**: File scanning in background

### Memory Management
- Limited recent files list (10 items max)
- PDF caching by Syncfusion
- Proper disposal of resources

### Build Optimization
- Const constructors throughout
- Minimal UI rebuilds
- Efficient layout algorithms

## 🔒 Error Handling

```dart
// Safe async operations
try {
  final file = await FileService.pickPdfFile();
  if (file != null) {
    // Process file
  }
} catch (e) {
  // Handle error
  ScaffoldMessenger.of(context).showSnackBar(...);
}
```

## 📱 Responsive Design

### Breakpoints
- **Mobile**: < 600dp
- **Tablet**: 600dp - 900dp
- **Desktop**: > 900dp

### Flexible Widgets
```dart
Expanded(
  child: Container() // Takes available space
)

SizedBox.expand() // Fill parent
ConstrainedBox() // Min/max constraints
```

## 🎨 Theme System

**Dark Theme Only** (optimized for cyberpunk aesthetic):
- Dynamic color transitions
- Consistent branding
- Material 3 compliance
- Accessibility considerations

## 📊 State Flow Diagram

```
┌─────────────┐
│   UI Event  │
└──────┬──────┘
       │
       ▼
┌─────────────────────────┐
│  Provider Method Call   │
├─────────────────────────┤
│ (e.g., toggleFavorite) │
└──────┬──────────────────┘
       │
       ▼
┌──────────────────────┐
│ Update Internal State│
└──────┬───────────────┘
       │
       ▼
┌──────────────────────┐
│ Persist to Storage   │
│ (Hive DB)           │
└──────┬───────────────┘
       │
       ▼
┌──────────────────────┐
│ Call notifyListeners()│
└──────┬───────────────┘
       │
       ▼
┌──────────────────────┐
│ Consumer Rebuilds UI │
└──────────────────────┘
```

## 🔧 Extension Points

### Adding New Features

1. **New Provider (e.g., ReadingHistory)**
   - Create `reading_history_provider.dart`
   - Extend with state and methods
   - Add to `MultiProvider` in main.dart

2. **New Screen**
   - Create `screens/new_screen.dart`
   - Add route to `app.dart`
   - Add navigation button

3. **New Storage**
   - Add Hive box in `StorageService.init()`
   - Add getter/setter methods
   - Use in providers

## 🎓 Learning Resources

- **Provider**: https://pub.dev/packages/provider
- **Hive**: https://pub.dev/packages/hive
- **Flutter Architecture**: https://flutter.dev/docs/development/architecture
- **Clean Code**: Robert C. Martin "Clean Architecture"

---

**Architecture designed for scalability, maintainability, and performance.**
