import 'package:hive_flutter/hive_flutter.dart';
import '../models/bookmark.dart';
import '../models/pdf_document.dart';
import '../utils/constants.dart';

class StorageService {
  static const String recentBox = Constants.recentBox;
  static const String favoritesBox = Constants.favoritesBox;
  static const String bookmarksBox = Constants.bookmarksBox;
  static const String settingsBox = Constants.settingsBox;

  static Future<void> init() async {
    await Hive.openBox(recentBox);
    await Hive.openBox(favoritesBox);
    await Hive.openBox(bookmarksBox);
    await Hive.openBox(settingsBox);
  }

  static Future<List<PdfDocument>> loadDocumentList(String boxName) async {
    final box = Hive.box(boxName);
    final raw = box.get('items', defaultValue: []) as List<dynamic>;
    return raw
        .whereType<Map<dynamic, dynamic>>()
        .map((item) => PdfDocument.fromMap(Map<String, dynamic>.from(item)))
        .toList();
  }

  static Future<void> saveDocumentList(String boxName, List<PdfDocument> items) async {
    final box = Hive.box(boxName);
    await box.put('items', items.map((item) => item.toMap()).toList());
  }

  static Future<Map<String, List<Bookmark>>> loadBookmarks() async {
    final box = Hive.box(bookmarksBox);
    final data = <String, List<Bookmark>>{};
    for (final key in box.keys) {
      final entry = box.get(key, defaultValue: []) as List<dynamic>;
      data[key as String] = entry
          .whereType<Map<dynamic, dynamic>>()
          .map((item) => Bookmark.fromMap(Map<String, dynamic>.from(item)))
          .toList();
    }
    return data;
  }

  static Future<void> saveBookmarkList(String documentPath, List<Bookmark> bookmarks) async {
    final box = Hive.box(bookmarksBox);
    await box.put(documentPath, bookmarks.map((bookmark) => bookmark.toMap()).toList());
  }

  static Future<Map<String, dynamic>> getSettings() async {
    final box = Hive.box(settingsBox);
    final raw = box.toMap().cast<String, dynamic>();
    return raw;
  }

  static Future<void> saveSettings(Map<String, dynamic> settings) async {
    final box = Hive.box(settingsBox);
    for (final entry in settings.entries) {
      await box.put(entry.key, entry.value);
    }
  }
}
