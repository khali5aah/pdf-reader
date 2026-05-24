import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String actionText;
  final VoidCallback onActionTap;

  const SectionHeader({super.key, required this.title, required this.actionText, required this.onActionTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700))),
        GestureDetector(
          onTap: onActionTap,
          child: Text(actionText, style: const TextStyle(color: Color(0xFF9B5CFF), fontSize: 14, fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }
}
