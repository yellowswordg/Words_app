import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words_app/bloc/trainings/trainings_bloc.dart';
import 'package:words_app/components/base_appbar.dart';
import 'package:words_app/components/reusable_main_button.dart';
import 'package:words_app/models/FuiltersEnums.dart';
import 'package:words_app/models/difficulty.dart';
import 'package:words_app/models/word.dart';

import 'package:words_app/utils/size_config.dart';

import 'components/deffifculty_btns.dart';
import 'components/favorites_btns.dart';
import 'components/games_btns.dart';

class TrainingManager extends StatefulWidget {
  static String id = 'training_manager_screen';

  @override
  _TrainingManagerState createState() => _TrainingManagerState();
}

class _TrainingManagerState extends State<TrainingManager> {
  int selectedDifficulty = 3;
  FilterFavorites selectedFavorite = FilterFavorites.all;
  String dropdownValue = 'Collection';
  List<Difficulty> difficulty = DifficultyList().difficultyList;
  List<IconData> iconsList = [
    Icons.fitness_center,
    Icons.directions_bike,
    Icons.photo_album,
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final defaultSize = SizeConfig.defaultSize;
    Map args = ModalRoute.of(context).settings.arguments;
    String collectionId = args['id'];
    List<Word> words = args['words'];

    return BlocBuilder<TrainingsBloc, TrainingsState>(
      builder: (context, state) {
        if (state is TrainingsLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is TrainingsSuccess) {
          // for (var i = 0; i < state.words.length; i++) {
          //   print(
          //       'difficulties ${state.words[i].targetLang} - ${state.words[i].difficulty}');
          // }
          return Scaffold(
            backgroundColor: Color(0xFFeae2da),
            appBar: BaseAppBar(
              title: Text('Training Manager'),
              appBar: AppBar(),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Main container with all content on the page
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: defaultSize * 3),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleTextHolder(title: '1. I want to play ...'),
                        Container(
                          child: GamesBtns(),
                          // child: Row(
                          //   crossAxisAlignment: CrossAxisAlignment.center,
                          //   mainAxisAlignment: MainAxisAlignment.start,
                          //   children: [
                          //     TrainingBtnsContainers(
                          //         icon: Icons.fitness_center,
                          //         onTap: () => Navigator.push(
                          //             context,
                          //             MaterialPageRoute(
                          //               builder: (context) => Matches(
                          //                 words: words,
                          //               ),
                          //             ))),
                          //     TrainingBtnsContainers(
                          //       icon: Icons.directions_bike,
                          //       onTap: () => Navigator.pushNamed(
                          //         context,
                          //         PairGame.id,
                          //         arguments: {'id': collectionId},
                          //       ),
                          //     ),
                          //     TrainingBtnsContainers(
                          //         icon: Icons.photo_album,
                          //         onTap: () => Navigator.push(
                          //             context,
                          //             MaterialPageRoute(
                          //               builder: (context) => Training(
                          //                 words: words,
                          //               ),
                          //             ))),
                          //   ],
                          // ),
                        ),
                        TitleTextHolder(
                            title: '2. I want to study words that I ...'),
                        buildDifficultiesBtns(defaultSize, context),

                        TitleTextHolder(
                            title: '3. I want to include in the game ...'),

                        Container(
                          child: Row(
                            children: FilterFavorites.values.map((item) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: ChoiceChip(
                                  backgroundColor: Colors.white,
                                  labelPadding:
                                      EdgeInsets.all(defaultSize * 0.8),
                                  selectedColor: Colors.grey,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          defaultSize * 0.5)),
                                  elevation: 5,
                                  label: Container(
                                    alignment: Alignment.center,
                                    width: defaultSize * 3,
                                    height: defaultSize * 3,
                                    child: item == FilterFavorites.all
                                        ? Text('all',
                                            style: TextStyle(
                                                fontSize: defaultSize * 2,
                                                fontWeight: FontWeight.bold))
                                        : Icon(
                                            Icons.star_border,
                                            color: Colors.black,
                                            size: defaultSize * 3,
                                          ),
                                  ),
                                  selected: selectedFavorite == item,
                                  onSelected: (selected) {
                                    setState(
                                      () {
                                        selectedFavorite = item;
                                        print(selectedFavorite);
                                      },
                                    );
                                    context.bloc<TrainingsBloc>().add(
                                        TrainingsFavoritesFilter(
                                            filterFavorites: selectedFavorite));
                                  },
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        // FavoritesBtns(),

                        TitleTextHolder(
                            title: '4. I want to use words from ...'),
                        Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(defaultSize * 0.5)),
                          margin: EdgeInsets.only(right: defaultSize * 20),
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Text('Filters'),
                              DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: dropdownValue,
                                  icon: Icon(Icons.arrow_drop_down),
                                  iconSize: defaultSize * 3,
                                  onChanged: (String newValue) {
                                    setState(() {
                                      dropdownValue = newValue;
                                    });
                                  },
                                  items: <String>[
                                    'Collection',
                                    'Know',
                                    "Don't know",
                                    'Custom list'
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(value: false, onChanged: null),
                    Text('remember my choice'),
                  ],
                ),
                SizedBox(height: defaultSize * 2),

                //  Button-container
                Container(
                  child: ReusableMainButton(
                    titleText: 'Go to Trainig',
                    textColor: Colors.black,
                    backgroundColor: Theme.of(context).accentColor,
                    onPressed: () {
                      print(
                          'from training_manager length of filtredList ${state.filterdList.length}');
                    },
                  ),
                ),
              ],
            ),
          );
        }
        return Text('Somthing went wrong....');
      },
    );
  }

  Container buildDifficultiesBtns(double defaultSize, BuildContext context) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: difficulty.map((item) {
        return Padding(
          padding: const EdgeInsets.only(right: 5),
          child: ChoiceChip(
            elevation: 5,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12.0),
            label: Text(item.name),
            labelStyle: TextStyle(
                fontSize: defaultSize * 1.6,
                color: Colors.black,
                fontWeight: FontWeight.w900),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(defaultSize * 0.5),
            ),
            backgroundColor: item.color,
            selectedColor: selectedDifficulty == 3 ? item.color : Colors.grey,
            selected: selectedDifficulty == item.difficulty,
            onSelected: (selected) {
              setState(() {
                selectedDifficulty == item.difficulty
                    ? selectedDifficulty = 3
                    : selectedDifficulty = item.difficulty;
              });

              context.bloc<TrainingsBloc>().add(TrainingsDifficultiesFilter(
                    difficultyFilter: selectedDifficulty,
                    // selectedFavorites: selectedFavorite
                  ));

              print('from training_screen $selectedDifficulty');
            },
          ),
        );
      }).toList(),
    ));
  }
}

class TitleTextHolder extends StatelessWidget {
  const TitleTextHolder({
    Key key,
    @required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final defaultSize = SizeConfig.defaultSize;
    return Container(
        child: Text(title,
            style: TextStyle(
                fontSize: defaultSize * 2,
                color: Theme.of(context).accentColor)));
  }
}

class TrainingBtnsContainers extends StatelessWidget {
  const TrainingBtnsContainers({
    Key key,
    this.icon,
    this.onTap,
  }) : super(key: key);

  final IconData icon;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final defaultSize = SizeConfig.defaultSize;

    return Padding(
      padding: const EdgeInsets.only(right: 30),
      child: InkWell(
        onTap: onTap,
        child: Card(
          // padding: EdgeInsets.symmetric(horizontal: defaultSize * 1),
          elevation: 5,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(defaultSize * 0.5)),
          child: Padding(
            padding: EdgeInsets.all(defaultSize * 0.8),
            child: Container(
                alignment: Alignment.center,
                width: defaultSize * 4,
                height: defaultSize * 4,
                child: icon is IconData
                    ? Icon(
                        icon,
                        size: defaultSize * 3,
                        color: Colors.black,
                      )
                    : Text('all', style: TextStyle(fontSize: defaultSize * 2))),
          ),
        ),
      ),
    );
  }
}
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(
//           horizontal: defaultSize * 0.5, vertical: defaultSize),
//       decoration: BoxDecoration(
//         boxShadow: [kBoxShadow],
//         color: Colors.white,
//       ),
//       width: defaultSize * 5,
//       height: defaultSize * 5,
//       child: child,
//     );
//   }
// }

// Expanded(
//                     child: Center(
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                         ),
//                         padding: EdgeInsets.all(defaultSize),
//                         margin: EdgeInsets.only(
//                             bottom: defaultSize * 7,
//                             right: defaultSize * 3,
//                             left: defaultSize * 3),
//                         child: ListView.builder(
//                             itemCount: words.length,
//                             itemBuilder: (context, index) {
//                               return Container(
//                                 child: ListTile(
//                                   leading: Text(words[index].part.partName,
//                                       style: TextStyle(
//                                           color: words[index].part.partColor)),
//                                   title: Container(
//                                       padding: EdgeInsets.only(
//                                           left: defaultSize * 1),
//                                       child:
//                                           Text(words[index].targetLang ?? '')),
//                                   subtitle: Container(
//                                       padding: EdgeInsets.only(
//                                           left: defaultSize * 1),
//                                       child: Text(words[index].ownLang ?? '')),
//                                 ),
//                               );
//                             }),
//                       ),
//                     ),
//                   ),
