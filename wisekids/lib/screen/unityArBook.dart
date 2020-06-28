import 'dart:async';
import 'dart:ui';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:provider/provider.dart';
import '../provider/dataProvider.dart';

import '../widget/slide_popup_dialog_read.dart' as readDialog;
import '../widget/slide_popup_dialog_arInteractive.dart' as arInteractiveDialog;

import 'home.dart';
import './stickerCollected.dart';

class UnityARBook extends StatefulWidget {
  @override
  _UnityARBookState createState() => _UnityARBookState();
}

/* class CustomPopupMenu {
  CustomPopupMenu({this.title, this.scene});

  String title;
  int scene;
} */

/* List<CustomPopupMenu> choices = <CustomPopupMenu>[
  CustomPopupMenu(title: 'AR World Map', scene: 0),
  CustomPopupMenu(title: 'Face Mesh', scene: 1),
  CustomPopupMenu(title: 'Check Support', scene: 2),
  CustomPopupMenu(title: 'Camera Image', scene: 3),
  CustomPopupMenu(title: 'Environment Probes', scene: 4),
  CustomPopupMenu(title: 'AR Core Face Regions', scene: 5),
  CustomPopupMenu(title: 'ARKit Face Blend Shapes', scene: 6),
  CustomPopupMenu(title: 'Face Pose', scene: 7),
  CustomPopupMenu(title: 'Human Body Tracking 2D', scene: 8),
  CustomPopupMenu(title: 'Human Body Tracking 3D', scene: 9),
  CustomPopupMenu(title: 'Human Segmentation Images', scene: 10),
  CustomPopupMenu(title: 'Image Tracking', scene: 11),
  CustomPopupMenu(title: 'Light Estimation', scene: 12),
  CustomPopupMenu(title: 'Object Tracking', scene: 13),
  CustomPopupMenu(title: 'Feathered planes', scene: 14),
  CustomPopupMenu(title: 'Toggle Plane Detection', scene: 15),
  CustomPopupMenu(title: 'Scale', scene: 16),
  CustomPopupMenu(title: 'Simple AR', scene: 17),
]; */

class _UnityARBookState extends State<UnityARBook> {
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();
  UnityWidgetController _unityWidgetController;
  //double _sliderValue = 0.0;

  ///////////// disable debuging in release mode
  bool debugingMode = !bool.fromEnvironment("dart.vm.product");
  bool objectPlaced = !bool.fromEnvironment("dart.vm.product");
  /////////////////////////////////

  bool _perventMultipleTab = true;

  //////////////////////////////////// read time
  var watch = Stopwatch();

  void _showFinishReadDialog() {
    ///////////////////////////// go home
    /* Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Home(),
      ),
    ); */
    //////////////////////////// show read Dialog
    /* readDialog.showSlideDialog(
      context: context,
      child: Container(),
    ); */
    //////////////////////////// collected Sticker page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StickerCollected(),
      ),
    );
  }

  void _showArInteractiveDialog() {
    arInteractiveDialog.showSlideDialog(
      context: context,
      child: Container(),
    );
  }

  /* CustomPopupMenu _selectedChoices = choices[0];

  void _select(CustomPopupMenu choice) {
    setState(() {
      _selectedChoices = choice;
    });

    print('Selected');

    _unityWidgetController.postMessage(
      'GameManager',
      'LoadGameScene',
      choice.scene.toString(),
    );
  } */

  int page = 1;
  var subtitleText = '';
  void subtite() {
    /// use switch case with content level
    if (page == 1) {
      Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
          'Todd likes to eat dessert. Candy is his favourite.');
    } else if (page == 2) {
      Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
          'Dad always tells Todd to brush his teeth after eating desserts.');
    } else if (page == 3) {
      Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
          'Todd brushes his teeth twice a day. But Todd has a secret. He often eats candies before his bedtime.');
    } else if (page == 4) {
      Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
          'One night, Todd sleeps with candy in his mouth. He dreams about the candy town.');
    } else if (page == 5) {
      Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
          '"Wow, there are candies everywhere!" said Todd. Todd walks around and eats candies happily.');
    } else if (page == 6) {
      Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
          'Suddenly, Todd feels pain in his mouth. He looks at the mirror and opens his mouth.');
    } else if (page == 7) {
      Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
          'Something is moving in his mouth. "ahh, candy monster" screamed Todd.');
    } else if (page == 8) {
      Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
          'Todd tries to pick them out but he can\'t. Could anyone please help Todd?');
    } else if (page == 9) {
      _showArInteractiveDialog();
      Provider.of<DataProvider>(context, listen: false)
          .setInputSubtitle('There are ten candy monsters in Todd\'s mouth.');
    } else if (page == 10) {
      Provider.of<DataProvider>(context, listen: false)
          .setInputSubtitle('Candy monsters are gone but his teeth decay.');
    } else if (page == 11) {
      Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
          'Todd wakes up and feels pain in his teeth then he cries.');
    } else if (page == 12) {
      Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
          'Dad comes to see Todd. He sees candy on Todd\'s bed then he knows that Todd secretly eats candies before sleep');
    } else if (page == 13) {
      Provider.of<DataProvider>(context, listen: false)
          .setInputSubtitle('Dad takes Todd to see the dentist.');
    } else if (page == 14) {
      Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
          'The dentist treats Todd\'s teeth and tells him not to eat dessert too much and brush teeth after eating or twice a day.');
    } else if (page == 15) {
      Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
          'Todd sincerely promises to his dad that he will brush his teeth twice a day and he won\'t eat candy before sleep again.');
    } else if (page == 16) {
      Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
          'Todd now have a clean white teeth and never have toothache again');
    }
    Provider.of<DataProvider>(context, listen: false).subtitleData();
  }

  @override
  void initState() {
    Provider.of<DataProvider>(context, listen: false).resetSubtitleState();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    Provider.of<DataProvider>(context, listen: false).subtitleData();

    ///////////////////// start count read timer
    !watch.isRunning ? watch.start() : null;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              color: Colors.black,
            ),
            debugingMode
                ? Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                          'w' +
                              deviceWidth.toString() +
                              ' * h' +
                              deviceHeight.toString(),
                          style: TextStyle(
                              fontFamily: 'NunitoBold',
                              fontSize: 35,
                              color: Colors.white)),
                    ),
                  )
                : Container(),

            !debugingMode
                ? UnityWidget(
                    onUnityViewCreated: onUnityCreated,
                    isARScene: true,
                    onUnityMessage: onUnityMessage,
                  )
                : Container(),

            //////////////////////////////////////////////////
            /* Positioned.fill(
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  margin: EdgeInsets.only(top: 300),
                  height: 50,
                  width: 50,
                  child: PopupMenuButton<CustomPopupMenu>(
                    elevation: 3.2,
                    color: Colors.white,
                    initialValue: choices[0],
                    onCanceled: () {
                      print('You have not chossed anything');
                    },
                    tooltip: 'This is tooltip',
                    onSelected: _select,
                    itemBuilder: (BuildContext context) {
                      return choices.map((CustomPopupMenu choice) {
                        return PopupMenuItem<CustomPopupMenu>(
                          value: choice,
                          child: Text(choice.title),
                        );
                      }).toList();
                    },
                  ),
                ),
              ),
            ), */
            /////////////////////// home Btn
            Positioned.fill(
              child: Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: _perventMultipleTab
                      ? () async {
                          !debugingMode ? reloadSession() : null;
                          setState(() {
                            _perventMultipleTab = false;
                          });

                          Timer(Duration(seconds: 1),
                              () => setState(() => _perventMultipleTab = true));
                          Navigator.pop(context);
                        }
                      : null,
                  child: Container(
                    margin: EdgeInsets.only(
                      top: deviceHeight > 500
                          ? deviceWidth * 0.02
                          : deviceWidth * 0.02,
                      left: deviceHeight > 500
                          ? deviceWidth * 0.02
                          : deviceWidth * 0.02,
                    ),
                    height: deviceHeight > 500
                        ? deviceHeight * 0.104
                        : deviceHeight * 0.17,
                    child: Image.asset('assets/images/enterBook/homeBtn.png'),
                  ),
                ),
              ),
            ),
            //////////////////////// 3d Btn
            objectPlaced
                ? Positioned.fill(
                    child: Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {
                          print('tab3D! Send Char == ' +
                              Provider.of<DataProvider>(context, listen: false)
                                  .avatar[Provider.of<DataProvider>(context,
                                      listen: false)
                                  .currentKids]);
                          //////////////////// send selected character message to unity
                          _unityWidgetController.postMessage(
                            'AR Session Origin',
                            'MainCharacterSelected',
                            Provider.of<DataProvider>(context, listen: false)
                                .avatar[Provider.of<DataProvider>(context,
                                    listen: false)
                                .currentKids],
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                            top: deviceHeight > 500
                                ? deviceWidth * 0.02
                                : deviceWidth * 0.02,
                            right: deviceHeight > 500
                                ? deviceWidth * 0.02
                                : deviceWidth * 0.02,
                          ),
                          height: deviceHeight > 500
                              ? deviceHeight * 0.104
                              : deviceHeight * 0.17,
                          child: Image.asset('assets/images/arUI/3dBtn.png'),
                        ),
                      ),
                    ),
                  )
                : Container(),

            //////////////////////// Subtitle Row
            objectPlaced
                ? Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        //alignment: Alignment.center,
                        height: deviceHeight > 500
                            ? deviceHeight * (140 / 1024)
                            : deviceHeight * (290 / 1024),
                        color: Color.fromRGBO(255, 255, 255, 0.93),
                        child: Row(
                          children: <Widget>[
                            //////////////////////// back Btn
                            objectPlaced
                                ? GestureDetector(
                                    onTap: backwardPage,
                                    child: Container(
                                      height: deviceHeight > 500
                                          ? deviceHeight * (140 / 1024) * 0.8
                                          : deviceHeight * (290 / 1024) * 0.8,
                                      child: Image.asset(
                                          'assets/images/arUI/button_book_back.png'),
                                    ),
                                  )
                                : Container(),
                            /* Spacer(), */
                            ///////////////////////////// Subtitle Text
                            Expanded(
                              child: Container(
                                height: double.infinity,
                                /*width: deviceWidth-((deviceHeight * (140 / 1024) * 0.8 * (149/140))*2), */
                                padding: EdgeInsets.only(
                                    top: deviceHeight > 500
                                        ? deviceHeight * (290 / 1024) * 0.06
                                        : deviceHeight * (290 / 1024) * 0.06,
                                    bottom: deviceHeight > 500
                                        ? deviceHeight * (290 / 1024) * 0.06
                                        : deviceHeight * (290 / 1024) * 0.06,
                                    left: deviceHeight > 500
                                        ? deviceHeight * (290 / 1024) * 0.2
                                        : deviceHeight * (290 / 1024) * 0.06,
                                    right: deviceHeight > 500
                                        ? deviceHeight * (290 / 1024) * 0.2
                                        : deviceHeight * (290 / 1024) * 0.06),
                                child: Consumer<DataProvider>(
                                  builder: (context, provider, child) => Wrap(
                                      alignment: WrapAlignment.center,
                                      runAlignment: WrapAlignment.center,
                                      children: provider.subtitleItems),
                                ),
                              ),
                            ),

                            //////////////////////// forward Btn
                            objectPlaced
                                ? GestureDetector(
                                    onTap: forwardPage,
                                    child: Container(
                                      height: deviceHeight > 500
                                          ? deviceHeight * (140 / 1024) * 0.8
                                          : deviceHeight * (290 / 1024) * 0.8,
                                      child: Image.asset(
                                          'assets/images/arUI/button_book_forward.png'),
                                    ),
                                  )
                                : Container(),
                            //////////////////////////
                          ],
                        ),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  void reloadSession() {
    objectPlaced = false;
    page = 1;
    subtitleText = '';
    _unityWidgetController.postMessage(
      'SessionReset',
      'ReloadSession',
      '',
    );
  }

  void forwardPage() {
    if (objectPlaced) {
      print('page == ' + page.toString());

      setState(() {
        if (page <= 16) {
          page++;
        }
      });
      ////////////////////////// finished reading
      if (page > 16) {
        _showFinishReadDialog();
        Provider.of<DataProvider>(context, listen: false)
            .finishedReading(watch.elapsed.inSeconds, 'book1');
        !bool.fromEnvironment("dart.vm.product")
            ? print('readedTime == ' + watch.elapsed.inSeconds.toString())
            : null;
      }
      subtite();
      if (page == 3 ||
          page == 5 ||
          page == 6 ||
          page == 11 ||
          page == 13 ||
          page == 16) {
        !debugingMode
            ? _unityWidgetController.postMessage(
                'pageController',
                'forwardScene',
                '',
              )
            : null;
      }
    }
  }

  void backwardPage() {
    if (objectPlaced) {
      setState(() {
        if (page > 1) {
          page--;
        }
      });
      subtite();
      if (page == 2 ||
          page == 4 ||
          page == 5 ||
          page == 10 ||
          page == 12 ||
          page == 15) {
        !debugingMode
            ? _unityWidgetController.postMessage(
                'pageController',
                'backwardScene',
                '',
              )
            : null;
      }
    }
  }

  void onUnityMessage(controller, message) {
    if (message == 'Placed object') {
      setState(() {
        objectPlaced = true;
        subtitleText = "Todd likes to eat dessert. Candy is his favourite.";
      });
    }
    print('Received message from unity: ${message.toString()}');
  }

  // Callback that connects the created controller to the unity controller
  void onUnityCreated(controller) {
    this._unityWidgetController = controller;
    //////////////////// send selected character message to unity
    _unityWidgetController.postMessage(
      'AR Session Origin',
      'MainCharacterSelected',
      Provider.of<DataProvider>(context, listen: false).avatar[
          Provider.of<DataProvider>(context, listen: false).currentKids],
    );
  }
}

class SubtitleSpeakable extends StatelessWidget {
  const SubtitleSpeakable({
    Key key,
    @required this.word,

    //@required this.textSelectedList,
    @required this.id,
  }) : super(key: key);

  final String word;

  //final List<bool> textSelectedList;
  final int id;

  @override
  Widget build(BuildContext context) {
    final assetsAudioPlayer = AssetsAudioPlayer();

    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Consumer<DataProvider>(
        builder: (context, provider, child) => MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 100),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: provider.textSelected[id]
                      ? Color.fromRGBO(69, 223, 224, 1.0)
                      : Color.fromRGBO(69, 223, 224, 0.0),
                ),
                padding: EdgeInsets.all(
                  deviceHeight > 500
                      ? deviceHeight * (140 / 1024) * 0.020
                      : deviceHeight * (290 / 1024) * 0.020,
                ),
                child: GestureDetector(
                  onTap: Provider.of<DataProvider>(context, listen: false)
                          .allowTab
                      ? () async {
                          //////////////////// highlight word selected
                          Provider.of<DataProvider>(context, listen: false)
                              .onTextSelected(id);

                          /* await assetsAudioPlayer.open(
                      Audio('assets/ttsAudio/candyMonster/level1/'+word.replaceAll(new RegExp(r'(?:_|[^\w\s])+'), '')+'.mp3'),
                    ); */

                          ////////////////// disable tab other word while speaking
                          Provider.of<DataProvider>(context, listen: false)
                              .disableTab();

                          ////////////////// play sound and auto dispose
                          AssetsAudioPlayer.playAndForget(Audio(
                              'assets/ttsAudio/candyMonster/level1/' +
                                  word.toLowerCase().replaceAll(
                                      new RegExp(r'(?:_|[^\w\s])+'), '') +
                                  '.mp3'));
                          //assetsAudioPlayer.play();

                          //////////////////////////////// when finished speaking
                          assetsAudioPlayer.playlistFinished.listen((finished) {
                            Future.delayed(const Duration(milliseconds: 600),
                                () {
                              ///////////////////////// dis highlight word
                              Provider.of<DataProvider>(context, listen: false)
                                  .onTextSelectedFinished();
                              ///////////////////////// enable gesture detection
                              Provider.of<DataProvider>(context, listen: false)
                                  .enableTab();
                            });
                          });
                        }
                      : () {},
                  child: Text(
                    word,
                    style: TextStyle(
                        fontFamily: 'NunitoBold',
                        fontSize: (() {
                          if (deviceWidth > 1100) {
                            return 28.0;
                          } // Big tablet
                          else if (deviceWidth < 1100 && deviceWidth > 910) {
                            return 23.0;
                          } // normal tablet
                          else if (deviceWidth < 910 && deviceWidth > 800) {
                            return 20.0;
                          } // phone large
                          else if (deviceWidth > 600 && deviceWidth < 800) {
                            return 17.0;
                          } // phone medium
                          else if (deviceWidth < 600) {
                            return 14.5;
                          } // phone small
                        }()),
                        color: provider.textSelected[id]
                            ? Colors.white
                            : Color.fromRGBO(112, 112, 112, 1.00)),
                  ),
                ),
              ),
            ));
  }
}
