import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/pdf_provider.dart';

class SearchInput extends StatelessWidget {
  const SearchInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PdfProvider>(builder: (context, pdfState, child) {
      return TextField(
        onChanged: pdfState.updateSearchQuery,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Search library',
          hintStyle: const TextStyle(color: Colors.white54),
          prefixIcon: const Icon(Icons.search, color: Colors.white54),
          filled: true,
          fillColor: const Color(0xFF0C1631),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(22), borderSide: BorderSide.none),
        ),
      );
    });
  }
}
