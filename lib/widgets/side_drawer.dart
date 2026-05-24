import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../screens/settings_screen.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF070B14),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Neon Menu', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700)),
                  SizedBox(height: 6),
                  Text('Navigate and customize the experience', style: TextStyle(color: Colors.white54, fontSize: 12)),
                ],
              ),
            ),
            const Divider(color: Colors.white12),
            _buildDrawerItem(context, icon: Icons.dashboard, title: 'Home', onTap: () => Navigator.pop(context)),
            _buildDrawerItem(context, icon: Icons.star_border, title: 'Favorites', onTap: () => Navigator.pop(context)),
            _buildDrawerItem(context, icon: Icons.settings, title: 'Settings', onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, SettingsScreen.routeName);
            }),
            _buildDrawerItem(context, icon: Icons.share, title: 'Theme', onTap: () => Provider.of<AppProvider>(context, listen: false).toggleTheme()),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFF121A2F),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text('Powered by neon UI and smooth transitions.', style: TextStyle(color: Colors.white54, fontSize: 12)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context, {required IconData icon, required String title, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.white70),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: onTap,
      hoverColor: const Color(0xFF1E2B4A),
    );
  }
}
