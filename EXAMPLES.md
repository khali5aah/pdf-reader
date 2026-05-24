# Code Examples & Implementation Patterns

## Adding PDF to Recent List

```dart
// In home_screen.dart, when opening a PDF
void _openPdf(BuildContext context, PdfDocument document, PdfProvider pdfState) {
  // Add to recent list
  pdfState.openDocument(document);
  
  // Navigate to reader
  Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => PdfReaderScreen(document: document)),
  );
}

// Provider handles the rest
// Provider.openDocument() → adds to recent → notifies listeners → updates UI
```

## Implementing Search

```dart
// In PdfProvider
void updateSearchQuery(String text) {
  searchQuery = text;
  notifyListeners(); // Trigger UI rebuild with filtered results
}

// In HomeScreen - results are computed
final visibleDocuments = pdfState.searchQuery.isEmpty
    ? pdfState.allPdfs
    : pdfState.allPdfs.where((doc) => 
        doc.name.toLowerCase().contains(pdfState.searchQuery.toLowerCase())
      ).toList();
```

## Creating a New Screen

### Step 1: Create Screen File
```dart
// lib/screens/my_new_screen.dart
import 'package:flutter/material.dart';

class MyNewScreen extends StatelessWidget {
  static const String routeName = '/my-screen';
  
  const MyNewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Screen')),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF050812), Color(0xFF11192E)],
          ),
        ),
        child: const Center(child: Text('Coming Soon')),
      ),
    );
  }
}
```

### Step 2: Register Route
```dart
// In app.dart
onGenerateRoute: (settings) {
  Widget page = const HomeScreen();
  if (settings.name == PdfReaderScreen.routeName) {
    page = PdfReaderScreen(document: settings.arguments as dynamic);
  } else if (settings.name == MyNewScreen.routeName) {  // Add this
    page = const MyNewScreen();
  }
  // ... rest of routing
}
```

### Step 3: Navigate to It
```dart
// From any screen
Navigator.pushNamed(context, MyNewScreen.routeName);
```

## Adding a New Provider

### Step 1: Create Provider
```dart
// lib/providers/reading_history_provider.dart
import 'package:flutter/material.dart';

class ReadingHistoryProvider extends ChangeNotifier {
  List<String> history = [];

  void addToHistory(String documentPath) {
    history.add(documentPath);
    if (history.length > 20) {
      history.removeAt(0); // Keep last 20
    }
    notifyListeners();
  }

  void clearHistory() {
    history.clear();
    notifyListeners();
  }
}
```

### Step 2: Register in main.dart
```dart
MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (_) => AppProvider()),
    ChangeNotifierProvider(create: (_) => PdfProvider()),
    ChangeNotifierProvider(create: (_) => ReadingHistoryProvider()), // Add
  ],
  child: const FuturisticPdfApp(),
)
```

### Step 3: Use in Widgets
```dart
// Access provider
Consumer<ReadingHistoryProvider>(
  builder: (context, provider, child) {
    return ListView.builder(
      itemCount: provider.history.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(provider.history[index]),
        );
      },
    );
  },
)

// Call provider method
Provider.of<ReadingHistoryProvider>(context, listen: false)
  .addToHistory(documentPath);
```

## Creating a Custom Widget

### Step 1: Define Widget
```dart
// lib/widgets/my_custom_widget.dart
import 'package:flutter/material.dart';
import '../themes/app_theme.dart';

class MyCustomWidget extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const MyCustomWidget({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: AppTheme.card,
          border: Border.all(color: AppTheme.border),
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
```

### Step 2: Use Widget
```dart
import '../widgets/my_custom_widget.dart';

MyCustomWidget(
  title: 'Click Me',
  onTap: () => print('Clicked!'),
)
```

## Handling Permissions

```dart
// In file_service.dart
Future<bool> _requestStoragePermission() async {
  final status = await Permission.storage.request();
  
  if (status.isGranted) {
    return true;
  } else if (status.isDenied) {
    // User denied - request again
    await Permission.storage.request();
    return Permission.storage.isGranted;
  } else if (status.isPermanentlyDenied) {
    // Open app settings
    openAppSettings();
    return false;
  }
  
  return false;
}

// Usage
if (await _requestStoragePermission()) {
  // Proceed with file access
}
```

## Working with Hive Storage

```dart
// Saving data
Future<void> saveMyData(String key, String value) async {
  final box = Hive.box('my_box_name');
  await box.put(key, value);
}

// Loading data
Future<String?> getMyData(String key) async {
  final box = Hive.box('my_box_name');
  return box.get(key) as String?;
}

// Deleting data
Future<void> deleteMyData(String key) async {
  final box = Hive.box('my_box_name');
  await box.delete(key);
}

// List all keys
List<String> getAllKeys() {
  final box = Hive.box('my_box_name');
  return box.keys.cast<String>().toList();
}
```

## Implementing PDF Search

```dart
// In PdfReaderScreen
void _searchText() {
  final term = _searchController.text.trim();
  if (term.isEmpty) return;
  
  // Built-in Syncfusion search
  _pdfController.searchText(term);
}

// UI
TextField(
  controller: _searchController,
  decoration: InputDecoration(
    hintText: 'Search inside document',
    suffixIcon: IconButton(
      icon: const Icon(Icons.search),
      onPressed: _searchText,
    ),
  ),
  onSubmitted: (_) => _searchText(),
)
```

## Theme Customization

```dart
// Modify app_theme.dart
class AppTheme {
  // Add custom colors
  static const Color customNeon = Color(0xFF00FF00);
  
  // Update theme
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: customNeon,
    colorScheme: ColorScheme.dark(
      primary: customNeon,
      secondary: Color(0xFF123456),
    ),
    textTheme: Typography.whiteMountainView.copyWith(
      bodyLarge: TextStyle(
        color: customNeon,
        fontFamily: 'CustomFont',
      ),
    ),
  );
}
```

## Error Handling Pattern

```dart
// Safe async operation
Future<void> openPdfSafely(String path) async {
  try {
    if (!File(path).existsSync()) {
      throw Exception('File not found');
    }
    
    final doc = PdfDocument(
      filePath: path,
      name: path.split('/').last,
      size: File(path).lengthSync(),
      updatedAt: File(path).lastModifiedSync(),
    );
    
    // Success - proceed
    if (mounted) Navigator.push(context, ...);
    
  } on FileSystemException catch (e) {
    _showError('Cannot access file: $e');
  } on Exception catch (e) {
    _showError('Error: $e');
  }
}

void _showError(String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 2),
    ),
  );
}
```

## Sorting Implementation

```dart
// In PdfProvider
void setSortBy(String field) {
  sortBy = field;
  allPdfs = _sortDocuments(allPdfs);
  notifyListeners();
}

List<PdfDocument> _sortDocuments(List<PdfDocument> documents) {
  final sorted = [...documents]; // Create copy
  
  if (sortBy == 'Name') {
    sorted.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
  } else if (sortBy == 'Size') {
    sorted.sort((a, b) => b.size.compareTo(a.size)); // Descending
  } else {
    sorted.sort((a, b) => b.updatedAt.compareTo(a.updatedAt)); // Recent first
  }
  
  return sorted;
}

// UI - Show sort options
void _showSortSheet(BuildContext context, PdfProvider pdfState) {
  showModalBottomSheet(
    context: context,
    builder: (_) => Column(
      children: Constants.sortFields.map((field) {
        return RadioListTile<String>(
          value: field,
          groupValue: pdfState.sortBy,
          title: Text(field),
          onChanged: (value) {
            pdfState.setSortBy(value!);
            Navigator.pop(context);
          },
        );
      }).toList(),
    ),
  );
}
```

## Animations Examples

```dart
// Fade transition
class FadePageRoute extends PageRouteBuilder {
  FadePageRoute({required Widget page})
      : super(
          pageBuilder: (_, __, ___) => page,
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        );
}

// Slide transition
class SlidePageRoute extends PageRouteBuilder {
  SlidePageRoute({required Widget page})
      : super(
          pageBuilder: (_, __, ___) => page,
          transitionsBuilder: (_, animation, __, child) {
            return SlideTransition(
              position: animation.drive(
                Tween(begin: Offset(1, 0), end: Offset.zero)
                  .chain(CurveTween(curve: Curves.easeOutQuad)),
              ),
              child: child,
            );
          },
        );
}

// Scale animation
class ScalePageRoute extends PageRouteBuilder {
  ScalePageRoute({required Widget page})
      : super(
          pageBuilder: (_, __, ___) => page,
          transitionsBuilder: (_, animation, __, child) {
            return ScaleTransition(scale: animation, child: child);
          },
        );
}

// Usage
Navigator.push(context, FadePageRoute(page: MyScreen()));
```

## Bookmark Management

```dart
// Add bookmark
Future<void> addBookmark(int page) async {
  await Provider.of<PdfProvider>(context, listen: false).addBookmark(
    widget.document.filePath,
    page,
  );
  
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Bookmarked page $page')),
  );
}

// Load bookmarks
List<Bookmark> getBookmarks() {
  return Provider.of<PdfProvider>(context, listen: false)
    .loadBookmarksForFile(widget.document.filePath);
}

// Display bookmarks
ListView(
  children: getBookmarks().map((bookmark) {
    return ListTile(
      title: Text('Page ${bookmark.page}'),
      subtitle: Text(bookmark.createdAt.toString()),
      onTap: () {
        _pdfController.jumpToPage(bookmark.page);
      },
    );
  }).toList(),
)
```

---

These examples cover common patterns and use cases for extending and customizing the application.
