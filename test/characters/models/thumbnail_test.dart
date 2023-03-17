import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_hero_api/characters/models/thumbnail.dart';

void main() {
  late Map<String, dynamic> map;
  late Thumbnail thumbnail;
  setUp(() {
    map = {
      "path": "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784",
      "extension": "jpg"
    };
    thumbnail = Thumbnail.fromMap(map);
  });
  group('Thumbnail Test', () {
    test('fromMap', () {
      expect(
        thumbnail.path,
        "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784",
      );
      expect(thumbnail.extension, "jpg");
    });

    test('fullPath', () {
      expect(
        thumbnail.fullPath,
        "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg",
      );
    });
  });
}
