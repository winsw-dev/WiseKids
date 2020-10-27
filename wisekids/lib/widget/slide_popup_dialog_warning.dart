import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flare_flutter/flare_actor.dart';

import '../provider/audioProvider.dart';
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
      /* return Transform(
        transform: Matrix4.translationValues(0.0, curvedValue * -300, 0.0),
        child: Opacity(
          opacity: animation1.value,
          child: SlideDialogWarning(
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
          child: SlideDialogWarning(
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

class SlideDialogWarning extends StatefulWidget {
  final Widget child;

  SlideDialogWarning({
    @required this.child,
  });

  @override
  _SlideDialogWarningState createState() => _SlideDialogWarningState();
}

class _SlideDialogWarningState extends State<SlideDialogWarning> {
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
        padding: /* MediaQuery.of(context).viewInsets + */ EdgeInsets.all(0),
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
                Center(
                  child: Container(
                    height: deviceHeight > 500
                        ? deviceHeight * (368 / 768)
                        : deviceHeight * (320 / 414),
                    child: AspectRatio(
                      aspectRatio: 526 / 368,
                      child: Stack(
                        children: <Widget>[
                          /////////////////////////////////////////////// dialog Bg
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                  margin: EdgeInsets.only(
                                    top: deviceHeight > 500
                                        ? deviceHeight *
                                            (317 / 768) *
                                            (16 / 317)
                                        : deviceHeight *
                                            (276 / 414) *
                                            (13 / 276),
                                  ),
                                  height: deviceHeight > 500
                                      ? deviceHeight * (368 / 768) * (309 / 368)
                                      : deviceHeight *
                                          (320 / 414) *
                                          (309 / 368),
                                  child: Image.asset(
                                    'assets/images/readDialog/dialogBgFix.png',
                                    fit: BoxFit.contain,
                                  )),
                            ),
                          ),

                          ///////////////////////////////////////////////// Close Btn
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.topRight,
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
                                        Provider.of<AudioProvider>(context,
                                                listen: false)
                                            .playSoundEffect("click3", 1.0);

                                        Navigator.pop(context);
                                      }
                                    : null,
                                child: Container(
                                  child: Container(
                                    height: deviceHeight > 500
                                        ? deviceHeight *
                                            (317 / 768) *
                                            (62 / 317)
                                        : deviceHeight *
                                            (276 / 414) *
                                            (55 / 276),
                                    child: AspectRatio(
                                      aspectRatio: 76 / 79,
                                      child: FlareActor(
                                          "assets/animation/btnAnimation.flr",
                                          artboard: 'CloseBtn',
                                          animation: 'animation'),
                                    ), /* AspectRatio(
                                      aspectRatio: 1,
                                      child: SvgPicture.asset(
                                          'assets/images/readDialog/closeBtn.svg'),
                                    ), */
                                  ),
                                ),
                              ),
                            ),
                          ),

                          ///////////////////////////////////////////////// You're really improving Text
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                height: deviceHeight > 500
                                    ? (deviceHeight *
                                            (368 / 768) *
                                            (309 / 368)) -
                                        ((deviceHeight *
                                                (317 / 768) *
                                                (93 / 317)) /
                                            2)
                                    : (deviceHeight *
                                            (320 / 414) *
                                            (309 / 368)) -
                                        ((deviceHeight *
                                                (276 / 414) *
                                                (82 / 276)) /
                                            2),
                                margin: EdgeInsets.only(
                                  top: deviceHeight > 500
                                      ? deviceHeight * (317 / 768) * (16 / 317)
                                      : deviceHeight * (276 / 414) * (13 / 276),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    ////////////////////////////////////////// headLine text
                                    Container(
                                        height: deviceHeight > 500
                                            ? deviceHeight *
                                                (368 / 768) *
                                                (309 / 368) *
                                                (77 / 317)
                                            : deviceHeight *
                                                (320 / 414) *
                                                (309 / 368) *
                                                (77 / 317),
                                        child: FittedBox(
                                          fit: BoxFit.fitHeight,
                                          child: Text(
                                            'Sorry',
                                            style: TextStyle(
                                                fontFamily: 'NunitoExtraBold',
                                                color: Colors.white),
                                          ),
                                        )),
                                    ////////////////////////////////////////// article text
                                    Container(
                                        margin: EdgeInsets.only(
                                            left: deviceHeight > 500
                                                ? deviceHeight *
                                                    (317 / 768) *
                                                    (16 / 317)
                                                : deviceHeight *
                                                    (276 / 414) *
                                                    (13 / 276),
                                            right: deviceHeight > 500
                                                ? deviceHeight *
                                                    (317 / 768) *
                                                    (16 / 317)
                                                : deviceHeight *
                                                    (276 / 414) *
                                                    (13 / 276)),
                                        height: deviceHeight > 500
                                            ? deviceHeight *
                                                (368 / 768) *
                                                (309 / 368) *
                                                (68 / 317)
                                            : deviceHeight *
                                                (320 / 414) *
                                                (309 / 368) *
                                                (68 / 317),
                                        child: AspectRatio(
                                          aspectRatio: 452 / 68,
                                          child: FittedBox(
                                            fit: BoxFit.contain,
                                            child: Provider.of<DataProvider>(
                                                            context,
                                                            listen: false)
                                                        .kidsStar[Provider.of<
                                                                DataProvider>(
                                                            context,
                                                            listen: false)
                                                        .currentKids] <
                                                    6
                                                ? Text(
                                                    'You don\'t have enough stars.\nCollect more stars from books you have.',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'NunitoSemiBold',
                                                        color: Colors.white),
                                                  )
                                                : Text(
                                                    'New content is coming soon!',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'NunitoSemiBold',
                                                        color: Colors.white),
                                                  ),
                                          ),
                                        )),
                                    ///////////////////////////////////////
                                  ],
                                ),
                              ),
                            ),
                          ),

                          /////////////////////////////////////////////////////////////////////////////
                          ////////////////////////////////////////////////////// okay btn
                          Positioned.fill(
                            child: Align(
                                alignment: Alignment.bottomCenter,
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
                                          Provider.of<AudioProvider>(context,
                                                  listen: false)
                                              .playSoundEffect("click2", 1.0);

                                          Navigator.pop(context);
                                        }
                                      : null,
                                  child: Container(
                                    height: deviceHeight > 500
                                        ? deviceHeight * (121 / 768)
                                        : deviceHeight * (170 / 768),
                                    child: FlareActor(
                                        "assets/animation/btnAnimation.flr",
                                        artboard: 'OkayBtn',
                                        animation: 'animation'),
                                  ),
                                  /* Container(
                                    child: Row(
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
                                                'assets/images/enterBook/readBtn.svg',
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
                                                      'Okay',
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
                                    ),
                                  ), */
                                )),
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
