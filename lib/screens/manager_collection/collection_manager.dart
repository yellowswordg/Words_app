import 'package:flutter/material.dart';
import 'package:words_app/components/base_appbar.dart';
import 'package:words_app/constants/constants.dart';
import 'package:words_app/components/reusable_float_action_button.dart';
import 'package:words_app/models/provider_data.dart';
import 'package:provider/provider.dart';
import 'package:words_app/screens/card_creater/card_creater.dart';
import 'package:words_app/screens/training_screen/training_screen.dart';
import 'components/word_card.dart';
import 'package:words_app/screens/manager_collection/components/dialog_window.dart';

class CollectionManager extends StatefulWidget {
  static String id = 'collection_manager_screen';

  @override
  _CollectionManagerState createState() => _CollectionManagerState();
}

class _CollectionManagerState extends State<CollectionManager> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderData>(builder: (context, providerData, child) {
      return SafeArea(
        // Exclude top from SafeArea
        top: false,
        child: Scaffold(
          appBar: BaseAppBar(
            title: Text('Collection Name'),
            appBar: AppBar(),
          ),
//        appBar: AppBar(
//          centerTitle: true,
//          backgroundColor: kMainColorBlue,
//          automaticallyImplyLeading: false,
//          title: Text('Collection Name'),
//        ),
          floatingActionButton: ReusableFloatActionButton(
              onPressed: () => Navigator.pushNamed(context, CardCreater.id)),
          bottomNavigationBar: BottomAppBar(
            shape: CircularNotchedRectangle(),
            clipBehavior: Clip.antiAlias,
            child: Container(
              height: 60.0,
              color: kMainColorBlue,
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                      width: 90,
                      height: 55,
                      alignment: Alignment.center,
                      child: IconButton(
                        iconSize: 40,
                        icon: Icon(
                          Icons.keyboard_arrow_left,
                          color: Colors.white,
                        ),
                        onPressed: () => Navigator.pop(context),
                      )),
                  Container(
                      padding: EdgeInsets.only(right: 20),
                      alignment: Alignment.center,
                      child: IconButton(
                        iconSize: 40,
                        icon: Icon(
                          Icons.fitness_center,
                          color: Colors.white,
                        ),
                        onPressed: () =>
                            Navigator.pushNamed(context, Training.id),
                      )),
                ],
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          body: Container(
            padding: EdgeInsets.only(top: 20.0),
            child: ListView.builder(
              itemCount: providerData.wordsData.length,
              itemBuilder: (context, index) {
                final item = providerData.wordsData[index].word1;

                return Dismissible(
                  background: Container(
                    alignment: Alignment.centerRight,
                    color: Color(0xFFF8b6b6),
                    child: Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Icon(Icons.delete),
                    ),
                  ),
                  key: Key(item),
                  direction: DismissDirection.endToStart,
                  child: WordCard(
                    // Here when we prees on word card, a diolog window pops up
                    onTap: () {
                      /*  when we prees on WordCard, we pass an id of this WordCard to provider_data,
                          in provider_data Function choosePictureInProvider takes that id and send it to words_data throught 
                          Function choosePicture, in that Function check wich id match to WordCard and stored image in wordCardPicture.
                       */
                      providerData.wordsData[index]
                          .selectImages(providerData.wordsData[index].id);
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            content:
                                StatefulBuilder(builder: (context, setState) {
                              return DialogWindow(
                                // MainWord
                                // Pass wain word title in DialogWindow
                                mainWordTitle:
                                    providerData.wordsData[index].word1,
                                // Pass bool in DialogWindow, for editing title name
                                isCheckedTitleMainWords: providerData
                                    .wordsData[index].isEditingWord1,
                                /* Toogle checkMainWordTitle(from words_data), if true {show just a text}, 
                                   if false {show Text field for editing title name} */
                                toggleMainWord: () {
                                  setState(() {
                                    providerData.toggleWord1(
                                      providerData.wordsData[index],
                                    );
                                  });
                                },

                                /*  Handle value of Text field, send it value to Function handleSubmitMainWords 
                                    in provider_data, in handleSubmitMainWords pass this value to changeMainWordTitle 
                                    in words_data and store this value in mainWordTitle. */
                                submitMainWord: (value) {
                                  setState(() {
                                    providerData.handleSubmitWord1(
                                      value,
                                      providerData.wordsData[index],
                                    );
                                  });
                                },

                                // SecondWord
                                secondWordTitle:
                                    providerData.wordsData[index].word2,
                                isCheckedSecondWord: providerData
                                    .wordsData[index].isEditingWord2,
                                toggleSecondWord: () {
                                  setState(() {
                                    providerData.toggleWord2(
                                      providerData.wordsData[index],
                                    );
                                  });
                                },
                                submitSecondWord: (value) {
                                  providerData.handleSubmitWord2(
                                    value,
                                    providerData.wordsData[index],
                                  );
                                },

                                // Translation Word
                                translationTitle:
                                    providerData.wordsData[index].translation,
                                isCheckedTranslation: providerData
                                    .wordsData[index].isEditingTranslationTitle,
                                toggleTranslation: () {
                                  setState(() {
                                    providerData.toggleTranslation(
                                        providerData.wordsData[index]);
                                  });
                                },
                                submitTranslation: (value) {
                                  setState(() {
                                    providerData.handleSubmitTranslation(
                                        value, providerData.wordsData[index]);
                                  });
                                },

                                // Example
                                isCheckExampleTitle: providerData
                                    .wordsData[index].isEditingExampleTitle,

                                // WordsPicture
                                wordPicture:
                                    providerData.wordsData[index].image,
                              );
                            }),
                          );
                        },
                      );
                    },
                    //Main word
                    mainWordTitle: providerData.wordsData[index].word1,

                    //Second word

                    secondWordTitle: providerData.wordsData[index].word2,

                    // Translation
                    translationTitle: providerData.wordsData[index].translation,

                    // WordPicture
                    wordPicture: providerData.wordsData[index].image,
                    showPicture: providerData.wordsData[index].isEditingShowImg,

                    /* When we press IconBotton is DialogTextHolderContainer, we pass an id of this WordCard to provider_data,
                          in provider_data Function choosePictureInProvider takes that id and send it to words_data throught 
                          Function choosePicture, in that Function check wich id match to WordCard and stored image 
                          in wordCardPicture.*/
                    showOrHidePicture: () {
                      providerData.wordsData[index]
                          .selectImages(providerData.wordsData[index].id);

                      providerData.toggleShowImg(providerData.wordsData[index]);
                    },
                  ),
                );
              },
            ),
          ),
        ),
      );
    });
  }
}
