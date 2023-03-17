class Thumbnail {
  final String path;
  final String extension;

  Thumbnail({
    required this.path,
    required this.extension,
  });

  factory Thumbnail.fromMap(Map<String, dynamic> map) {
    return Thumbnail(
      path: map['path'] as String,
      extension: map['extension'] as String,
    );
  }

  String get fullPath => '$path.$extension';
}
