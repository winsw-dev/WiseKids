import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'dart:math';
import '../screen/home.dart';
import 'package:provider/provider.dart';
import '../screen/play.dart';
import '../provider/dataProvider.dart';
import '../provider/audioProvider.dart';

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
}) {
  assert(context != null);
  assert(child != null);

  return showGeneralDialog(
    context: context,
    pageBuilder: (context, animation1, animation2) {
      return;
    },
    barrierColor: barrierColor ?? Colors.black.withOpacity(0.7),
    barrierDismissible: barrierDismissible,
    barrierLabel: "Dismiss",
    transitionDuration: transitionDuration,
    transitionBuilder: (context, animation1, animation2, widget) {
      final curvedValue = Curves.easeInOut.transform(animation1.value) - 1.0;
      /* return Transform(
        transform: Matrix4.translationValues(0.0, curvedValue * -300, 0.0),
        child: Opacity(
          opacity: animation1.value,
          child: SlideDialogPlay(
            child: child,
          ),
        ),
      ); */
      return ScaleTransition(
        alignment: Alignment.center,
        scale: CurvedAnimation(
          parent: animation1,
          curve: SpringCurve(),
          reverseCurve: SpringReverseCurve(),
        ),
        child: Opacity(
          opacity: animation1.value,
          child: SlideDialogPlay(
            child: child,
          ),
        ),
      );
    },
  );
}

///////////////////////////////////////////////////////////////
class SpringCurve extends Curve {
  const SpringCurve({
    this.a = 0.22,
    this.w = 6.5,
  });
  final double a;
  final double w;

  @override
  double transformInternal(double t) {
    return -(pow(e, -t / a) * cos(t * w)) + 1;
  }
}

class SpringReverseCurve extends Curve {
  const SpringReverseCurve({
    this.a = 0.15,
    this.w = 6.5,
  });
  final double a;
  final double w;

  @override
  double transformInternal(double t) {
    return -(pow(e, -t / a) * cos(t * w)) + 1;
  }
}

/////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
class SlideDialogPlay extends StatefulWidget {
  final Widget child;

  SlideDialogPlay({
    @required this.child,
  });

  @override
  _SlideDialogPlayState createState() => _SlideDialogPlayState();
}

class _SlideDialogPlayState extends State<SlideDialogPlay> {
  bool _perventMultipleTab = true;

  ///////////////////////////////////////////// use this override to prevent [ setState() called after dispose() ] error!!
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async => false,
      child: AnimatedPadding(
        padding: /*  MediaQuery.of(context).viewInsets + */ EdgeInsets.all(0),
        /* MediaQuery.of(context).viewInsets +
            EdgeInsets.only(top: deviceHeight / 3.0 + _currentPosition), */
        duration: Duration(milliseconds: 100),
        curve: Curves.bounceInOut,
        child: MediaQuery.removeViewInsets(
          removeLeft: true,
          removeTop: true,
          removeRight: true,
          removeBottom: true,
          context: context,
          child: Scaffold(
            ////////////////////// avoid bottom notch pading
            resizeToAvoidBottomPadding: false,
            backgroundColor: Colors.transparent,
            body: Stack(
              children: <Widget>[
                Container(
                  width: deviceWidth,
                  height: deviceHeight,
                  child: FlareActor("assets/animation/balloon.flr",
                      fit: BoxFit.fitWidth, animation: 'balloon'),
                ),
                Center(
                  child: Container(
                    height: deviceHeight > 500
                        ? deviceHeight * (317 / 768) * (436 / 317)
                        : deviceHeight * (276 / 414) * (379 / 276),
                    child: AspectRatio(
                      aspectRatio: 540 / 436,
                      child: Stack(
                        children: <Widget>[
                          /////////////////////////////////////////////// dialog Bg
                          Container(
                              margin: EdgeInsets.only(
                                  top: deviceHeight > 500
                                      ? deviceHeight * 0.095
                                      : deviceHeight *
                                          (276 / 414) *
                                          (66 / 276)),
                              height: deviceHeight > 500
                                  ? deviceHeight * (317 / 768)
                                  : deviceHeight * (276 / 414),
                              child: Image.asset(
                                'assets/images/readDialog/dialogBgFix.png',
                                fit: BoxFit.contain,
                              )),

                          //////////////////////////////////////////////// Congratulation Sign
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                  height: deviceHeight > 500
                                      ? deviceHeight * (317 / 768) * (116 / 317)
                                      : deviceHeight *
                                          (276 / 414) *
                                          (101 / 276),
                                  child: Image.asset(
                                    'assets/images/playDialog/congratSign.png',
                                    fit: BoxFit.contain,
                                  )),
                            ),
                          ),

                          //////////////////////////////////////////////// 3 Star Icon
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                margin: EdgeInsets.only(
                                  top: deviceHeight > 500
                                      ? deviceHeight * (317 / 768) * (80 / 317)
                                      : deviceHeight * (276 / 414) * (70 / 276),
                                ),
                                height: deviceHeight > 500
                                    ? deviceHeight * (317 / 768) * (140 / 317)
                                    : deviceHeight * (276 / 414) * (130 / 276),
                                child: FlareActor(
                                  "assets/animation/3star.flr",
                                  artboard: '3star',
                                  animation: 'animation',
                                  fit: BoxFit.contain,
                                ), /* Image.asset(
                                    'assets/images/readDialog/3star.png',
                                    fit: BoxFit.contain, 
                                  )*/
                              ),
                            ),
                          ),
                          ///////////////////////////////////////////////// You're really improving Text
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                  margin: EdgeInsets.only(
                                    top: deviceHeight > 500
                                        ? deviceHeight *
                                            (317 / 768) *
                                            (219 / 317)
                                        : deviceHeight *
                                            (276 / 414) *
                                            (200 / 276),
                                  ),
                                  height: deviceHeight > 500
                                      ? deviceHeight * (317 / 768) * (34 / 317)
                                      : deviceHeight * (276 / 414) * (30 / 276),
                                  child: FittedBox(
                                    fit: BoxFit.fitHeight,
                                    child: Text(
                                      'You are really improving.',
                                      style: TextStyle(
                                          fontFamily: 'NunitoRegular',
                                          color: Colors.white),
                                    ),
                                  )),
                            ),
                          ),
                          ////////////////////////////////////////////////////////////////  Stars Score
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                  margin: EdgeInsets.only(
                                    top: deviceHeight > 500
                                        ? deviceHeight *
                                            (317 / 768) *
                                            (275 / 317)
                                        : deviceHeight *
                                            (276 / 414) *
                                            (245 / 276),
                                  ),
                                  child: Stack(
                                    children: <Widget>[
                                      /////////////////////////  star frame BG
                                      Container(
                                        height: deviceHeight > 500
                                            ? deviceHeight *
                                                (317 / 768) *
                                                (47 / 317)
                                            : deviceHeight *
                                                (276 / 414) *
                                                (42 / 276),
                                        child: Image.asset(
                                          'assets/images/readDialog/starScoreSlot.png',
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      /////////////////////////// Star score Text
                                      Positioned.fill(
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Spacer(),
                                              ///////////////////////// text
                                              Container(
                                                height: deviceHeight > 500
                                                    ? deviceHeight *
                                                        (317 / 768) *
                                                        (41 / 317)
                                                    : deviceHeight *
                                                        (276 / 414) *
                                                        (32 / 276),
                                                child: FittedBox(
                                                  fit: BoxFit.fitHeight,
                                                  child: Text(
                                                    Provider.of<DataProvider>(
                                                            context,
                                                            listen: false)
                                                        .kidsStar[Provider.of<
                                                                    DataProvider>(
                                                                context,
                                                                listen: false)
                                                            .currentKids]
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'NunitoBold',
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                              /////////////////////////// star icon
                                              Container(
                                                margin: EdgeInsets.only(
                                                    left: deviceHeight > 500
                                                        ? 8
                                                        : 5),
                                                height: deviceHeight > 500
                                                    ? deviceHeight *
                                                        (317 / 768) *
                                                        (25 / 317)
                                                    : deviceHeight *
                                                        (276 / 414) *
                                                        (23 / 276),
                                                child: AspectRatio(
                                                  aspectRatio: 1,
                                                  child: SvgPicture.asset(
                                                      'assets/images/readDialog/starScore.svg'),
                                                ),
                                              ),
                                              Spacer()
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                          /////////////////////////////////////////////////////////////////////////////
                          ////////////////////////////////////////////////////// Play again Btn
                          /* Positioned.fill(
                            child: Align(
                                alignment: Alignment.center,
                                child:  */
                          Container(
                            width: deviceHeight > 500
                                ? deviceHeight * (317 / 768) * (1617 / 951)
                                : deviceHeight * (276 / 414) * (1617 / 951),
                            margin: EdgeInsets.only(
                              top: deviceHeight > 500
                                  ? deviceHeight * (317 / 768) * (330 / 317)
                                  : deviceHeight * (276 / 414) * (287 / 276),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                /////////////////// play Btn
                                GestureDetector(
                                  onTap: _perventMultipleTab
                                      ? () {
                                          setState(() {
                                            _perventMultipleTab = false;
                                          });

                                          Timer(
                                              Duration(seconds: 1),
                                              () => setState(() =>
                                                  _perventMultipleTab = true));

                                          Provider.of<AudioProvider>(context,
                                                  listen: false)
                                              .playSoundEffect("click3", 1.0);
                                          Provider.of<AudioProvider>(context,
                                                  listen: false)
                                              .stopPlayTheme();
                                          Provider.of<AudioProvider>(context,
                                                  listen: false)
                                              .playCandyMonsterTheme();

                                          Navigator.pop(context);
                                          Navigator.pop(context);

                                          /* Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Play(),
                                            ),
                                          ); */
                                        }
                                      : null,
                                  child: Container(
                                    height: deviceHeight > 500
                                        ? deviceHeight * (121 / 768)
                                        : deviceHeight * (170 / 768),
                                    child: AspectRatio(
                                      aspectRatio: 268 / 121,
                                      child: FlareActor(
                                          "assets/animation/btnAnimation.flr",
                                          artboard: 'PlayAgainBtn',
                                          animation: 'animation'),
                                    ),
                                  ),
                                  /* Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Stack(
                                                children: <Widget>[
                                                  /////////////////////// Btn BG
                                                  Container(
                                                    height: deviceHeight > 500
                                                        ? deviceHeight *
                                                            (317 / 768) *
                                                            (93 / 317)
                                                        : deviceHeight *
                                                            (276 / 414) *
                                                            (82 / 276),
                                                    child: SvgPicture.asset(
                                                      'assets/images/enterBook/playBtn.svg',
                                                    ),
                                                  ),
                                                  /////////////////////// Play Again Text
                                                  Positioned.fill(
                                                    child: Align(
                                                      alignment: Alignment.center,
                                                      child: Container(
                                                        height: deviceHeight > 500
                                                            ? deviceHeight *
                                                                (317 / 768) *
                                                                (41 / 317)
                                                            : deviceHeight *
                                                                (276 / 414) *
                                                                (32 / 276),
                                                        child: FittedBox(
                                                          fit: BoxFit.fitHeight,
                                                          child: Text(
                                                            'Play again',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'NunitoExtraBold',
                                                                color: Colors.white),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ), */
                                  /* ), */
                                  /* )), */
                                ),
                                /////////////////////////////// home Btn
                                GestureDetector(
                                  onTap: _perventMultipleTab
                                      ? () {
                                          setState(() {
                                            _perventMultipleTab = false;
                                          });

                                          Timer(
                                              Duration(seconds: 1),
                                              () => setState(() =>
                                                  _perventMultipleTab = true));

                                          Navigator.pop(context);
                                          Provider.of<AudioProvider>(context,
                                                  listen: false)
                                              .playSoundEffect("click3", 1.0);
                                          Provider.of<AudioProvider>(context,
                                                  listen: false)
                                              .stopPlayTheme();
                                          Provider.of<AudioProvider>(context,
                                                  listen: false)
                                              .resumeBgMusic();
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Home(),
                                            ),
                                          );
                                        }
                                      : null,
                                  child: Container(
                                    height: deviceHeight > 500
                                        ? deviceHeight * (121 / 768)
                                        : deviceHeight * (170 / 768),
                                    child: AspectRatio(
                                      aspectRatio: 1,
                                      child:
                                          /* Image.asset(
                                            'assets/images/enterBook/homeBtn.png')  */
                                          FlareActor(
                                              "assets/animation/Home_Btn.flr",
                                              artboard: 'HomeBtn',
                                              animation: 'animation'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ///////////////////////////////////////////////// Close Btn
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: GestureDetector(
                                onTap: _perventMultipleTab
                                    ? () {
                                        setState(() {
                                          _perventMultipleTab = false;
                                        });

                                        Timer(
                                            Duration(seconds: 1),
                                            () => setState(() =>
                                                _perventMultipleTab = true));

                                        Navigator.pop(context);
                                        Provider.of<AudioProvider>(context,
                                                listen: false)
                                            .playSoundEffect("click3", 1.0);
                                        Provider.of<AudioProvider>(context,
                                                listen: false)
                                            .stopPlayTheme();
                                        Provider.of<AudioProvider>(context,
                                                listen: false)
                                            .resumeBgMusic();
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Home(),
                                          ),
                                        );
                                      }
                                    : null,
                                child: Container(
                                  margin: EdgeInsets.only(
                                    top: deviceHeight > 500
                                        ? deviceHeight *
                                            (317 / 768) *
                                            (60 / 317)
                                        : deviceHeight *
                                            (276 / 414) *
                                            (55 / 276),
                                    left: deviceHeight > 500
                                        ? deviceHeight *
                                            (317 / 768) *
                                            (512 / 317) *
                                            (480 / 512)
                                        : deviceHeight *
                                            (276 / 414) *
                                            (446 / 276) *
                                            (418.4 / 446),
                                  ),
                                  child: Container(
                                    height: deviceHeight > 500
                                        ? deviceHeight *
                                            (317 / 768) *
                                            (60 / 317)
                                        : deviceHeight *
                                            (276 / 414) *
                                            (49 / 276),
                                    child: AspectRatio(
                                      aspectRatio: 1,
                                      child: SvgPicture.asset(
                                          'assets/images/readDialog/closeBtn.svg'),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
