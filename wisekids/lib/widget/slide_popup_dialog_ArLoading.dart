import 'dart:async';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/dataProvider.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import '../provider/audioProvider.dart';
import '../provider/ttsProvider.dart';

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
    barrierDismissible: barrierDismissible,
    barrierLabel: "Dismiss",
    transitionDuration: transitionDuration,
    transitionBuilder: (context, animation1, animation2, widget) {
      final curvedValue = Curves.easeInOut.transform(animation1.value) - 1.0;
      /* return Transform(
        transform: Matrix4.translationValues(0.0, curvedValue * -300, 0.0),
        child: Opacity(
          opacity: animation1.value,
          child: SlideDialogVocab(
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
          child: SlideDialogArLoading(
            child: child,
          ),
        ),
      );
    },
  );
}

////////////////////////////////////////////////////////////////
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

//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////
class SlideDialogArLoading extends StatefulWidget {
  final Widget child;

  SlideDialogArLoading({
    @required this.child,
  });

  @override
  _SlideDialogArLoadingState createState() => _SlideDialogArLoadingState();
}

class _SlideDialogArLoadingState extends State<SlideDialogArLoading> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 3000), () {
      Navigator.pop(context);
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: AnimatedPadding(
        padding: /* MediaQuery.of(context).viewInsets + */ EdgeInsets
            .only(top: 0),
        duration: Duration(milliseconds: 100),
        curve: Curves.decelerate,
        child: MediaQuery.removeViewInsets(
          removeLeft: true,
          removeTop: true,
          removeRight: true,
          removeBottom: true,
          context: context,
          child: Material(
            color: Colors.transparent,
            child: Center(
                child: Stack(
              children: [
                Container(
                  color: Colors.white,
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            height: deviceHeight > 500
                                ? deviceHeight * 0.30
                                : deviceHeight * 0.5,
                            child: FlareActor(
                              "assets/animation/loadingAR.flr",
                              animation: 'loading',
                              fit: BoxFit.contain,
                            )),
                        Container(
                          height: deviceHeight > 500
                              ? deviceHeight * 0.05
                              : deviceHeight * 0.08,
                          child: FittedBox(
                            fit: BoxFit.fitHeight,
                            child: Text('Now Loading...',
                                style: TextStyle(
                                    fontFamily: 'NunitoBold',
                                    color: Color.fromRGBO(80, 85, 89, 1.0))),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
