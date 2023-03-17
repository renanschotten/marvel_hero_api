/* import 'package:dartz/dartz.dart';
import 'package:marvel_hero_api/characters/datasources/character_datasource.dart';
import 'package:marvel_hero_api/characters/models/character.dart';

abstract class CharacterRepository {
  Future<Either<String, List<Character>>> fetchCharacters();
}

class CharacterRepositoryImpl implements CharacterRepository {
  CharacterRepositoryImpl({required this.datasource});

  final CharacterDatasource datasource;

  @override
  Future<Either<String, List<Character>>> fetchCharacters() async {
    return await datasource.fetchCharacters();
  }
}
 */

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_hero_api/characters/datasources/character_datasource.dart';
import 'package:marvel_hero_api/characters/models/character.dart';
import 'package:marvel_hero_api/characters/models/thumbnail.dart';
import 'package:marvel_hero_api/characters/repositories/character_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockCharacterDatasource extends Mock implements CharacterDatasource {}

void main() {
  late CharacterDatasource datasource;
  late CharacterRepository repository;

  setUp(() {
    datasource = MockCharacterDatasource();
    repository = CharacterRepositoryImpl(datasource: datasource);
  });

  group('CharacterRepositoryImpl', () {
    test('Failure', () async {
      when(() => datasource.fetchCharacters()).thenAnswer(
        (_) => Future.value(Left('Erro')),
      );
      final response = await repository.fetchCharacters();
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
      when(() => datasource.fetchCharacters()).thenAnswer(
        (_) => Future.value(Right(character)),
      );
      final response = await repository.fetchCharacters();
      expect(response.fold((l) => l, (r) => r), character);
    });
  });
}
