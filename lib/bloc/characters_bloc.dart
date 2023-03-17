import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:marvel_hero_api/models/character.dart';
import 'package:marvel_hero_api/services/fetch_characters.dart';

part 'characters_event.dart';
part 'characters_state.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  CharactersBloc() : super(CharactersLoading()) {
    on<FetchCharacters>((event, emit) async {
      final response = await CharactersService().fetchCharacters();
      response.fold(
        (l) => emit(CharactersFailure(message: l)),
        (r) => emit(CharactersSuccess(characters: r)),
      );
    });
  }
}
