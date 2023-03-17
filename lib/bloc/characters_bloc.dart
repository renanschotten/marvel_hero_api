import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';

import 'package:marvel_hero_api/models/character.dart';
import 'package:marvel_hero_api/services/fetch_characters.dart';

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
