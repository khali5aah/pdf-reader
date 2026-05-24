import 'dart:async';

import 'package:flutter/material.dart';
import '../models/bookmark.dart';
import '../models/pdf_document.dart';
import '../services/file_service.dart';
import '../services/storage_service.dart';

class PdfProvider extends ChangeNotifier {
  List<PdfDocument> allPdfs = [];
  List<PdfDocument> recentPdfs = [];
  List<PdfDocument> favorites = [];
  Map<String, List<Bookmark>> bookmarks = {};
  bool isLoading = false;
  bool isScanning = false;
  String searchQuery = '';
  String sortBy = 'Date';

  PdfProvider() {
    _loadLocalState();
    scanStorage();
  }

  Future<void> _loadLocalState() async {
    recentPdfs = await StorageService.loadDocumentList(StorageService.recentBox);
    favorites = await StorageService.loadDocumentList(StorageService.favoritesBox);
    bookmarks = await StorageService.loadBookmarks();
    notifyListeners();
  }

  Future<void> scanStorage() async {
    isScanning = true;
    notifyListeners();
    final files = await FileService.scanPdfFiles();
    allPdfs = _sortDocuments(files);
    isScanning = false;
    notifyListeners();
  }

  List<PdfDocument> _sortDocuments(List<PdfDocument> documents) {
    final sorted = [...documents];
    if (sortBy == 'Name') {
      sorted.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    } else if (sortBy == 'Size') {
      sorted.sort((a, b) => b.size.compareTo(a.size));
    } else {
      sorted.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    }
    return sorted;
  }

  void setSortBy(String field) {
    sortBy = field;
    allPdfs = _sortDocuments(allPdfs);
    notifyListeners();
  }

  void updateSearchQuery(String text) {
    searchQuery = text;
    notifyListeners();
  }

  void addRecent(PdfDocument document) {
    recentPdfs.removeWhere((item) => item.filePath == document.filePath);
    recentPdfs.insert(0, document);
    if (recentPdfs.length > 10) {
      recentPdfs = recentPdfs.sublist(0, 10);
    }
    StorageService.saveDocumentList(StorageService.recentBox, recentPdfs);
    notifyListeners();
  }

  void toggleFavorite(PdfDocument document) {
    final exists = favorites.any((item) => item.filePath == document.filePath);
    if (exists) {
      favorites.removeWhere((item) => item.filePath == document.filePath);
    } else {
      favorites.insert(0, document);
    }
    StorageService.saveDocumentList(StorageService.favoritesBox, favorites);
    notifyListeners();
  }

  bool isFavorite(PdfDocument document) {
    return favorites.any((item) => item.filePath == document.filePath);
  }

  Future<void> addBookmark(String filePath, int page) async {
    final documentBookmarks = bookmarks[filePath] ?? [];
    if (!documentBookmarks.any((bookmark) => bookmark.page == page)) {
      documentBookmarks.add(Bookmark(documentPath: filePath, page: page));
      bookmarks[filePath] = documentBookmarks;
      await StorageService.saveBookmarkList(filePath, documentBookmarks);
      notifyListeners();
    }
  }

  List<Bookmark> loadBookmarksForFile(String filePath) {
    return bookmarks[filePath] ?? [];
  }

  Future<void> openDocument(PdfDocument document) async {
    addRecent(document);
    notifyListeners();
  }

  Future<PdfDocument?> openExternalPdf() async {
    final file = await FileService.pickPdfFile();
    if (file == null) return null;
    final document = PdfDocument(
      filePath: file.path,
      name: file.path.split('/').last,
      size: file.lengthSync(),
      updatedAt: file.lastModifiedSync(),
    );
    if (!allPdfs.any((item) => item.filePath == document.filePath)) {
      allPdfs.insert(0, document);
    }
    addRecent(document);
    return document;
  }
}
