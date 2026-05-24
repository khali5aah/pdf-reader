import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../models/pdf_document.dart';
import '../providers/app_provider.dart';
import '../providers/pdf_provider.dart';
import '../widgets/glass_card.dart';
import '../widgets/thumbnail_slider.dart';

class PdfReaderScreen extends StatefulWidget {
  static const String routeName = '/reader';
  final PdfDocument document;

  const PdfReaderScreen({super.key, required this.document});

  @override
  State<PdfReaderScreen> createState() => _PdfReaderScreenState();
}

class _PdfReaderScreenState extends State<PdfReaderScreen> {
  final PdfViewerController _pdfController = PdfViewerController();
  final TextEditingController _searchController = TextEditingController();
  bool _fullscreen = false;
  bool _showControls = true;
  int _currentPage = 1;
  int _pageCount = 0;

  @override
  void initState() {
    super.initState();
    _currentPage = 1;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PdfProvider>(context, listen: false).openDocument(widget.document);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _pdfController.dispose();
    _setSystemUIVisible();
    super.dispose();
  }

  Future<void> _toggleFullscreen() async {
    setState(() => _fullscreen = !_fullscreen);
    if (_fullscreen) {
      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    } else {
      await _setSystemUIVisible();
    }
  }

  Future<void> _setSystemUIVisible() async {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  void _onPageChanged(PdfPageChangedDetails details) {
    setState(() {
      _currentPage = details.newPageNumber;
    });
    Provider.of<AppProvider>(context, listen: false).updatePagesRead(1);
  }

  void _toggleBookmark() {
    Provider.of<PdfProvider>(context, listen: false).addBookmark(widget.document.filePath, _currentPage);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Bookmark added'), backgroundColor: Color(0xFF3F73FF)));
  }

  void _searchText() {
    final term = _searchController.text.trim();
    if (term.isEmpty) return;
    _pdfController.searchText(term);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          GestureDetector(
            onTap: () => setState(() => _showControls = !_showControls),
            child: SfPdfViewer.file(
              File(widget.document.filePath),
              controller: _pdfController,
              onTextSelectionChanged: (details) {},
              onDocumentLoaded: (info) {
                setState(() => _pageCount = info.document.pages.count);
              },
              onPageChanged: _onPageChanged,
            ),
          ),
          if (_showControls)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: GlassCard(
                margin: const EdgeInsets.all(12),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(widget.document.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                      ),
                      IconButton(
                        icon: const Icon(Icons.fullscreen, color: Colors.white),
                        onPressed: _toggleFullscreen,
                      ),
                      IconButton(
                        icon: const Icon(Icons.bookmark_add, color: Colors.white),
                        onPressed: _toggleBookmark,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          if (_showControls)
            Positioned(
              bottom: 12,
              left: 12,
              right: 12,
              child: GlassCard(
                margin: const EdgeInsets.symmetric(vertical: 0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              style: const TextStyle(color: Colors.white),
                              cursorColor: const Color(0xFF3F73FF),
                              decoration: InputDecoration(
                                hintText: 'Search inside document',
                                hintStyle: const TextStyle(color: Colors.white54),
                                filled: true,
                                fillColor: const Color(0xFF0B1630),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.search, color: Colors.white70),
                                  onPressed: _searchText,
                                ),
                              ),
                              onSubmitted: (_) => _searchText(),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ThumbnailSlider(
                        selectedPage: _currentPage,
                        pageCount: _pageCount,
                        onPageSelected: (page) {
                          _pdfController.jumpToPage(page);
                        },
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Page $_currentPage / $_pageCount', style: const TextStyle(color: Colors.white70)),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.chevron_left, color: Colors.white),
                                onPressed: () {
                                  _pdfController.previousPage();
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.chevron_right, color: Colors.white),
                                onPressed: () {
                                  _pdfController.nextPage();
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          if (_showControls)
            Positioned(
              right: 22,
              top: 120,
              child: GlassCard(
                margin: const EdgeInsets.symmetric(vertical: 0),
                child: Column(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_upward, color: Colors.white),
                      onPressed: () => _pdfController.jumpToPage(1),
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_downward, color: Colors.white),
                      onPressed: () => _pdfController.jumpToPage(_pageCount),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
