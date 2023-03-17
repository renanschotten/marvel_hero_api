// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:marvel_hero_api/models/thumbnail.dart';

class Character {
  final int id;
  final String name;
  final String description;
  final Thumbnail thumbnail;
  final List<String> comics;
  final List<String> series;
  final List<String> stories;
  final List<String> events;

  Character({
    required this.id,
    required this.name,
    required this.description,
    required this.thumbnail,
    required this.comics,
    required this.series,
    required this.stories,
    required this.events,
  });

  factory Character.fromMap(Map<String, dynamic> map) {
    List<String> comics = [];
    List<String> series = [];
    List<String> stories = [];
    List<String> events = [];

    for (var element in map['comics']['items']) {
      comics.add(element['name']);
    }

    for (var element in map['series']['items']) {
      series.add(element['name']);
    }

    for (var element in map['stories']['items']) {
      stories.add(element['name']);
    }

    for (var element in map['events']['items']) {
      events.add(element['name']);
    }

    return Character(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      thumbnail: Thumbnail.fromMap(map['thumbnail']),
      comics: comics,
      events: events,
      series: series,
      stories: stories,
    );
  }
}
