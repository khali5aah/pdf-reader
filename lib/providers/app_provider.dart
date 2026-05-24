import 'package:flutter/material.dart';
import '../services/storage_service.dart';

class AppProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;
  int bottomTabIndex = 0;
  int totalPagesRead = 0;
  int openSessions = 0;

  AppProvider() {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final settings = await StorageService.getSettings();
    themeMode = settings['useDarkMode'] == false ? ThemeMode.light : ThemeMode.dark;
    totalPagesRead = settings['pagesRead'] as int? ?? 0;
    openSessions = settings['openSessions'] as int? ?? 0;
    notifyListeners();
  }

  void toggleTheme() {
    themeMode = themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    StorageService.saveSettings({'useDarkMode': themeMode == ThemeMode.dark});
    notifyListeners();
  }

  void setBottomTab(int index) {
    bottomTabIndex = index;
    notifyListeners();
  }

  void registerSession() {
    openSessions += 1;
    StorageService.saveSettings({'openSessions': openSessions});
    notifyListeners();
  }

  void updatePagesRead(int count) {
    totalPagesRead += count;
    StorageService.saveSettings({'pagesRead': totalPagesRead});
    notifyListeners();
  }
}
