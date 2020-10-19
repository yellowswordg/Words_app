import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:words_app/bloc/blocs.dart';
import 'package:words_app/cubit/card_creator/part_color/part_color_cubit.dart';
import 'package:words_app/helpers/functions.dart';
import 'package:words_app/screens/screens.dart';

import 'widgets.dart';

class WordsListView extends StatelessWidget {
  final WordsSuccess state;
  final isEditingMode;
  final collectionId;
  final collectionLang;
  final collectionTitle;

  const WordsListView(
      {Key key,
      this.state,
      this.isEditingMode,
      this.collectionId,
      this.collectionLang,
      this.collectionTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(bottom: 25.0),
        // Here we render only listView
        child: ListView.builder(
          // itemExtent: 100,
          itemCount: state.words.length,
          // semanticChildCount: 1,
          itemBuilder: (context, index) {
            return Slidable(
              enabled: isEditingMode ? false : true,
              child: WordCard(
                  isEditingMode: isEditingMode,
                  index: index,
                  selectedList: state.selectedList,
                  word: state.words[index],
                  words: state.words,
                  collectionId: collectionId,
                  collectionTitle: collectionTitle), //
              actionPane: SlidableDrawerActionPane(),
              secondaryActions: <Widget>[
                IconSlideAction(
                  caption: 'Edit',
                  color: Colors.black26,
                  icon: Icons.edit,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      CardCreator.id,
                      arguments: {
                        'isEditingMode': true,
                        'word': state.words[index],
                        'collectionId': collectionId,
                      },
                    );
                    context
                        .bloc<PartColorCubit>()
                        .changeColor(state.words[index].part.partColor);
                    context.bloc<CardCreatorBloc>().add(
                          CardCreatorLoaded(
                            word: state.words[index],
                          ),
                        );
                  },
                ),
                IconSlideAction(
                  caption: 'Delete',
                  color: Theme.of(context).accentColor,
                  icon: Icons.delete,
                  onTap: () => deleteConfirmation(context, () {
                    context
                        .bloc<WordsBloc>()
                        .add(WordsDeleted(word: state.words[index]));
                    Navigator.pop(context);
                  }, 'Do you want to delete this word?'),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
