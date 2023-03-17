import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_hero_api/characters/models/character.dart';
import 'package:marvel_hero_api/characters/models/thumbnail.dart';
import 'package:marvel_hero_api/characters/repositories/character_repository.dart';
import 'package:marvel_hero_api/characters/services/fetch_characters.dart';
import 'package:mocktail/mocktail.dart';

class MockCharacterRepository extends Mock implements CharacterRepository {}

void main() {
  late CharacterRepository repository;
  late CharactersService service;

  setUp(() {
    repository = MockCharacterRepository();
    service = CharactersService(repository: repository);
  });

  group('CharacterRepositoryImpl', () {
    test('Failure', () async {
      when(() => repository.fetchCharacters()).thenAnswer(
        (_) => Future.value(Left('Erro')),
      );
      final response = await service.fetchCharacters();
      expect(response.fold((l) => l, (r) => r), 'Erro');
    });

    test('Success', () async {
      final List<Character> character = List.generate(
        3,
        (index) => Character(
          id: index,
          name: 'name',
          description: 'description',
          thumbnail: Thumbnail(path: 'path', extension: 'extension'),
          comics: ['comics'],
          series: ['series'],
          stories: ['stories'],
          events: ['events'],
        ),
      );
      when(() => repository.fetchCharacters()).thenAnswer(
        (_) => Future.value(Right(character)),
      );
      final response = await service.fetchCharacters();
      expect(response.fold((l) => l, (r) => r), character);
    });
  });
}
