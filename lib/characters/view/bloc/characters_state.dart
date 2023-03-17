part of 'characters_bloc.dart';

@immutable
abstract class CharactersState {}

class CharactersInitial extends CharactersState {}

class CharactersLoading extends CharactersState {}

class CharactersSuccess extends CharactersState {
  final List<List<Character>> characters;

  CharactersSuccess({required this.characters});
}

class CharactersFailure extends CharactersState {
  final String message;

  CharactersFailure({required this.message});
}
