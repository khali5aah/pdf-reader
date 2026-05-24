import 'package:flutter/material.dart';

class FuturisticAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const FuturisticAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: const TextStyle(fontFamily: 'Orbitron', letterSpacing: 0.5)),
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
      actions: [
        IconButton(
          icon: const Icon(Icons.menu, color: Colors.white70),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(72);
}
