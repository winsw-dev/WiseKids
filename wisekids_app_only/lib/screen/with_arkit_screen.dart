import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';

import '../widget/slide_popup_dialog_read.dart' as readDialog;
import '../widget/slide_popup_dialog_arInteractive.dart' as arInteractiveDialog;

import 'home.dart';

class WithARkitScreen extends StatefulWidget {
  @override
  _WithARkitScreenState createState() => _WithARkitScreenState();
}

class CustomPopupMenu {
  CustomPopupMenu({this.title, this.scene});

  String title;
  int scene;
}

List<CustomPopupMenu> choices = <CustomPopupMenu>[
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
];

class _WithARkitScreenState extends State<WithARkitScreen> {
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();
  UnityWidgetController _unityWidgetController;
  double _sliderValue = 0.0;

  

  void _showVocabDialog() {
    readDialog.showSlideDialog(
      context: context,
      child: Container(),
    );
  }

  void _showArInteractiveDialog() {
    arInteractiveDialog.showSlideDialog(
      context: context,
      child: Container(),
    );
  }

  CustomPopupMenu _selectedChoices = choices[0];

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
  }

  bool objectPlaced = false;
  int page = 1;
  var subtitleText = '';
  void subtite() {
    if (page == 1) {
      setState(() {
        subtitleText = 'Todd likes to eat dessert. Candy is his favourite.';
      });
    } else if (page == 2) {
      setState(() {
        subtitleText =
            'Dad always tells Todd to brush his teeth after eating desserts.';
      });
    } else if (page == 3) {
      setState(() {
        subtitleText =
            'Todd brushes his teeth twice a day. But Todd has a secret. \n He often eats candies before his bedtime.';
      });
    } else if (page == 4) {
      setState(() {
        subtitleText =
            'One night, Todd sleeps with candy in his mouth. \n He dreams about the candy town.';
      });
    } else if (page == 5) {
      setState(() {
        subtitleText =
            '"Wow, there are candies everywhere!" said Todd. \n Todd walks around and eats candies happily.';
      });
    } else if (page == 6) {
      setState(() {
        subtitleText =
            'Suddenly, Todd feels pain in his mouth.\n He looks at the mirror and opens his mouth.';
      });
    } else if (page == 7) {
      setState(() {
        subtitleText =
            'Something is moving in his mouth.\n "ahh, candy monster" screamed Todd.';
      });
    } else if (page == 8) {
      setState(() {
        subtitleText =
            'Todd tries to pick them out but he can\'t. \n Could anyone please help Todd?';
      });
    } else if (page == 9) {
      _showArInteractiveDialog();
      setState(() {
        subtitleText = 'There are ten candy monsters in Todd\'s mouth.';
      });
    } else if (page == 10) {
      setState(() {
        subtitleText = 'Candy monsters are gone but his teeth decay.';
      });
    } else if (page == 11) {
      setState(() {
        subtitleText =
            'Todd wakes up and feels pain in his teeth then he cries.';
      });
    } else if (page == 12) {
      setState(() {
        subtitleText =
            'Dad comes to see Todd. He sees candy on Todd\'s bed \n then he knows that Todd secretly eats candies before sleep';
      });
    } else if (page == 13) {
      setState(() {
        subtitleText = 'Dad takes Todd to see the dentist.';
      });
    } else if (page == 14) {
      setState(() {
        subtitleText =
            'The dentist treats Todd\'s teeth and tells him not to eat \n dessert too much and brush teeth after eating or twice a day.';
      });
    } else if (page == 15) {
      setState(() {
        subtitleText =
            'Todd sincerely promises to his dad that he will brush his teeth \n twice a day and he won\'t eat candy before sleep again.';
      });
    } else if (page == 16) {
      setState(() {
        subtitleText =
            'Todd now have a clean white teeth and \n never have toothache again';
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          UnityWidget(
            onUnityViewCreated: onUnityCreated,
            isARScene: true,
            onUnityMessage: onUnityMessage,
          ),
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
                onTap: () {
                  reloadSession();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Home(),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(top: 15, left: 15),
                  width: 80,
                  child: Image.asset('assets/images/arUI/home.png'),
                ),
              ),
            ),
          ),
          //////////////////////// 3d Btn
          Positioned.fill(
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: EdgeInsets.only(top: 15, right: 15),
                width: 80,
                child: Image.asset('assets/images/arUI/3dBtn.png'),
              ),
            ),
          ),

          //////////////////////// Subtitle
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                alignment: Alignment.center,
                height: 106,
                color: Color.fromRGBO(255, 255, 255, 0.93),
                child: Container(
                  margin: EdgeInsets.only(left: 175, right: 175),
                  child: Text(
                    subtitleText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'NunitoBold',
                        fontSize: 25,
                        color: Color.fromRGBO(112, 112, 112, 1.00)),
                  ),
                ),
              ),
            ),
          ),

          //////////////////////// back Btn
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: GestureDetector(
                onTap: backwardPage,
                child: Container(
                  margin: EdgeInsets.only(bottom: 10),
                  width: 80,
                  child: Image.asset('assets/images/arUI/button_book_back.png'),
                ),
              ),
            ),
          ),
          //////////////////////// forward Btn
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: forwardPage,
                child: Container(
                  margin: EdgeInsets.only(bottom: 10),
                  width: 80,
                  child:
                      Image.asset('assets/images/arUI/button_book_forward.png'),
                ),
              ),
            ),
          ),
          //////////////////////////
        ],
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
      if (page == 16) {
        _showVocabDialog();
      }
      setState(() {
        if (page < 16) {
          page++;
        }
      });
      subtite();
      if (page == 4 ||
          page == 6 ||
          page == 7 ||
          page == 12 ||
          page == 14 ||
          page == 16) {
        _unityWidgetController.postMessage(
          'pageController',
          'forwardScene',
          '',
        );
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
      if (page == 13 ||
          page == 11 ||
          page == 6 ||
          page == 5 ||
          page == 3 ||
          page == 15) {
        _unityWidgetController.postMessage(
          'pageController',
          'backwardScene',
          '',
        );
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
  }
}
