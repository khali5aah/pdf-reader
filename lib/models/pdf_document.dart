class PdfDocument {
  final String filePath;
  final String name;
  final int size;
  final DateTime updatedAt;

  PdfDocument({
    required this.filePath,
    required this.name,
    required this.size,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'filePath': filePath,
      'name': name,
      'size': size,
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory PdfDocument.fromMap(Map<String, dynamic> map) {
    return PdfDocument(
      filePath: map['filePath'] as String,
      name: map['name'] as String,
      size: map['size'] as int,
      updatedAt: DateTime.parse(map['updatedAt'] as String),
    );
  }
}
