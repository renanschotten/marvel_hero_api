import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:marvel_hero_api/characters/datasources/character_datasource.dart';
import 'package:marvel_hero_api/characters/repositories/character_repository.dart';
import 'package:marvel_hero_api/characters/services/fetch_characters.dart';
import 'package:marvel_hero_api/characters/view/bloc/characters_bloc.dart';

GetIt getIt = GetIt.instance;

Future<void> init() async {
  getIt.registerLazySingleton<Client>(() => http.Client());

  getIt.registerLazySingleton<CharacterDatasource>(
    () => HttpCharacterDatasourceImpl(client: getIt<Client>()),
  );

  getIt.registerLazySingleton<CharacterRepository>(
    () => CharacterRepositoryImpl(datasource: getIt<CharacterDatasource>()),
  );

  getIt.registerLazySingleton<CharactersService>(
    () => CharactersService(repository: getIt<CharacterRepository>()),
  );

  getIt.registerLazySingleton<CharactersBloc>(
    () => CharactersBloc(service: getIt<CharactersService>()),
  );
}
