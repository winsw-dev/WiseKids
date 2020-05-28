import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter/material.dart';

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
      return Transform(
        transform: Matrix4.translationValues(0.0, curvedValue * -300, 0.0),
        child: Opacity(
          opacity: animation1.value,
          child: SlideDialogVocab(
            child: child,
          ),
        ),
      );
    },
  );
}

//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////
class SlideDialogVocab extends StatefulWidget {
  final Widget child;

  SlideDialogVocab({
    @required this.child,
  });

  @override
  _SlideDialogVocabState createState() => _SlideDialogVocabState();
}

class _SlideDialogVocabState extends State<SlideDialogVocab> {
  //var _initialPosition = 0.0;
  //var _currentPosition = 0.0;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets + EdgeInsets.only(top: 0),
      duration: Duration(milliseconds: 100),
      curve: Curves.decelerate,
      child: MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: context,
        child: Center(
          child: Container(
            width: deviceHeight > 500
                ? deviceWidth * (987 / 1024)
                : deviceWidth * (987 / 1024),
            height:
                deviceHeight > 500 ? deviceHeight * (692 / 768) : deviceHeight,
            child: Stack(
              children: <Widget>[
                //////////////////////////// Vocab Book bg
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: EdgeInsets.only(
                          top: deviceHeight > 500
                              ? deviceHeight * (692 / 768) * (25 / 692)
                              : deviceHeight * (25 / 692),
                          bottom: deviceHeight > 500
                              ? deviceHeight * (692 / 768) * (25 / 692)
                              : deviceHeight * (25 / 692)),
                      //height: MediaQuery.of(context).size.height,
                      child: Image.asset(
                        'assets/images/vocabulary/bookBg.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),

                //////////////////////////// close Btn
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: EdgeInsets.only(
                        left: deviceHeight > 500
                            ? deviceHeight *
                                (692 / 768) *
                                (3014 / 1929) *
                                (82 / 100)
                            : deviceHeight * (3014 / 1929) * (83 / 100),
                      ),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: deviceHeight > 500
                                ? deviceHeight * (692 / 768) * (80 / 692)
                                : deviceHeight * (692 / 768) * (100 / 692),
                            child: Image.asset(
                              'assets/images/vocabulary/closeBtn.png',
                              fit: BoxFit.contain,
                            ),
                          )),
                    ),
                  ),
                ),
                //////////////////////////////////////// Next & Back Navigate Btn
                Positioned.fill(
                  child: Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            ////////////////////// Back Btn
                            
                            Container(
                              height: deviceHeight > 500
                                  ? deviceHeight * (692 / 768) * (80 / 692)
                                  : deviceHeight * (692 / 768) * (100 / 692),
                              child: Image.asset(
                                'assets/images/vocabulary/back.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                            SizedBox(width:deviceHeight > 500
                            ? deviceHeight/*  *
                                (692 / 768)  */*
                                (3014 / 1929) *
                                (67 / 100)
                            : deviceHeight * (3014 / 1929) * (76 / 100),),
                            //////////////////////// Next Btn
                            Container(
                             
                              height: deviceHeight > 500
                                  ? deviceHeight * (692 / 768) * (80 / 692)
                                  : deviceHeight * (692 / 768) * (100 / 692),
                              child: Image.asset(
                                'assets/images/vocabulary/next.png',
                                fit: BoxFit.contain,
                              ),
                            )
                          ],
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
