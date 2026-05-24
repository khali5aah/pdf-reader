class Bookmark {
  final String documentPath;
  final int page;
  final DateTime createdAt;

  Bookmark({
    required this.documentPath,
    required this.page,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'documentPath': documentPath,
      'page': page,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Bookmark.fromMap(Map<String, dynamic> map) {
    return Bookmark(
      documentPath: map['documentPath'] as String,
      page: map['page'] as int,
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }
}
