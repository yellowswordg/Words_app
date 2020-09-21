import 'package:flutter/material.dart';
import 'package:words_app/bloc/trainings/trainings_bloc.dart';
import 'package:words_app/helpers/functions.dart';
import 'package:words_app/models/collection.dart';
import 'package:words_app/models/fuiltersEnums.dart';
import 'package:words_app/models/word.dart';
import 'package:words_app/screens/games/bricks_game_screen/bricks_game.dart';
import 'package:words_app/screens/games/pair_game_screen/pair_game.dart';
import 'package:words_app/screens/games/right_wrong_game/correct_wrong_game.dart';

/// Return amount of filtered words when difficulties is chosen.
///
/// path:'/training_manager_screen'
String countWordsByDifficulty(
  List<Word> listWord,
  int difficulty,
  List<int> selectedDifficulties,
) {
  int counter = 0;
  for (int i = 0; i < listWord.length; i++) {
    if (selectedDifficulties.isEmpty) {
      counter = 0;
    } else {
      if (listWord[i].difficulty == difficulty) {
        counter++;
      } else {
        if (difficulty == 3) {
          counter = listWord.length;
        }
      }
    }
  }
  return counter.toString();
}

/// Navigate to games depending on which game is selected, collection and difficulty
void checkNavigation(
  List<Collection> selectedListCollections,
  TrainingsSuccess state,
  BuildContext context,
  GlobalKey<ScaffoldState> scaffoldKey,
  List<int> selectedDifficulties,
  FilterGames selectedGames,
) {
  if (selectedDifficulties.isEmpty) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
        duration: Duration(milliseconds: 1500),
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'You have to choose which words you want to learn',
          ),
        )));
  }
  if (selectedListCollections.isEmpty) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
        duration: Duration(milliseconds: 1500),
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'You have to choose which collection',
          ),
        )));
  }
  if (selectedGames == FilterGames.bricks &&
      selectedDifficulties.isNotEmpty &&
      selectedListCollections.isNotEmpty) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BricksGame(words: state.filteredWords),
        ));
  }
  if (selectedGames == FilterGames.wrongCorrect &&
      selectedDifficulties.isNotEmpty &&
      selectedListCollections.isNotEmpty) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RightWrong(
            words: state.filteredWords,
          ),
        ));
  }
  if (selectedGames == FilterGames.pair &&
      selectedDifficulties.isNotEmpty &&
      selectedListCollections.isNotEmpty) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PairGame(
            words: state.filteredWords,
          ),
        ));
  }
}