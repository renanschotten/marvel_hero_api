import 'package:dartz/dartz.dart';
import 'package:marvel_hero_api/characters/models/character.dart';
import 'package:marvel_hero_api/characters/repositories/character_repository.dart';

class CharactersService {
  final CharacterRepository repository;

  CharactersService({required this.repository});

  Future<Either<String, List<Character>>> fetchCharacters() async {
    return await repository.fetchCharacters();
  }
}
