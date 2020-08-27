import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words_app/animations/shake_animation.dart';
import 'package:words_app/bloc/collections/collections_bloc.dart';
import 'package:words_app/bloc/words/words_bloc.dart';
import 'package:words_app/helpers/functions.dart';

import 'package:words_app/models/collection.dart';

import 'package:words_app/components/my_separator.dart';
import 'package:words_app/screens/words_screen/words_screen.dart';

import 'btns.dart';
import 'text_holder.dart';

class CollectionCard extends StatelessWidget {
  CollectionCard({
    this.goToManagerCollections,
    this.index,
    this.showEditDialog,
    this.collections,
  });

  final Function goToManagerCollections;
  final int index;
  final List<Collection> collections;
  final Function showEditDialog;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, WordsScreen.id,
            arguments: {'id': collections[index].id});
        BlocProvider.of<WordsBloc>(context)
          ..add(WordsLoaded(
            id: collections[index].id,
          ));
      },
      onLongPress: () {
        BlocProvider.of<CollectionsBloc>(context).add(CollectionsToggleAll());
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Stack(
          alignment: AlignmentDirectional.topEnd,
          overflow: Overflow.visible,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 10, right: 5, left: 5),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    color: Colors.white,
                    border: Border.all(color: Colors.white)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        alignment: Alignment.center,
                        height: 30.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                          ),
                        ),
                        child: FittedBox(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 1, right: 1, bottom: 1, left: 1),
                            child: Text(
                              collections[index].title ?? ' ',
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      MySeparator(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                        dWidth: 2.0,
                        dCount: 4.0,
                        color: Colors.grey,
                        height: 2.0,
                      ),
                      SizedBox(height: 5.0),
                      FittedBox(
                        child: TextHolder(
                          titleNameValue: collections[index].language ?? ' ',
                          fontSize1: 9.0,
                          fontSize2: 15.0,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      TextHolder(
                        titleName: 'words: ',
                        titleNameValue: '16',
                        fontSize1: 9.0,
                        fontSize2: 15.0,
                      ),
                      SizedBox(height: 5.0),
                      TextHolder(
                        titleName: 'learned: ',
                        titleNameValue: '11',
                        fontSize1: 9.0,
                        fontSize2: 15.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            collections[index].isEditingBtns
                ? Positioned(
                    top: -1,
                    left: 75,
                    child: Row(
                      children: <Widget>[
                        // Edit btn
                        Btns(
                            backgroundColor: Colors.white,
                            icon: Icons.edit,
                            color: Colors.black54,
                            onPress: () {
                              BlocProvider.of<CollectionsBloc>(context)
                                  .add(CollectionsToggleAll());

                              showEditDialog(collections[index]);
                            }),

                        Btns(
                          backgroundColor: Colors.white,
                          icon: Icons.delete,
                          color: Colors.black54,
                          onPress: () {
                            deleteConfirmation(context, () {
                              BlocProvider.of<CollectionsBloc>(context)
                                ..add(CollectionsDeleted(
                                    id: collections[index].id));
                              Navigator.pop(context);
                            }, 'Do you want to delete your collection?');
                          },
                        ),
                        SizedBox(width: 5),
                      ],
                    ).shakeAnimation,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

extension AnimationExtension on Widget {
  Widget get shakeAnimation {
    return ShakeAnimation(child: this);
  }
}