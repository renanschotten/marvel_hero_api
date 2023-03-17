import 'package:dartz/dartz.dart';

import 'package:marvel_hero_api/models/character.dart';
import 'package:marvel_hero_api/repositories/character_repository.dart';

class CharactersService {
  final CharacterRepository repository;

  CharactersService({required this.repository});

  Future<Either<String, List<Character>>> fetchCharacters() async {
    return await repository.fetchCharacters();
  }
}
