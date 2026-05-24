import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../screens/settings_screen.dart';

class FuturisticBottomNav extends StatelessWidget {
  const FuturisticBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(builder: (context, appState, child) {
      return BottomNavigationBar(
        currentIndex: appState.bottomTabIndex,
        backgroundColor: const Color(0xFF080F1E),
        selectedItemColor: const Color(0xFF6B7BFF),
        unselectedItemColor: Colors.white54,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          appState.setBottomTab(value);
          if (value == 2) {
            Navigator.pushNamed(context, SettingsScreen.routeName);
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), label: 'Settings'),
        ],
      );
    });
  }
}
