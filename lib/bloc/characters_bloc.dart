import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';

import 'package:marvel_hero_api/models/character.dart';
import 'package:marvel_hero_api/services/fetch_characters.dart';

part 'characters_event.dart';
part 'characters_state.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  final CharactersService service;
  CharactersBloc({required this.service}) : super(CharactersLoading()) {
    on<FetchCharacters>((event, emit) async {
      final response = await service.fetchCharacters();
      response.fold(
        (l) => emit(CharactersFailure(message: l)),
        (r) {
          List<List<Character>> chunkedList = r.slices(4).toList();
          emit(CharactersSuccess(characters: chunkedList));
        },
      );
    });
  }
}
