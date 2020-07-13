library slide_popup_dialog;

import 'dart:math';

import 'package:flutter/material.dart';

import './slide_dialog.dart';
import 'package:provider/provider.dart';
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
  final deviceWidth = MediaQuery.of(context).size.width;
  final deviceHeight = MediaQuery.of(context).size.height;
  return showGeneralDialog(
    context: context,
    pageBuilder: (context, animation1, animation2) {
      return;
    },
    barrierColor: barrierColor ?? Colors.black.withOpacity(0.7),
    barrierDismissible: true,
    barrierLabel: "Dismiss",
    transitionDuration: transitionDuration,
    transitionBuilder: deviceHeight < 500
        //////////////////////////////////////////////// phone version bounce animation
        ? (context, animation1, animation2, widget) {
            final curvedValue =
                Curves.easeInOut.transform(animation1.value) - 1.0;
            //final curvedValue = SpringCurve().transform(animation1.value) - 1;

            return Transform(
              transform:
                  Matrix4.translationValues(0.0, curvedValue * -300, 0.0),
              child: Opacity(
                opacity: animation1.value,
                child: SlideDialog(
                  child: child,
                  backgroundColor:
                      backgroundColor ?? Theme.of(context).canvasColor,
                ),
              ),
            );
          }
        : //////////////////////////////////////////////// tablet version bounce animation
        (context, animation1, animation2, widget) {
            return ScaleTransition(
              alignment: Alignment.center,
              scale: CurvedAnimation(
                parent: animation1,
                curve: SpringCurve(),
                reverseCurve: SpringCurve(),
              ),
              child: Opacity(
                opacity: animation1.value,
                child: SlideDialog(
                  child: child,
                  backgroundColor:
                      backgroundColor ?? Theme.of(context).canvasColor,
                ),
              ),
            );
          },
  );
}

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
