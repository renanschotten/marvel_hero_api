import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_hero_api/characters/datasources/character_datasource.dart';
import 'package:marvel_hero_api/characters/datasources/constants.dart';
import 'package:marvel_hero_api/characters/models/character.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

import 'datasource_test_constants.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late CharacterDatasource datasource;

  setUp(() {
    client = MockHttpClient();
    datasource = HttpCharacterDatasourceImpl(client: client);
  });

  group('CharacterDatasource', () {
    test('Error', () async {
      when(() => client.get(Uri.parse(UrlConstants().url))).thenAnswer(
        (_) => Future.value(DatasourceTestConstants.errorResponse),
      );
      final response = await datasource.fetchCharacters();
      expect(
        response.fold((l) => l, (r) => r),
        'Não foi possível complementar a requisição. Erro: 401',
      );
    });

    test('Success', () async {
      when(() => client.get(Uri.parse(UrlConstants().url))).thenAnswer(
        (_) async => DatasourceTestConstants.successResponse,
      );
      final response = await datasource.fetchCharacters();
      expect(
        response.fold((l) => l, (r) => r),
        isA<List<Character>>(),
      );
    });
  });
}
