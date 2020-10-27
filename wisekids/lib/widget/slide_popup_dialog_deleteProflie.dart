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
import '../screen/parentalKidsCenter.dart';
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
  @required int deleteWhichKid,
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
          child: SlideDialogDeleteKidsProfile(
            deleteWhichKid: deleteWhichKid,
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
          child: SlideDialogDeleteKidsProfile(
            deleteWhichKid: deleteWhichKid,
            child: child,
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

class SlideDialogDeleteKidsProfile extends StatefulWidget {
  final Widget child;
  final int deleteWhichKid;

  SlideDialogDeleteKidsProfile(
      {@required this.child, @required this.deleteWhichKid});

  @override
  _SlideDialogDeleteKidsProfileState createState() =>
      _SlideDialogDeleteKidsProfileState();
}

class _SlideDialogDeleteKidsProfileState
    extends State<SlideDialogDeleteKidsProfile> {
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
        padding: EdgeInsets.all(0),
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
                        ? deviceHeight * (253 / 768)
                        : deviceHeight * (253 / 414),
                    child: AspectRatio(
                      aspectRatio: 501 / 253,
                      child: Stack(
                        children: <Widget>[
                          ///////////////////////////// white BG
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                          ),
                          ////////////////////////////// close Btn
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
                                  margin: EdgeInsets.only(
                                    top: deviceHeight > 500
                                        ? deviceHeight *
                                            (253 / 768) *
                                            (20 / 253)
                                        : deviceHeight *
                                            (253 / 414) *
                                            (20 / 253),
                                    right: deviceHeight > 500
                                        ? deviceHeight *
                                            (253 / 768) *
                                            (20 / 253)
                                        : deviceHeight *
                                            (253 / 414) *
                                            (20 / 253),
                                  ),
                                  width: deviceHeight > 500
                                      ? deviceHeight * (253 / 768) * (25 / 253)
                                      : deviceHeight * (253 / 414) * (25 / 253),
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: SvgPicture.asset(
                                        'assets/images/parentalConsent/close.svg',
                                        color:
                                            Color.fromRGBO(219, 222, 227, 1.0)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          ///////////////////////////////////////////////////////////// Do you want to delete profile Text
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                height: deviceHeight > 500
                                    ? deviceHeight * (253 / 768)
                                    : deviceHeight * (253 / 414),
                                child: AspectRatio(
                                  aspectRatio: 346 / 253,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Spacer(),
                                      Spacer(),
                                      Spacer(),
                                      //////////////////////////////////////////////
                                      Container(
                                        height: deviceHeight > 500
                                            ? deviceHeight *
                                                (253 / 768) *
                                                (34 / 253)
                                            : deviceHeight *
                                                (253 / 414) *
                                                (34 / 253),
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Provider.of<DataProvider>(
                                                          context,
                                                          listen: false)
                                                      .parentAreaLanguage ==
                                                  "TH"
                                              ? Text(
                                                  'คุณต้องการลบโปรไฟล์นี้หรือไม่ ?',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'PromptMedium',
                                                      color: Color.fromRGBO(
                                                          80, 85, 89, 1.0)),
                                                )
                                              : Text(
                                                  'Do you want to delete profile ?',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'NunitoSemiBold',
                                                      color: Color.fromRGBO(
                                                          80, 85, 89, 1.0)),
                                                ),
                                        ),
                                      ),
                                      //////////////////////////////////////////////
                                      Container(
                                        margin: EdgeInsets.only(
                                          top: deviceHeight > 500
                                              ? (deviceHeight * 0.5) * (6 / 381)
                                              : (deviceHeight * 0.85) *
                                                  (6 / 381),
                                        ),
                                        height: deviceHeight > 500
                                            ? deviceHeight *
                                                (253 / 768) *
                                                (24 / 253)
                                            : deviceHeight *
                                                (253 / 414) *
                                                (24 / 253),
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Provider.of<DataProvider>(
                                                          context,
                                                          listen: false)
                                                      .parentAreaLanguage ==
                                                  "TH"
                                              ? Text(
                                                  'ข้อมูลทั้งหมดจะถูกลบถาวร',
                                                  style: TextStyle(
                                                      fontFamily: 'PromptLight',
                                                      color: Color.fromRGBO(
                                                          80, 85, 89, 1.0)),
                                                )
                                              : Text(
                                                  'All information will be deleted.',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'NunitoRegular',
                                                      color: Color.fromRGBO(
                                                          80, 85, 89, 1.0)),
                                                ),
                                        ),
                                      ),
                                      //////////////////////////////////////////////
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: deviceHeight > 500
                                              ? (deviceHeight * 0.5) *
                                                  (30 / 381)
                                              : (deviceHeight * 0.85) *
                                                  (30 / 381),
                                        ),
                                        child: Row(
                                          children: <Widget>[
                                            /////////////////////////////////// No Btn
                                            GestureDetector(
                                              onTap: _perventMultipleTab
                                                  ? () {
                                                      setState(() {
                                                        _perventMultipleTab =
                                                            false;
                                                      });

                                                      Timer(
                                                          Duration(seconds: 1),
                                                          () => setState(() =>
                                                              _perventMultipleTab =
                                                                  true));
                                                      Provider.of<AudioProvider>(
                                                              context,
                                                              listen: false)
                                                          .playSoundEffect(
                                                              "select", 1.0);
                                                      Navigator.pop(context);
                                                    }
                                                  : null,
                                              child: Stack(
                                                children: <Widget>[
                                                  /////////////////////// no bg btn
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      color: Color.fromRGBO(
                                                          248, 226, 55, 1.0)
                                                      /* Color.fromRGBO(69, 223, 224, 1.0) */,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Color.fromRGBO(
                                                              160,
                                                              163,
                                                              168,
                                                              0.16),
                                                          blurRadius:
                                                              6.0, // has the effect of softening the shadow
                                                          spreadRadius:
                                                              0, // has the effect of extending the shadow
                                                          offset: Offset(
                                                            0.0, // horizontal, move right 10
                                                            3.0, // vertical, move down 10
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    height: deviceHeight > 500
                                                        ? (deviceHeight * 0.5) *
                                                            (54 / 381)
                                                        : (deviceHeight *
                                                                0.85) *
                                                            (60 / 381),
                                                    child: AspectRatio(
                                                      aspectRatio: 153 / 54,
                                                    ),
                                                  ),
                                                  //////////////////// no text
                                                  Positioned.fill(
                                                    child: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Container(
                                                        height: Provider.of<DataProvider>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .parentAreaLanguage ==
                                                                "TH"
                                                            ? deviceHeight > 500
                                                                ? (deviceHeight *
                                                                        0.5) *
                                                                    (30 / 381)
                                                                : (deviceHeight *
                                                                        0.85) *
                                                                    (32 / 381)
                                                            : deviceHeight > 500
                                                                ? (deviceHeight *
                                                                        0.5) *
                                                                    (26 / 381)
                                                                : (deviceHeight *
                                                                        0.85) *
                                                                    (30 / 381),
                                                        child: FittedBox(
                                                          fit: BoxFit.contain,
                                                          child: Provider.of<DataProvider>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .parentAreaLanguage ==
                                                                  "TH"
                                                              ? Text(
                                                                  'ยกเลิก',
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'PromptMedium',
                                                                      color: Colors
                                                                          .white),
                                                                )
                                                              : Text(
                                                                  'No',
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'NunitoBold',
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            ///////////////////////////////////// Yes Btn
                                            Spacer(),
                                            GestureDetector(
                                              onTap: _perventMultipleTab
                                                  ? () async {
                                                      setState(() {
                                                        _perventMultipleTab =
                                                            false;
                                                      });

                                                      Timer(
                                                          Duration(seconds: 1),
                                                          () => setState(() =>
                                                              _perventMultipleTab =
                                                                  true));
                                                      Provider.of<AudioProvider>(
                                                              context,
                                                              listen: false)
                                                          .playSoundEffect(
                                                              "click2", 1.0);

                                                      Navigator.pop(context);
                                                      Navigator.pop(context);
                                                      /* Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              ParentalKidsCenter(),
                                                        ),
                                                      ); */
                                                      Provider.of<DataProvider>(
                                                              context,
                                                              listen: false)
                                                          .deleteKidsProfile(widget
                                                              .deleteWhichKid);
                                                    }
                                                  : null,
                                              child: Stack(
                                                children: <Widget>[
                                                  ////////////////////// yes tn bg
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      color: Color.fromRGBO(
                                                          255, 95, 74, 1.0)
                                                      /* Color.fromRGBO(69, 223, 224, 1.0) */,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Color.fromRGBO(
                                                              160,
                                                              163,
                                                              168,
                                                              0.16),
                                                          blurRadius:
                                                              6.0, // has the effect of softening the shadow
                                                          spreadRadius:
                                                              0, // has the effect of extending the shadow
                                                          offset: Offset(
                                                            0.0, // horizontal, move right 10
                                                            3.0, // vertical, move down 10
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    height: deviceHeight > 500
                                                        ? (deviceHeight * 0.5) *
                                                            (54 / 381)
                                                        : (deviceHeight *
                                                                0.85) *
                                                            (60 / 381),
                                                    child: AspectRatio(
                                                      aspectRatio: 153 / 54,
                                                    ),
                                                  ),
                                                  ////////////////////////////// yes text
                                                  //////////////////// no text
                                                  Positioned.fill(
                                                    child: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Container(
                                                        height: Provider.of<DataProvider>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .parentAreaLanguage ==
                                                                "TH"
                                                            ? deviceHeight > 500
                                                                ? (deviceHeight *
                                                                        0.5) *
                                                                    (30 / 381)
                                                                : (deviceHeight *
                                                                        0.85) *
                                                                    (32 / 381)
                                                            : deviceHeight > 500
                                                                ? (deviceHeight *
                                                                        0.5) *
                                                                    (26 / 381)
                                                                : (deviceHeight *
                                                                        0.85) *
                                                                    (30 / 381),
                                                        child: FittedBox(
                                                          fit: BoxFit.contain,
                                                          child: Provider.of<DataProvider>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .parentAreaLanguage ==
                                                                  "TH"
                                                              ? Text(
                                                                  'ลบบัญชี',
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'PromptMedium',
                                                                      color: Colors
                                                                          .white),
                                                                )
                                                              : Text(
                                                                  'Yes',
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'NunitoBold',
                                                                      color: Colors
                                                                          .white),
                                                                ),
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
                                      Spacer(),
                                      Spacer(),
                                    ],
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
