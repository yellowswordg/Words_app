part of 'words_bloc.dart';

abstract class WordsEvent extends Equatable {
  const WordsEvent();

  @override
  List<Object> get props => [];
}

class WordsLoaded extends WordsEvent {
  final String id;
  final bool isEdit;

  WordsLoaded({this.id, this.isEdit});

  List<Object> get props => [id, isEdit];
}

class WordsAdded extends WordsEvent {}

class WordsDeleted extends WordsEvent {}

class WordsToggleEditMode extends WordsEvent {
  // final bool isEdit;

  // WordsToggleEditMode({this.isEdit});

  // List<Object> get props => [isEdit];
}

class WordsToggledAll extends WordsEvent {}