import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../widgets/glass_card.dart';

class SettingsScreen extends StatelessWidget {
  static const String routeName = '/settings';

  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(builder: (context, appState, child) {
      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text('Settings'),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomRight,
              colors: [Color(0xFF050812), Color(0xFF11192E)],
            ),
          ),
          child: SafeArea(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
              children: [
                const SizedBox(height: 10),
                GlassCard(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Display mode', style: TextStyle(color: Colors.white70, fontSize: 14)),
                        const SizedBox(height: 10),
                        SwitchListTile(
                          title: const Text('Dark mode', style: TextStyle(color: Colors.white)),
                          value: appState.themeMode == ThemeMode.dark,
                          activeThumbColor: const Color(0xFF9B5CFF),
                          onChanged: (_) => appState.toggleTheme(),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                GlassCard(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Reading statistics', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
                        const SizedBox(height: 12),
                        _buildStatRow('Open sessions', appState.openSessions.toString()),
                        const SizedBox(height: 10),
                        _buildStatRow('Pages read', appState.totalPagesRead.toString()),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                GlassCard(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Support', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
                        SizedBox(height: 12),
                        Text('Use the drawer to open files and customize the app theme. Keep your library neon and sharp.', style: TextStyle(color: Colors.white54)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildStatRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.white54, fontSize: 14)),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700)),
      ],
    );
  }
}
