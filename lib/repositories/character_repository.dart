import 'package:dartz/dartz.dart';

import 'package:marvel_hero_api/datasources/character_datasource.dart';
import 'package:marvel_hero_api/models/character.dart';

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
