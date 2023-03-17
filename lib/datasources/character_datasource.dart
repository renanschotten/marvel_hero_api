import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import 'package:marvel_hero_api/models/character.dart';

abstract class CharacterDatasource {
  Future<Either<String, List<Character>>> fetchCharacters();
}

class HttpCharacterDatasourceImpl implements CharacterDatasource {
  @override
  Future<Either<String, List<Character>>> fetchCharacters() async {
    try {
      var response = await http.get(
        Uri.parse(
          'https://gateway.marvel.com:443/v1/public/characters?ts=1&limit=12&apikey=1b6c18ad53addc7d2fd7036c1a9f6d13&hash=18e030e8dbdf6653439109dd92cf485a',
        ),
      );
      if (response.statusCode != 200) throw response.toString();
      List<Character> characters = [];
      var dR = json.decode(response.body);
      if (dR['data'] is Map &&
          dR['data']['results'] is List &&
          (dR['data']['results'] as List).isNotEmpty) {
        for (var element in dR['data']['results']) {
          characters.add(Character.fromMap(element));
        }
      }
      return Right(characters);
    } catch (e) {
      return Left('Erro');
    }
  }
}
