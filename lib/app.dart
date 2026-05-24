import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/app_provider.dart';
import 'screens/home_screen.dart';
import 'screens/pdf_reader_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/splash_screen.dart';
import 'themes/app_theme.dart';

class FuturisticPdfApp extends StatelessWidget {
  const FuturisticPdfApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(builder: (context, appState, child) {
      return MaterialApp(
        title: 'Cyber PDF Reader',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: appState.themeMode,
        home: const SplashScreen(),
        onGenerateRoute: (settings) {
          Widget page = const HomeScreen();
          if (settings.name == PdfReaderScreen.routeName) {
            page = PdfReaderScreen(document: settings.arguments as dynamic);
          } else if (settings.name == SettingsScreen.routeName) {
            page = const SettingsScreen();
          }
          return PageRouteBuilder(
            pageBuilder: (_, animation, secondaryAnimation) => page,
            transitionsBuilder: (_, animation, secondaryAnimation, child) {
              const begin = Offset(0.0, 0.1);
              const end = Offset.zero;
              const curve = Curves.easeOutQuad;
              final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              return SlideTransition(
                position: animation.drive(tween),
                child: FadeTransition(opacity: animation, child: child),
              );
            },
          );
        },
      );
    });
  }
}
