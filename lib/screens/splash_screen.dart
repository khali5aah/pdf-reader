import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(vsync: this, duration: const Duration(seconds: 2))
      ..repeat(reverse: true);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AppProvider>(context, listen: false).registerSession();
      Timer(const Duration(milliseconds: 1850), _navigateHome);
    });
  }

  void _navigateHome() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const HomeScreen(),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF02030D), Color(0xFF091328), Color(0xFF11192E)],
          ),
        ),
        child: Center(
          child: ScaleTransition(
            scale: Tween(begin: 0.9, end: 1.05).animate(CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    gradient: const LinearGradient(colors: [Color(0xFF3F73FF), Color(0xFF9B5CFF)]),
                    boxShadow: [
                      BoxShadow(color: Colors.blue.withValues(alpha: 0.35), blurRadius: 24, spreadRadius: 2),
                    ],
                  ),
                  child: const Icon(Icons.picture_as_pdf, size: 64, color: Colors.white),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Neon Archive',
                  style: TextStyle(fontFamily: 'Orbitron', fontSize: 32, color: Colors.white, letterSpacing: 1.2),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Futuristic PDF Reader',
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
