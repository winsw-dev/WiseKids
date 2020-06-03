import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'dart:async';

import '../screen/home.dart';

import 'package:provider/provider.dart';
import '../screen/play.dart';
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
      return Transform(
        transform: Matrix4.translationValues(0.0, curvedValue * -300, 0.0),
        child: Opacity(
          opacity: animation1.value,
          child: SlideDialogRead(
            child: child,
          ),
        ),
      );
    },
  );
}

////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////
class SlideDialogRead extends StatefulWidget {
  final Widget child;

  SlideDialogRead({
    @required this.child,
  });

  @override
  _SlideDialogReadState createState() => _SlideDialogReadState();
}

class _SlideDialogReadState extends State<SlideDialogRead> {
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
        padding: MediaQuery.of(context).viewInsets + EdgeInsets.all(0),
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
                                      ? deviceHeight * (317 / 768) * (127 / 317)
                                      : deviceHeight *
                                          (276 / 414) *
                                          (117 / 276),
                                  child: Image.asset(
                                    'assets/images/readDialog/3star.png',
                                    fit: BoxFit.contain,
                                  )),
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
                          //////////////////////////////////////////////// 3 Star Icon
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                margin: EdgeInsets.only(
                                  top: deviceHeight > 500
                                      ? deviceHeight * (317 / 768) * (142 / 317)
                                      : deviceHeight *
                                          (276 / 414) *
                                          (131 / 276),
                                ),
                                height: deviceHeight > 500
                                    ? deviceHeight * (317 / 768) * (77 / 317)
                                    : deviceHeight * (276 / 414) * (70 / 276),
                                child: FittedBox(
                                  fit: BoxFit.fitHeight,
                                  child: Text(
                                    'What\'s Next',
                                    style: TextStyle(
                                        fontFamily: 'NunitoExtraBold',
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          ///////////////////////////////////////////////// Keep working on it, You are improving. Text
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                  margin: EdgeInsets.only(
                                    top: deviceHeight > 500
                                        ? deviceHeight *
                                            (317 / 768) *
                                            (216 / 317)
                                        : deviceHeight *
                                            (276 / 414) *
                                            (199 / 276),
                                  ),
                                  height: deviceHeight > 500
                                      ? deviceHeight * (317 / 768) * (34 / 317)
                                      : deviceHeight * (276 / 414) * (31 / 276),
                                  child: FittedBox(
                                    fit: BoxFit.fitHeight,
                                    child: Text(
                                      'Keep working on it, You are improving.',
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
                                            (240 / 276),
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
                          //////////////////////////////////////////////////////  Btn
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                margin: EdgeInsets.only(
                                  top: deviceHeight > 500
                                      ? deviceHeight * (317 / 768) * (342 / 317)
                                      : deviceHeight *
                                          (276 / 414) *
                                          (297 / 276),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[Spacer(),
                                    ////////////////////////////////////////////////////// Play Btn
                                    GestureDetector(
                                      onTap: _perventMultipleTab
                                          ? () {
                                              setState(() {
                                                _perventMultipleTab = false;
                                              });

                                              Timer(
                                                  Duration(seconds: 1),
                                                  () => setState(() =>
                                                      _perventMultipleTab =
                                                          true));

                                              Navigator.pop(context);
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => Play(),
                                                ),
                                              );
                                            }
                                          : null,
                                      child: Stack(
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
                                            child: AspectRatio(aspectRatio: 216/93,
                                                                                          child: SvgPicture.asset(
                                                'assets/images/enterBook/playBtn.svg',
                                              ),
                                            ),
                                          ),
                                          /////////////////////// Play Text
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
                                                        (37 / 276),
                                                child: FittedBox(
                                                  fit: BoxFit.fitHeight,
                                                  child: Text(
                                                    'Play',
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
                                    ),Spacer(),
                                    ////////////////////////////////////////////////////// Read again
                                    GestureDetector(
                                      onTap: _perventMultipleTab
                                          ? () {
                                              setState(() {
                                                _perventMultipleTab = false;
                                              });

                                              Timer(
                                                  Duration(seconds: 1),
                                                  () => setState(() =>
                                                      _perventMultipleTab =
                                                          true));

                                              Navigator.pop(context);
                                              /* Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => Play(),
                                                ),
                                              ); */
                                            }
                                          : null,
                                      child: Stack(
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
                                            child: AspectRatio(aspectRatio: 216/93,
                                                                                          child: SvgPicture.asset(
                                                'assets/images/enterBook/readBtn.svg',
                                              ),
                                            ),
                                          ),
                                          /////////////////////// Read Again Text
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
                                                        (37 / 276),
                                                child: FittedBox(
                                                  fit: BoxFit.fitHeight,
                                                  child: Text(
                                                    'Read Again',
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
                                    ),Spacer(),
                                    /////////////////////////////////////////////////////////////
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
              ],
            ),
          ),
        ),
      ),
    );

    /* return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets + EdgeInsets.all(0),
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
          backgroundColor: Colors.transparent,
          body: Stack(
            children: <Widget>[
              Container(
                  width: deviceWidth,
                  height: deviceHeight,
                  child: FlareActor("assets/animation/balloon.flr",
                      animation: 'balloon')),
              Center(
                child: Stack(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        /////////////////////////////////////////////// dialog Bg
                        Container(
                            margin: EdgeInsets.only(
                                top: deviceHeight > 500
                                    ? deviceHeight * 0.07
                                    : deviceHeight * 0.094),
                            width: deviceHeight > 500
                                ? deviceWidth * 0.52
                                : deviceWidth * 0.5,
                            height: deviceHeight > 500
                                ? deviceHeight * 0.502
                                : deviceHeight * 0.402,
                            child: Image.asset(
                                'assets/images/readDialog/dialogBgFix.png')),

                        //////////////////////////////////////// Row of text and star score
                        Container(
                          width: deviceHeight > 500
                              ? deviceWidth * 0.52
                              : deviceWidth * 0.5,
                          height: deviceHeight > 500
                              ? deviceHeight * 0.496
                              : deviceHeight * 0.496,
                          child: Column(
                            //mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              //////////////////// What's next
                              Container(
                                margin: EdgeInsets.only(
                                    top: deviceHeight > 500
                                        ? deviceHeight * 0.185
                                        : deviceHeight * 0.203),
                                child: Text(
                                  'What\'s Next',
                                  style: TextStyle(
                                      fontFamily: 'NunitoExtraBold',
                                      fontSize: deviceHeight > 500 ? 56 : 56,
                                      color: Colors.white),
                                ),
                              ),
                              ///////////////////// Keep working on it, You are improving.
                              Container(
                                /* margin: EdgeInsets.only(
                                top: deviceHeight > 500
                                    ? deviceHeight * 0.000
                                    : deviceHeight * 0.013), */
                                child: Text(
                                  'Keep working on it, You are improving.',
                                  style: TextStyle(
                                      fontFamily: 'NunitoRegular',
                                      fontSize: deviceHeight > 500 ? 25 : 25,
                                      color: Colors.white),
                                ),
                              ),
                              ////////////////////// Star Score Slot
                              Container(
                                margin: EdgeInsets.only(
                                    top: deviceHeight > 500
                                        ? deviceHeight * 0.033
                                        : deviceHeight * 0.033),
                                child: Stack(
                                  children: <Widget>[
                                    Container(
                                      width: deviceHeight > 500
                                          ? deviceWidth * 0.14
                                          : deviceWidth * 0.14,
                                      height: deviceHeight > 500
                                          ? deviceHeight * 0.08
                                          : deviceHeight * 0.06,
                                      child: Image.asset(
                                        'assets/images/readDialog/starScoreSlot.png',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Positioned.fill(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              /////////////////////////// star score text
                                              Container(
                                                child: Text(
                                                  '3',
                                                  style: TextStyle(
                                                      fontFamily: 'NunitoBold',
                                                      fontSize:
                                                          deviceHeight > 500
                                                              ? 30
                                                              : 25,
                                                      color: Colors.white),
                                                ),
                                              ),
                                              /////////////////////////// spacer
                                              SizedBox(
                                                width: deviceHeight > 500
                                                    ? deviceWidth * 0.013
                                                    : deviceWidth * 0.011,
                                              ),
                                              /////////////////////////// star score icon
                                              Container(
                                                height: deviceHeight > 500
                                                    ? deviceHeight * 0.044
                                                    : deviceHeight * 0.044,
                                                child: SvgPicture.asset(
                                                    'assets/images/readDialog/starScore.svg'),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    //////////////////////////////// //////// 3 Star
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          margin: EdgeInsets.only(top: 10),
                          height: deviceHeight > 500
                              ? deviceHeight * 0.17
                              : deviceHeight * 0.17,
                          child:
                              Image.asset('assets/images/readDialog/3star.png'),
                        ),
                      ),
                    ),

                    ////////////////////////////////////////// Btn
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          margin: EdgeInsets.only(
                              top: deviceHeight > 500
                                  ? deviceHeight * 0.443
                                  : deviceHeight * 0.443),
                          child: Wrap(
                            children: <Widget>[
                              ///////////////////////  Read
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                  return;
                                },
                                child: Container(
                                  child: Stack(
                                    children: <Widget>[
                                      Container(
                                        height: deviceHeight > 500
                                            ? deviceHeight * 0.12
                                            : deviceHeight * 0.12,
                                        child: SvgPicture.asset(
                                            'assets/images/enterBook/readBtn.svg'),
                                      ),
                                      /////////////// text
                                      Positioned.fill(
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Container(
                                            child: Text(
                                              'Read again',
                                              style: TextStyle(
                                                  fontFamily: 'NunitoExtraBold',
                                                  fontSize: deviceHeight > 500
                                                      ? 30
                                                      : 25,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              /////////////////////// Spacer
                              SizedBox(
                                width: deviceHeight > 500
                                    ? deviceWidth * 0.03
                                    : deviceWidth * 0.03,
                              ),
                              ///////////////////////  Play
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Play(),
                                    ),
                                  );
                                },
                                child: Container(
                                  child: Stack(
                                    children: <Widget>[
                                      Container(
                                        height: deviceHeight > 500
                                            ? deviceHeight * 0.12
                                            : deviceHeight * 0.12,
                                        child: SvgPicture.asset(
                                            'assets/images/enterBook/playBtn.svg'),
                                      ),
                                      /////////////// text
                                      Positioned.fill(
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Container(
                                            child: Text(
                                              'Play',
                                              style: TextStyle(
                                                  fontFamily: 'NunitoExtraBold',
                                                  fontSize: deviceHeight > 500
                                                      ? 30
                                                      : 25,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    //////////////////////////////////////////// Close Btn
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Home(),
                              ),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 75),
                            child: SvgPicture.asset(
                                'assets/images/readDialog/closeBtn.svg'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ); */
  }
}
