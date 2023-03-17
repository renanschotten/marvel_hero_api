/* import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';
import 'package:marvel_hero_api/characters/models/character.dart';
import 'package:marvel_hero_api/characters/services/fetch_characters.dart';

part 'characters_event.dart';
part 'characters_state.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  final CharactersService service;
  late List<Character> characterList;
  late int totalPages;
  CharactersBloc({required this.service}) : super(CharactersInitial()) {
    on<FetchCharacters>((event, emit) async {
      emit(CharactersLoading());
      final response = await service.fetchCharacters();
      response.fold(
        (l) => emit(CharactersFailure(message: l)),
        (r) {
          characterList = r;
          List<List<Character>> chunkedList = r.slices(4).toList();
          totalPages = chunkedList.length;
          emit(CharactersSuccess(characters: chunkedList));
        },
      );
    });
    on<FilterCharacters>((event, emit) {
      List<Character> filteredCharacterList = [];
      if (event.name.isNotEmpty) {
        filteredCharacterList = characterList
            .where(
              (element) => element.name.toUpperCase().contains(
                    event.name.toUpperCase(),
                  ),
            )
            .toList();
      } else {
        filteredCharacterList = characterList;
      }
      List<List<Character>> chunkedList =
          filteredCharacterList.slices(4).toList();
      totalPages = chunkedList.length;
      emit(CharactersSuccess(characters: chunkedList));
    });
  }
}
 */

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_hero_api/characters/services/fetch_characters.dart';
import 'package:marvel_hero_api/characters/view/bloc/characters_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockCharactersService extends Mock implements CharactersService {}

void main() {
  late CharactersService service;

  setUp(() {
    service = MockCharactersService();
  });

  group('CharactersBloc', () {
    blocTest<CharactersBloc, CharactersState>(
      'Should emit [CharactersLoading, CharactersFailure] when returned Left from Service',
      setUp: () {
        return when(() => service.fetchCharacters()).thenAnswer(
          (_) => Future.value(Left('Error')),
        );
      },
      build: () => CharactersBloc(service: service),
      act: (bloc) => bloc.add(FetchCharacters()),
      expect: () => [
        isInstanceOf<CharactersLoading>(),
        isInstanceOf<CharactersFailure>(),
      ],
    );

    blocTest<CharactersBloc, CharactersState>(
      'Should emit [CharactersLoading, CharactersSuccess] when returned Right from Service',
      setUp: () {
        return when(() => service.fetchCharacters()).thenAnswer(
          (_) => Future.value(Right([])),
        );
      },
      build: () => CharactersBloc(service: service),
      act: (bloc) => bloc.add(FetchCharacters()),
      expect: () => [
        isInstanceOf<CharactersLoading>(),
        isInstanceOf<CharactersSuccess>(),
      ],
    );
  });
}
