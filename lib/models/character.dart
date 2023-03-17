import 'package:marvel_hero_api/models/thumbnail.dart';

class Character {
  final int id;
  final String name;
  final String description;
  final Thumbnail thumbnail;

  Character({
    required this.id,
    required this.name,
    required this.description,
    required this.thumbnail,
  });

  factory Character.fromMap(Map<String, dynamic> map) {
    return Character(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      thumbnail: Thumbnail.fromMap(map['thumbnail']),
    );
  }
}
