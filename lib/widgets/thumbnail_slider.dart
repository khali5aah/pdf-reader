import 'package:flutter/material.dart';

class ThumbnailSlider extends StatelessWidget {
  final int selectedPage;
  final int pageCount;
  final ValueChanged<int> onPageSelected;

  const ThumbnailSlider({super.key, required this.selectedPage, required this.pageCount, required this.onPageSelected});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: pageCount.clamp(0, 10),
        itemBuilder: (context, index) {
          final page = index + 1;
          final selected = page == selectedPage;
          return GestureDetector(
            onTap: () => onPageSelected(page),
            child: Container(
              width: 62,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: selected ? const Color(0xFF3F73FF) : const Color(0xFF0D1629),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: selected ? const Color(0xFF9B5CFF) : Colors.white12),
              ),
              child: Center(
                child: Text(
                  '$page',
                  style: TextStyle(color: selected ? Colors.white : Colors.white54, fontWeight: selected ? FontWeight.w700 : FontWeight.w500),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
