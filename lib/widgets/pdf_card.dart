import 'package:flutter/material.dart';
import '../models/pdf_document.dart';
import 'glass_card.dart';

class PdfCard extends StatelessWidget {
  final PdfDocument document;
  final VoidCallback? onTap;
  final String? tag;

  const PdfCard({super.key, required this.document, this.onTap, this.tag});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: InkWell(
        borderRadius: BorderRadius.circular(28),
        onTap: onTap,
        child: Container(
          width: 210,
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: tag ?? document.filePath,
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    gradient: const LinearGradient(colors: [Color(0xFF3F73FF), Color(0xFF9B5CFF)]),
                  ),
                  child: const Icon(Icons.picture_as_pdf, color: Colors.white, size: 30),
                ),
              ),
              const SizedBox(height: 18),
              Text(document.name, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
              const Spacer(),
              Text('${document.name} • ${document.size ~/ 1024}KB', style: const TextStyle(color: Colors.white54, fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }
}
