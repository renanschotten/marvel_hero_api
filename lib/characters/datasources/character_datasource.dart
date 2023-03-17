import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:marvel_hero_api/characters/datasources/constants.dart';
import 'package:marvel_hero_api/characters/models/character.dart';

abstract class CharacterDatasource {
  Future<Either<String, List<Character>>> fetchCharacters();
}

class HttpCharacterDatasourceImpl implements CharacterDatasource {
  HttpCharacterDatasourceImpl({required this.client});

  final http.Client client;

  @override
  Future<Either<String, List<Character>>> fetchCharacters() async {
    try {
      var response = await client.get(Uri.parse(UrlConstants().url));

      if (response.statusCode != 200) throw response.statusCode;

      List<Character> characters = [];
      var responseMap = json.decode(response.body);
      for (var element in responseMap['data']['results']) {
        characters.add(Character.fromMap(element));
      }
      return Right(characters);
    } catch (e) {
      return Left('Não foi possível complementar a requisição. Erro: $e');
    }
  }
}
