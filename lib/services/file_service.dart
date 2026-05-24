import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import '../models/pdf_document.dart';

class FileService {
  static Future<List<PdfDocument>> scanPdfFiles() async {
    final List<PdfDocument> documents = [];
    try {
      final permissionGranted = await _requestStoragePermission();
      if (!permissionGranted) return documents;

      final roots = await _getSearchDirectories();
      for (final directory in roots) {
        if (await directory.exists()) {
          await for (final file in directory.list(recursive: true, followLinks: false)) {
            if (file is File && file.path.toLowerCase().endsWith('.pdf')) {
              final stat = await file.stat();
              documents.add(PdfDocument(
                filePath: file.path,
                name: file.path.split('/').last,
                size: stat.size,
                updatedAt: stat.modified,
              ));
            }
          }
        }
      }
    } catch (e) {
      debugPrint('Scanning PDF files failed: $e');
    }
    return documents;
  }

  static Future<bool> _requestStoragePermission() async {
    final status = await Permission.storage.request();
    if (status.isGranted) return true;
    if (status.isDenied) {
      await Permission.storage.request();
      return Permission.storage.isGranted;
    }
    return false;
  }

  static Future<List<Directory>> _getSearchDirectories() async {
    final directories = <Directory>[];
    try {
      final appDir = await getApplicationDocumentsDirectory();
      directories.add(appDir);

      final externalDir = await getExternalStorageDirectory();
      if (externalDir != null) {
        directories.add(externalDir);
        final parent = externalDir.parent.parent.parent;
        directories.add(parent);
      }
    } catch (_) {
      // ignore errors in filesystem discovery
    }
    return directories;
  }

  static Future<File?> pickPdfFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      allowMultiple: false,
    );
    if (result == null || result.files.isEmpty) return null;
    final path = result.files.first.path;
    return path != null ? File(path) : null;
  }
}
