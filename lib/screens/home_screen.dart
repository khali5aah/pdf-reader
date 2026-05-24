import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/pdf_document.dart';
import '../providers/app_provider.dart';
import '../providers/pdf_provider.dart';
import '../widgets/animated_loader.dart';
import '../widgets/bottom_navigation.dart';
import '../widgets/futuristic_app_bar.dart';
import '../widgets/glass_card.dart';
import '../widgets/pdf_card.dart';
import '../widgets/search_bar.dart';
import '../widgets/section_header.dart';
import '../widgets/side_drawer.dart';
import '../utils/constants.dart';
import '../utils/formatters.dart';
import 'pdf_reader_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<PdfProvider, AppProvider>(builder: (context, pdfState, appState, child) {
      final visibleDocuments = pdfState.searchQuery.isEmpty
          ? pdfState.allPdfs
          : pdfState.allPdfs.where((doc) => doc.name.toLowerCase().contains(pdfState.searchQuery.toLowerCase())).toList();
      return Scaffold(
        extendBodyBehindAppBar: true,
        drawer: const SideDrawer(),
        appBar: const FuturisticAppBar(title: 'Neo Library'),
        bottomNavigationBar: const FuturisticBottomNav(),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            final document = await pdfState.openExternalPdf();
            if (document != null) {
              if (context.mounted) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => PdfReaderScreen(document: document)),
                );
              }
            }
          },
          backgroundColor: const Color(0xFF3F73FF),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          label: const Text('Open PDF'),
          icon: const Icon(Icons.upload_file_outlined),
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF02030D), Color(0xFF070B14), Color(0xFF11192E)],
            ),
          ),
          child: SafeArea(
            child: RefreshIndicator(
              color: Colors.cyanAccent,
              onRefresh: pdfState.scanStorage,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                children: [
                  const SizedBox(height: 8),
                  const SearchInput(),
                  const SizedBox(height: 18),
                  _buildOverview(context, pdfState),
                  const SizedBox(height: 20),
                  SectionHeader(
                    title: 'Recent PDFs',
                    actionText: 'View all',
                    onActionTap: () {},
                  ),
                  const SizedBox(height: 14),
                  _buildRecentCarousel(context, pdfState),
                  const SizedBox(height: 26),
                  SectionHeader(
                    title: 'Favorites',
                    actionText: 'Manage',
                    onActionTap: () => Navigator.pushNamed(context, SettingsScreen.routeName),
                  ),
                  const SizedBox(height: 14),
                  _buildFavoritesGrid(context, pdfState),
                  const SizedBox(height: 26),
                  SectionHeader(
                    title: 'All Documents',
                    actionText: 'Sort',
                    onActionTap: () => _showSortSheet(context, pdfState),
                  ),
                  const SizedBox(height: 14),
                  _buildDocumentList(context, visibleDocuments, pdfState),
                  const SizedBox(height: 26),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildOverview(BuildContext context, PdfProvider pdfState) {
    return GlassCard(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Welcome back', style: TextStyle(color: Colors.white70, fontSize: 14)),
                  const SizedBox(height: 6),
                  const Text('Your cyberpunk archive awaits', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 0.4)),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      _buildStatBubble('Recent', pdfState.recentPdfs.length.toString()),
                      const SizedBox(width: 10),
                      _buildStatBubble('Favorites', pdfState.favorites.length.toString()),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                gradient: const LinearGradient(colors: [Color(0xFF3F73FF), Color(0xFF9B5CFF)]),
              ),
              child: const Icon(Icons.auto_stories_rounded, size: 42, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildStatBubble(String label, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF121E38).withValues(alpha: 0.85),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFF3F73FF).withValues(alpha: 0.25)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(color: Colors.white54, fontSize: 12)),
            const SizedBox(height: 6),
            Text(value, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentCarousel(BuildContext context, PdfProvider pdfState) {
    if (pdfState.recentPdfs.isEmpty) {
      return const GlassCard(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Center(child: Text('No recent files yet. Open a PDF to start reading.', style: TextStyle(color: Colors.white54))),
        ),
      );
    }
    return SizedBox(
      height: 190,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: pdfState.recentPdfs.length,
        separatorBuilder: (_, __) => const SizedBox(width: 14),
        itemBuilder: (_, index) {
          final document = pdfState.recentPdfs[index];
          return PdfCard(
            document: document,
            tag: 'recent-$index',
            onTap: () => _openPdf(context, document, pdfState),
          );
        },
      ),
    );
  }

  Widget _buildFavoritesGrid(BuildContext context, PdfProvider pdfState) {
    if (pdfState.favorites.isEmpty) {
      return const GlassCard(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Center(child: Text('Favorites are empty. Mark your top reads with the heart icon.', style: TextStyle(color: Colors.white54))),
        ),
      );
    }
    return Wrap(
      spacing: 14,
      runSpacing: 14,
      children: pdfState.favorites.take(4).map((document) {
        return SizedBox(width: 170, child: PdfCard(document: document, onTap: () => _openPdf(context, document, pdfState)));
      }).toList(),
    );
  }

  Widget _buildDocumentList(BuildContext context, List<PdfDocument> documents, PdfProvider pdfState) {
    if (pdfState.isScanning) {
      return const AnimatedLoader();
    }
    if (documents.isEmpty) {
      return const GlassCard(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Center(child: Text('No PDF files found. Use the Open PDF button or grant storage permission.', style: TextStyle(color: Colors.white54))),
        ),
      );
    }
    return Column(
      children: documents.map((document) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _buildDocumentListItem(context, document, pdfState),
        );
      }).toList(),
    );
  }

  Widget _buildDocumentListItem(BuildContext context, PdfDocument document, PdfProvider pdfState) {
    return GlassCard(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        onTap: () => _openPdf(context, document, pdfState),
        title: Text(document.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
        subtitle: Text('${friendlyFileName(File(document.filePath))} • ${document.updatedAt.year}-${document.updatedAt.month.toString().padLeft(2, '0')}-${document.updatedAt.day.toString().padLeft(2, '0')}', style: const TextStyle(color: Colors.white54, fontSize: 13)),
        trailing: IconButton(
          icon: Icon(pdfState.isFavorite(document) ? Icons.favorite : Icons.favorite_border, color: pdfState.isFavorite(document) ? const Color(0xFF9B5CFF) : Colors.white70),
          onPressed: () => pdfState.toggleFavorite(document),
        ),
      ),
    );
  }

  void _openPdf(BuildContext context, PdfDocument document, PdfProvider pdfState) {
    pdfState.openDocument(document);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => PdfReaderScreen(document: document)),
    );
  }

  void _showSortSheet(BuildContext context, PdfProvider pdfState) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF0C1524),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Sort documents by', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
              const SizedBox(height: 16),
              ...Constants.sortFields.map((field) {
                return RadioListTile<String>(
                  value: field,
                  groupValue: pdfState.sortBy,
                  title: Text(field, style: const TextStyle(color: Colors.white70)),
                  activeColor: const Color(0xFF3F73FF),
                  onChanged: (value) {
                    if (value != null) {
                      pdfState.setSortBy(value);
                      Navigator.pop(context);
                    }
                  },
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }
}
