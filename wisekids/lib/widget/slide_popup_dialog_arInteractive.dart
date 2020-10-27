import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:flare_flutter/flare_actor.dart';
import '../provider/audioProvider.dart';

import 'package:provider/provider.dart';
import '../provider/ttsProvider.dart';

import '../provider/dataProvider.dart';

/// Display slide dialog.
///
/// `barrierColor` Color of outside dialog. Defaults to Colors.black.withOpacity(0.7).
///
/// `barrierDismissible` Can be dismissed by tapping outside dialog. Defaults to true.
///
/// `transitionDuration` Duration of slide transition. Defaults to Duration(milliseconds: 300).
///
/// `pillColor` Color of pill inside dialog. Defaults to Colors.blueGrey[200].
///
/// `backgroundColor` Color of dialog background. Defaults to Theme.of(context).canvasColor.
Future<T> showSlideDialog<T>({
  @required BuildContext context,
  @required Widget child,
  Color barrierColor,
  bool barrierDismissible = true,
  Duration transitionDuration = const Duration(milliseconds: 300),
  Color pillColor,
  Color backgroundColor,
  Color containerColor,
  List<Color> bgGradient,
  List<double> gradientStop,
  bool propVisibility,
}) {
  assert(context != null);
  assert(child != null);

  return showGeneralDialog(
    context: context,
    pageBuilder: (context, animation1, animation2) {
      return;
    },
    barrierColor: barrierColor ?? Colors.black.withOpacity(0.7),
    //barrierDismissible: barrierDismissible,
    barrierDismissible: false,
    barrierLabel: "Dismiss",
    transitionDuration: transitionDuration,
    transitionBuilder: (context, animation1, animation2, widget) {
      final curvedValue = Curves.easeInOut.transform(animation1.value) - 1.0;
      return Transform(
        transform: Matrix4.translationValues(0.0, curvedValue * -300, 0.0),
        child: Opacity(
          opacity: animation1.value,
          child: SlideDialogArInteractive(
            child: child,
          ),
        ),
      );
    },
  );
}

//////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////

class SlideDialogArInteractive extends StatefulWidget {
  final Widget child;

  SlideDialogArInteractive({
    @required this.child,
  });

  @override
  _SlideDialogArInteractiveState createState() =>
      _SlideDialogArInteractiveState();
}

class _SlideDialogArInteractiveState extends State<SlideDialogArInteractive> {
  //var _initialPosition = 0.0;
  var _currentPosition = 0.0;

  //////////////////////////////////////// monster variable
  bool monster1Glow = false;
  bool monster2Glow = false;
  bool monster3Glow = false;
  bool monster4Glow = false;
  bool monster5Glow = false;
  bool monster6Glow = false;
  bool monster7Glow = false;
  bool monster8Glow = false;
  bool monster9Glow = false;
  bool monster10Glow = false;

  double monster1Opacity = 1.0;
  double monster2Opacity = 1.0;
  double monster3Opacity = 1.0;
  double monster4Opacity = 1.0;
  double monster5Opacity = 1.0;
  double monster6Opacity = 1.0;
  double monster7Opacity = 1.0;
  double monster8Opacity = 1.0;
  double monster9Opacity = 1.0;
  double monster10Opacity = 1.0;

  int fadeDelay = 250; //millisecond
  int fadeDuration = 500; //millisecond

  String numberVocab = 'ONE !';
  double fadeTextOpacity = 0.0;
  int fadeTextDuration = 0;
  int touchLockIndex = 1;
  int textNumberCount = 1;

  int fadeExcellenceDuration = 0;
  int fadeMonsterGoneDuration = 0;
  double fadeExcellenceOpacity = 0.0;
  double fadeMonsterGoneOpacity = 0.0;

  bool animationController = false;

  int fadeBlackBGDuration = 0;
  double fadeBlackBGOpacity = 0.0;

  void textVocab() {
    if (textNumberCount == 1) {
      Provider.of<TTSProvider>(context, listen: false).speak("one");

      numberVocab = 'ONE !  ';
    } else if (textNumberCount == 2) {
      Provider.of<TTSProvider>(context, listen: false).speak("two");
      numberVocab = 'TWO !  ';
    } else if (textNumberCount == 3) {
      Provider.of<TTSProvider>(context, listen: false).speak("three");
      numberVocab = 'THREE !  ';
    } else if (textNumberCount == 4) {
      Provider.of<TTSProvider>(context, listen: false).speak("four");
      numberVocab = 'FOUR !  ';
    } else if (textNumberCount == 5) {
      Provider.of<TTSProvider>(context, listen: false).speak("five");
      numberVocab = 'FIVE !  ';
    } else if (textNumberCount == 6) {
      Provider.of<TTSProvider>(context, listen: false).speak("six");
      numberVocab = 'SIX !  ';
    } else if (textNumberCount == 7) {
      Provider.of<TTSProvider>(context, listen: false).speak("seven");
      numberVocab = 'SEVEN !  ';
    } else if (textNumberCount == 8) {
      Provider.of<TTSProvider>(context, listen: false).speak("eight");
      numberVocab = 'EIGHT !  ';
    } else if (textNumberCount == 9) {
      Provider.of<TTSProvider>(context, listen: false).speak("nine");
      numberVocab = 'NINE !  ';
    } else if (textNumberCount == 10) {
      Provider.of<TTSProvider>(context, listen: false).speak("ten");
      numberVocab = 'TEN !  ';
      setState(() {
        animationController = true;
      });
      Future.delayed(Duration(milliseconds: 750), () {
        setState(() {
          fadeBlackBGOpacity = 1.0;
        });
      });
      Future.delayed(Duration(milliseconds: 750), () {
        setState(() {
          fadeExcellenceOpacity = 1.0;
        });
      });
      Future.delayed(Duration(milliseconds: 750), () {
        setState(() {
          fadeMonsterGoneOpacity = 1.0;
        });
      });
      Future.delayed(Duration(milliseconds: 3000), () {
        setState(() {
          Provider.of<AudioProvider>(context, listen: false)
              .playSoundEffect("click3", 1.0);
          Navigator.pop(context);
          Provider.of<DataProvider>(context, listen: false)
              .speakAfterPlayInteractive();
        });
      });
      Future.delayed(Duration(milliseconds: 650), () {
        setState(() {
          fadeTextOpacity = 0.0;
          //touchLockIndex = 1;
        });
      });
    }

    textNumberCount++;

    Future.delayed(Duration(milliseconds: 0), () {
      setState(() {
        fadeTextOpacity = 1.0;
        touchLockIndex = 0;
      });
    });
    Future.delayed(Duration(milliseconds: 0), () {
      setState(() {
        fadeTextOpacity = 1.0;
        touchLockIndex = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    final contentWidth = deviceHeight > 500
        ? deviceWidth * 941 / 1024
        : deviceHeight * (941 / 712);
    var contentHeight = deviceHeight > 500
        ? deviceWidth * (941 / 1024) * (712 / 941)
        : deviceHeight;

    return WillPopScope(
      onWillPop: () async => false,
      child: AnimatedPadding(
        padding: EdgeInsets.only(top: 0),
        duration: Duration(milliseconds: 100),
        curve: Curves.decelerate,
        child: MediaQuery.removeViewInsets(
          removeLeft: true,
          removeTop: true,
          removeRight: true,
          removeBottom: true,
          context: context,
          child: Stack(
            children: <Widget>[
              Center(
                //////////////////////////// mountBg
                child: Container(
                  width: deviceHeight > 500 ? deviceWidth * 941 / 1024 : null,
                  //height: MediaQuery.of(context).size.height,
                  child: AspectRatio(
                      aspectRatio: 941 / 712,
                      child: Image.asset(
                          'assets/images/arInteractive/mountBg.png')),
                ),
              ),

              //////////////////////////// Content
              Center(
                child: Container(
                  width: deviceHeight > 500 ? deviceWidth * 941 / 1024 : null,
                  //height: MediaQuery.of(context).size.height,
                  child: AspectRatio(
                      aspectRatio: 941 / 712,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: contentHeight * (10 / 712),
                          right: contentHeight * (10 / 941),
                          bottom: contentHeight * (20 / 712),
                          top: contentHeight * (71 / 712),
                        ),
                        child: Stack(
                          children: <Widget>[
                            /////////////////////////////////////////// Text Vocabulary
                            Material(
                              color: Colors.transparent,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: contentHeight * 159 / 712,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    AnimatedOpacity(
                                      duration: Duration(
                                          milliseconds: fadeTextDuration),
                                      curve: Curves.elasticInOut,
                                      opacity: fadeTextOpacity,
                                      child: Container(
                                        height: contentHeight * (69 / 712),
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            numberVocab,
                                            style: TextStyle(
                                                fontFamily: 'NunitoBold',
                                                fontSize: 50,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            /////////////////////// monster1
                            monster1Glow
                                ? AnimatedOpacity(
                                    duration:
                                        Duration(milliseconds: fadeDuration),
                                    curve: Curves.elasticInOut,
                                    opacity: monster1Opacity,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          top: contentHeight * 302 / 712),
                                      height: contentHeight * (208 / 712),
                                      child: Image.asset(
                                        'assets/images/arInteractive/monster1_light.png',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        monster1Glow = true;
                                        textVocab();
                                        Future.delayed(
                                            Duration(milliseconds: fadeDelay),
                                            () {
                                          setState(() {
                                            monster1Opacity = 0.0;
                                          });
                                        });
                                      });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          top: contentHeight * 342 / 712),
                                      height: contentHeight * (121 / 712),
                                      child: Image.asset(
                                        'assets/images/arInteractive/monster1.png',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                            /////////////////////// monster2
                            monster2Glow
                                ? AnimatedOpacity(
                                    duration:
                                        Duration(milliseconds: fadeDuration),
                                    curve: Curves.elasticInOut,
                                    opacity: monster2Opacity,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          top: contentHeight * 127 / 712,
                                          left: contentHeight * 42 / 712),
                                      height: contentHeight * (273 / 712),
                                      child: Image.asset(
                                        'assets/images/arInteractive/monster2_light.png',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        monster2Glow = true;
                                        textVocab();
                                        Future.delayed(
                                            Duration(milliseconds: fadeDelay),
                                            () {
                                          setState(() {
                                            monster2Opacity = 0.0;
                                          });
                                        });
                                      });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          top: contentHeight * 195 / 712,
                                          left: contentHeight * 124 / 712),
                                      height: contentHeight * (182 / 712),
                                      child: Image.asset(
                                        'assets/images/arInteractive/monster2.png',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                            /////////////////////// monster3
                            monster3Glow
                                ? AnimatedOpacity(
                                    duration:
                                        Duration(milliseconds: fadeDuration),
                                    curve: Curves.elasticInOut,
                                    opacity: monster3Opacity,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          top: contentHeight * 382 / 712,
                                          left: contentHeight * 89 / 712),
                                      height: contentHeight * (131 / 712),
                                      child: Image.asset(
                                        'assets/images/arInteractive/monster3_light.png',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        monster3Glow = true;
                                        textVocab();
                                        Future.delayed(
                                            Duration(milliseconds: fadeDelay),
                                            () {
                                          setState(() {
                                            monster3Opacity = 0.0;
                                          });
                                        });
                                      });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          top: contentHeight * 426 / 712,
                                          left: contentHeight * 139 / 712),
                                      height: contentHeight * (66 / 712),
                                      child: Image.asset(
                                        'assets/images/arInteractive/monster3.png',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                            /////////////////////// monster4
                            monster4Glow
                                ? AnimatedOpacity(
                                    duration:
                                        Duration(milliseconds: fadeDuration),
                                    curve: Curves.elasticInOut,
                                    opacity: monster4Opacity,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          top: contentHeight * 490 / 712,
                                          left: contentHeight * 190 / 712),
                                      height: contentHeight * (104 / 712),
                                      child: Image.asset(
                                        'assets/images/arInteractive/monster4_light.png',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        monster4Glow = true;
                                        textVocab();
                                        Future.delayed(
                                            Duration(milliseconds: fadeDelay),
                                            () {
                                          setState(() {
                                            monster4Opacity = 0.0;
                                          });
                                        });
                                      });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          top: contentHeight * 518 / 712,
                                          left: contentHeight * 220 / 712),
                                      height: contentHeight * (70 / 712),
                                      child: Image.asset(
                                        'assets/images/arInteractive/monster4.png',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                            /////////////////////// monster5
                            monster5Glow
                                ? AnimatedOpacity(
                                    duration:
                                        Duration(milliseconds: fadeDuration),
                                    curve: Curves.elasticInOut,
                                    opacity: monster5Opacity,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          top: contentHeight * 0 / 712,
                                          left: contentHeight * 190 / 712),
                                      height: contentHeight * (211 / 712),
                                      child: Image.asset(
                                        'assets/images/arInteractive/monster5_light.png',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        monster5Glow = true;
                                        textVocab();
                                        Future.delayed(
                                            Duration(milliseconds: fadeDelay),
                                            () {
                                          setState(() {
                                            monster5Opacity = 0.0;
                                          });
                                        });
                                      });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          top: contentHeight * 58 / 712,
                                          left: contentHeight * 253 / 712),
                                      height: contentHeight * (129 / 712),
                                      child: Image.asset(
                                        'assets/images/arInteractive/monster5.png',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                            /////////////////////// monster6
                            monster6Glow
                                ? AnimatedOpacity(
                                    duration:
                                        Duration(milliseconds: fadeDuration),
                                    curve: Curves.elasticInOut,
                                    opacity: monster6Opacity,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          top: contentHeight * 286 / 712,
                                          left: contentHeight * 337 / 712),
                                      height: contentHeight * (236 / 712),
                                      child: Image.asset(
                                        'assets/images/arInteractive/monster6_light.png',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        monster6Glow = true;
                                        textVocab();
                                        Future.delayed(
                                            Duration(milliseconds: fadeDelay),
                                            () {
                                          setState(() {
                                            monster6Opacity = 0.0;
                                          });
                                        });
                                      });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          top: contentHeight * 331 / 712,
                                          left: contentHeight * 362 / 712),
                                      height: contentHeight * (164 / 712),
                                      child: Image.asset(
                                        'assets/images/arInteractive/monster6.png',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                            /////////////////////// monster7
                            monster7Glow
                                ? AnimatedOpacity(
                                    duration:
                                        Duration(milliseconds: fadeDuration),
                                    curve: Curves.elasticInOut,
                                    opacity: monster7Opacity,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          top: contentHeight * 339 / 712,
                                          left: contentHeight * 571 / 712),
                                      height: contentHeight * (183 / 712),
                                      child: Image.asset(
                                        'assets/images/arInteractive/monster7_light.png',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        monster7Glow = true;
                                        textVocab();
                                        Future.delayed(
                                            Duration(milliseconds: fadeDelay),
                                            () {
                                          setState(() {
                                            monster7Opacity = 0.0;
                                          });
                                        });
                                      });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          top: contentHeight * 358 / 712,
                                          left: contentHeight * 617 / 712),
                                      height: contentHeight * (138 / 712),
                                      child: Image.asset(
                                        'assets/images/arInteractive/monster7.png',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                            /////////////////////// monster8
                            monster8Glow
                                ? AnimatedOpacity(
                                    duration:
                                        Duration(milliseconds: fadeDuration),
                                    curve: Curves.elasticInOut,
                                    opacity: monster8Opacity,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          top: contentHeight * 20 / 712,
                                          left: contentHeight * 553 / 712),
                                      height: contentHeight * (255 / 712),
                                      child: Image.asset(
                                        'assets/images/arInteractive/monster8_light.png',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        monster8Glow = true;
                                        textVocab();
                                        Future.delayed(
                                            Duration(milliseconds: fadeDelay),
                                            () {
                                          setState(() {
                                            monster8Opacity = 0.0;
                                          });
                                        });
                                      });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          top: contentHeight * 78 / 712,
                                          left: contentHeight * 620 / 712),
                                      height: contentHeight * (153 / 712),
                                      child: Image.asset(
                                        'assets/images/arInteractive/monster8.png',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                            /////////////////////// monster9
                            monster9Glow
                                ? AnimatedOpacity(
                                    duration:
                                        Duration(milliseconds: fadeDuration),
                                    curve: Curves.elasticInOut,
                                    opacity: monster9Opacity,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          top: contentHeight * 409 / 712,
                                          left: contentHeight * 754 / 712),
                                      height: contentHeight * (177 / 712),
                                      child: Image.asset(
                                        'assets/images/arInteractive/monster9_light.png',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        monster9Glow = true;
                                        textVocab();
                                        Future.delayed(
                                            Duration(milliseconds: fadeDelay),
                                            () {
                                          setState(() {
                                            monster9Opacity = 0.0;
                                          });
                                        });
                                      });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          top: contentHeight * 456 / 712,
                                          left: contentHeight * 774 / 712),
                                      height: contentHeight * (94 / 712),
                                      child: Image.asset(
                                        'assets/images/arInteractive/monster9.png',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                            /////////////////////// monster10
                            monster10Glow
                                ? AnimatedOpacity(
                                    duration:
                                        Duration(milliseconds: fadeDuration),
                                    curve: Curves.elasticInOut,
                                    opacity: monster10Opacity,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          top: contentHeight * 218 / 712,
                                          left: contentHeight * 837.5 / 712),
                                      height: contentHeight * (172 / 712),
                                      child: Image.asset(
                                        'assets/images/arInteractive/monster10_light.png',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        monster10Glow = true;
                                        textVocab();
                                        Future.delayed(
                                            Duration(milliseconds: fadeDelay),
                                            () {
                                          setState(() {
                                            monster10Opacity = 0.0;
                                          });
                                        });
                                      });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          top: contentHeight * 234 / 712,
                                          left: contentHeight * 869 / 712),
                                      height: contentHeight * (122 / 712),
                                      child: Image.asset(
                                        'assets/images/arInteractive/monster10.png',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                            ////////////////////////////////////////////////////// Gesture lock
                            Center(
                              child: IndexedStack(
                                index: touchLockIndex,
                                children: <Widget>[
                                  Material(
                                    color: Colors.transparent,
                                    child: Container(
                                      width: 941,
                                      height: 712,
                                    ),
                                  ),
                                  Container(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
              ),

              ////////////////////////////////////////////////////// black opacity BG
              animationController
                  ? AnimatedOpacity(
                      duration: Duration(milliseconds: fadeBlackBGDuration),
                      curve: Curves.fastOutSlowIn,
                      opacity: fadeBlackBGOpacity,
                      child: Container(
                        height: deviceHeight,
                        width: deviceWidth,
                        color: Color.fromRGBO(0, 0, 0, 0.8),
                      ),
                    )
                  : Container(),

              //////////////////////////////////////////////////////// Finished Text
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Material(
                      color: Colors.transparent,
                      child: AnimatedOpacity(
                        duration:
                            Duration(milliseconds: fadeExcellenceDuration),
                        curve: Curves.elasticInOut,
                        opacity: fadeExcellenceOpacity,
                        child: Container(
                          margin: EdgeInsets.only(
                              bottom: contentHeight * (20 / 712)),
                          height: deviceHeight > 500
                              ? contentHeight * (69 / 712)
                              : contentHeight * (75 / 712),
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              'Excellence !',
                              style: TextStyle(
                                  fontFamily: 'NunitoBold',
                                  fontSize: 50,
                                  color: Color.fromRGBO(254, 71, 149, 1.0)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: AnimatedOpacity(
                        duration:
                            Duration(milliseconds: fadeMonsterGoneDuration),
                        curve: Curves.elasticInOut,
                        opacity: fadeMonsterGoneOpacity,
                        child: Container(
                          height: deviceHeight > 500
                              ? contentHeight * (41 / 712)
                              : contentHeight * (47 / 712),
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              'All candy monsters are gone now.',
                              style: TextStyle(
                                  fontFamily: 'NunitoBold',
                                  fontSize: 30,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //////////////////////////// close Btn
              /* Positioned.fill(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      decoration: new BoxDecoration(
                        borderRadius: BorderRadius.circular(500),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.1),
                            blurRadius:
                                10.0, // has the effect of softening the shadow
                            spreadRadius:
                                -1, // has the effect of extending the shadow
                            offset: Offset(
                              0.0, // horizontal, move right 10
                              0.0, // vertical, move down 10
                            ),
                          ),
                        ],
                      ),
                      margin: EdgeInsets.only(
                          right: deviceHeight > 500
                              ? deviceHeight * 0.05
                              : deviceHeight * 0.05,
                          top: deviceHeight > 500
                              ? deviceHeight * 0.05
                              : deviceHeight * 0.05),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            return;
                          },
                          child: Container(
                            height: deviceHeight > 500
                                ? deviceWidth * 0.078
                                : deviceWidth * 0.078,
                            child: SvgPicture.asset(
                                'assets/images/vocabulary/closeBtn.svg'),
                          )),
                    ),
                  ),
                ), */
              ////////////////////////////////////////////////////////////////
            ],
          ),
        ),
      ),
    );
  }
}
