part of 'characters_bloc.dart';

@immutable
abstract class CharactersEvent {}

class FetchCharacters extends CharactersEvent {}

class FilterCharacters extends CharactersEvent {
  FilterCharacters({required this.name});

  final String name;
}
