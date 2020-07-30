import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flare_loading/flare_loading.dart';

import '../screen/parentalConsent.dart';

import '../provider/audioProvider.dart';
import 'package:provider/provider.dart';
import '../provider/dataProvider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../screen/parentalKidsCenter.dart';

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
    pageBuilder: (context, animation1, animation2) {},
    barrierColor: barrierColor ?? Colors.black.withOpacity(0.7),
    barrierDismissible: false,
    barrierLabel: "Dismiss",
    transitionDuration: transitionDuration,
    transitionBuilder: (context, animation1, animation2, widget) {
      final curvedValue = Curves.easeInOut.transform(animation1.value) - 1.0;
      return Transform(
        transform: Matrix4.translationValues(0.0, curvedValue * -300, 0.0),
        child: Opacity(
          opacity: animation1.value,
          child: SlideDialogLogin(
            child: child,
            backgroundColor: backgroundColor ?? Theme.of(context).canvasColor,
          ),
        ),
      );
    },
  );
}

////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////

class SlideDialogLogin extends StatefulWidget {
  final Widget child;
  final Color backgroundColor;

  SlideDialogLogin({
    @required this.child,
    @required this.backgroundColor,
  });

  @override
  _SlideDialogLoginState createState() => _SlideDialogLoginState();
}

class _SlideDialogLoginState extends State<SlideDialogLogin> {
  var _initialPosition = 0.0;
  var _currentPosition = 0.0;

  bool _isLoading = true;
  bool _loadingVisible = false;
  String _consent = '';
  String _loadingStatusAnimation = 'success';
  var avatarSwipeController = new SwiperController();

  bool _perventMultipleTab = true;

  List<String> themePopupBg = [
    'assets/images/themePopup/theme1Bg.png',
    'assets/images/themePopup/theme2Bg.png',
    'assets/images/themePopup/theme3Bg.png',
    'assets/images/themePopup/theme4Bg.png',
    'assets/images/themePopup/theme5Bg.png',
  ];

  List<String> avatar = [
    "assets/images/avatar_boy.png",
    "assets/images/avatar_girl.png",
    "assets/images/avatar_cat.png"
  ];

  List<Color> shadowColor = [
    Color.fromRGBO(255, 96, 82, 0.36),
    Color.fromRGBO(255, 96, 82, 0.36),
    Color.fromRGBO(34, 55, 153, 0.5),
    Color.fromRGBO(1, 180, 215, 0.5),
    Color.fromRGBO(136, 205, 140, 0.5),
  ];

  List<String> selectYourThemeSvg = [
    'assets/images/themePopup/selectSpacerTheme1.svg',
    'assets/images/themePopup/selectSpacerTheme1.svg',
    'assets/images/themePopup/selectSpacerTheme3.svg',
    'assets/images/themePopup/selectSpacerTheme4.svg',
    'assets/images/themePopup/selectSpacerTheme5.svg',
  ];

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return AnimatedPadding(
      padding: /* MediaQuery.of(context).viewInsets +  */ EdgeInsets.all(0),
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
        child: Center(
          child: Stack(
            children: <Widget>[
              ///////////////////// Card & Bg
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [
                        0.1,
                        1.0
                      ],
                      colors: [
                        Color.fromRGBO(71, 220, 214, 1.0),
                        Color.fromRGBO(132, 207, 78, 1.0),
                      ]),
                  borderRadius: BorderRadius.only(
                    ///////////////////////////// round corner bottom left,right
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                margin: EdgeInsets.only(
                    top: deviceHeight > 500
                        ? deviceHeight * 0.25
                        : deviceHeight * 0.2),
                width: deviceHeight > 500
                    ? deviceWidth * 0.55
                    : deviceWidth * 0.47,
                height: deviceHeight > 500 ? double.infinity : double.infinity,
                ////////////////////////////
                child: Column(
                  children: <Widget>[
                    ///////////////////// Welcome to wisekids Logo
                    Container(
                      margin: EdgeInsets.only(
                          top: deviceHeight > 500
                              ? (deviceHeight - (deviceHeight * 0.25)) * 0.09
                              : (deviceHeight - (deviceHeight * 0.2)) * 0.09),
                      width: deviceHeight > 500
                          ? (deviceWidth * 0.55) * 0.6
                          : (deviceWidth * 0.47) * 0.6,
                      child: Image.asset(
                          'assets/images/loginDialog/welcomeToWisekids.png'),
                    ),
                    ///////////////////// Facebook Btn
                    IgnorePointer(
                      ignoring: _loadingVisible,
                      child: GestureDetector(
                        onTap: () async {
                          Provider.of<AudioProvider>(context, listen: false)
                              .playSoundEffect("click2", 1.0);
                          setState(() {
                            _loadingVisible = true;

                            _consent = 'Facebook';
                          });
                          await Provider.of<DataProvider>(context,
                                  listen: false)
                              .signInWithFacebook();

                          print(
                              Provider.of<DataProvider>(context, listen: false)
                                  .status
                                  .toString());

                          if (Provider.of<DataProvider>(context, listen: false)
                                  .status ==
                              Status.Authenticated) {
                            setState(() {
                              _isLoading = false;
                            });

                            /* if (Provider.of<DataProvider>(context,
                                          listen: false)
                                      .status ==
                                  Status.Unauthenticated) {
                                setState(() {
                                  _loadingStatusAnimation = 'failure';

                                  _isLoading = false;
                                });
                              } */
                            /* Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return ParentalConsent(consentDetail: 'Facebook',);
                                  },
                                ),
                              ); */
                          }
                          /* signInWithFacebook().whenComplete(() {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return ParentalConsent();
                                  },
                                ),
                              );
                            }); */
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              top: deviceHeight > 500
                                  ? (deviceHeight - (deviceHeight * 0.25)) *
                                      0.09
                                  : (deviceHeight - (deviceHeight * 0.2)) *
                                      0.07),
                          width: deviceHeight > 500
                              ? (deviceWidth * 0.55) * 0.75
                              : (deviceWidth * 0.47) * 0.75,
                          child: AspectRatio(
                            aspectRatio: 442 / 65,
                            child: Container(
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromRGBO(0, 0, 0, 0.20),
                                      blurRadius:
                                          15.0, // has the effect of softening the shadow
                                      spreadRadius:
                                          -5, // has the effect of extending the shadow
                                      offset: Offset(
                                        0.0, // horizontal, move right 10
                                        5.0, // vertical, move down 10
                                      ),
                                    ),
                                  ],
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(500))),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    height: deviceHeight > 500
                                        ? (((deviceWidth * 0.55) * 0.75) *
                                                (65 / 442)) *
                                            0.6
                                        : (((deviceWidth * 0.47) * 0.75) *
                                                (65 / 442)) *
                                            0.6,
                                    margin: EdgeInsets.only(
                                      left: deviceHeight > 500
                                          ? ((deviceWidth * 0.55) * 0.75) * 0.07
                                          : ((deviceWidth * 0.47) * 0.75) *
                                              0.07,
                                    ),
                                    child: SvgPicture.asset(
                                        'assets/images/loginDialog/facebookIcon.svg'),
                                  ),
                                  Spacer(),
                                  Container(
                                    height: deviceHeight > 500
                                        ? (((deviceWidth * 0.55) * 0.75) *
                                                (65 / 442)) *
                                            0.4
                                        : (((deviceWidth * 0.47) * 0.75) *
                                                (65 / 442)) *
                                            0.45,
                                    child: Material(
                                      color: Colors.transparent,
                                      child: FittedBox(
                                        fit: BoxFit.fitHeight,
                                        child: Text(
                                          'Facebook',
                                          style: TextStyle(
                                            fontFamily: 'NunitoRegular',
                                            color: Color.fromRGBO(
                                                80, 85, 89, 1.00),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    margin: EdgeInsets.only(
                                      right: deviceHeight > 500
                                          ? ((deviceWidth * 0.55) * 0.75) * 0.07
                                          : ((deviceWidth * 0.47) * 0.75) *
                                              0.07,
                                    ),
                                    child: SvgPicture.asset(
                                      'assets/images/loginDialog/facebookIcon.svg',
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    ///////////////////// Google Btn
                    IgnorePointer(
                      ignoring: _loadingVisible,
                      child: GestureDetector(
                        onTap: () async {
                          Provider.of<AudioProvider>(context, listen: false)
                              .playSoundEffect("click2", 1.0);
                          setState(() {
                            _loadingVisible = true;

                            _consent = 'Google';
                          });
                          await Provider.of<DataProvider>(context,
                                  listen: false)
                              .signInWithGoogle();

                          print(
                              Provider.of<DataProvider>(context, listen: false)
                                  .status
                                  .toString());

                          if (Provider.of<DataProvider>(context, listen: false)
                                  .status ==
                              Status.Authenticated) {
                            setState(() {
                              _isLoading = false;
                            });

                            /* if (Provider.of<DataProvider>(context,
                                          listen: false)
                                      .status ==
                                  Status.Unauthenticated) {
                                setState(() {
                                  _loadingStatusAnimation = 'failure';

                                  _isLoading = false;
                                });
                              } */

                            /* Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return ParentalConsent(consentDetail: 'Google',);
                                  },
                                ),
                              ); */
                          }
                          /* if (signInWithGoogle() != null){
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return ParentalConsent();
                                  },
                                ),
                              );
                            } else{
                              print('GoogleSignIn Not successful');
                            } */

                          /*  signInWithGoogle().whenComplete(() {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return ParentalConsent();
                                  },
                                ),
                              );
                            }); */
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              top: deviceHeight > 500
                                  ? (deviceHeight - (deviceHeight * 0.25)) *
                                      0.04
                                  : (deviceHeight - (deviceHeight * 0.2)) *
                                      0.04),
                          width: deviceHeight > 500
                              ? (deviceWidth * 0.55) * 0.75
                              : (deviceWidth * 0.47) * 0.75,
                          child: AspectRatio(
                            aspectRatio: 442 / 65,
                            child: Container(
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromRGBO(0, 0, 0, 0.20),
                                      blurRadius:
                                          15.0, // has the effect of softening the shadow
                                      spreadRadius:
                                          -5, // has the effect of extending the shadow
                                      offset: Offset(
                                        0.0, // horizontal, move right 10
                                        5.0, // vertical, move down 10
                                      ),
                                    ),
                                  ],
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(500))),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    height: deviceHeight > 500
                                        ? (((deviceWidth * 0.55) * 0.75) *
                                                (65 / 442)) *
                                            0.6
                                        : (((deviceWidth * 0.47) * 0.75) *
                                                (65 / 442)) *
                                            0.6,
                                    margin: EdgeInsets.only(
                                      left: deviceHeight > 500
                                          ? ((deviceWidth * 0.55) * 0.75) * 0.07
                                          : ((deviceWidth * 0.47) * 0.75) *
                                              0.07,
                                    ),
                                    child: SvgPicture.asset(
                                        'assets/images/loginDialog/googleIcon.svg'),
                                  ),
                                  Spacer(),
                                  Container(
                                    height: deviceHeight > 500
                                        ? (((deviceWidth * 0.55) * 0.75) *
                                                (65 / 442)) *
                                            0.4
                                        : (((deviceWidth * 0.47) * 0.75) *
                                                (65 / 442)) *
                                            0.45,
                                    child: Material(
                                      color: Colors.transparent,
                                      child: FittedBox(
                                        fit: BoxFit.fitHeight,
                                        child: Text(
                                          'Google',
                                          style: TextStyle(
                                            fontFamily: 'NunitoRegular',
                                            color: Color.fromRGBO(
                                                80, 85, 89, 1.00),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    margin: EdgeInsets.only(
                                      right: deviceHeight > 500
                                          ? ((deviceWidth * 0.55) * 0.75) * 0.07
                                          : ((deviceWidth * 0.47) * 0.75) *
                                              0.07,
                                    ),
                                    child: SvgPicture.asset(
                                      'assets/images/loginDialog/googleIcon.svg',
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    /////////////////////////////////////// Use as guest
                    deviceHeight > 500 ? Container() : Spacer(),
                    IgnorePointer(
                      ignoring: _loadingVisible,
                      child: GestureDetector(
                        onTap: _perventMultipleTab
                            ? () {
                                setState(() {
                                  _perventMultipleTab = false;
                                  _isLoading = !_isLoading;
                                });

                                Timer(
                                    Duration(seconds: 1),
                                    () => setState(
                                        () => _perventMultipleTab = true));
                                Provider.of<AudioProvider>(context,
                                        listen: false)
                                    .playSoundEffect("click3", 1.0);
                                Navigator.pop(context);
                              }
                            : null,
                        child: Container(
                          margin: EdgeInsets.only(
                              top: deviceHeight > 500
                                  ? (deviceWidth * 0.55) * 0.05
                                  : 0),
                          height: deviceHeight > 500
                              ? (((deviceWidth * 0.55) * 0.75) * (65 / 442)) *
                                  0.45
                              : (((deviceWidth * 0.47) * 0.75) * (65 / 442)) *
                                  0.45,
                          child: Material(
                            color: Colors.transparent,
                            child: FittedBox(
                              fit: BoxFit.fitHeight,
                              child: Text(
                                'Use as Guest',
                                style: TextStyle(
                                  fontFamily: 'NunitoRegular',
                                  color: Color.fromRGBO(255, 255, 255, 1.00),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    deviceHeight > 500 ? Container() : Spacer(),
                  ],
                ),
              ),
              ///////////////////// Close Btn
              Positioned.fill(
                child: Align(
                  alignment: Alignment.topRight,
                  child: IgnorePointer(
                    ignoring: _loadingVisible,
                    child: GestureDetector(
                      onTap: _perventMultipleTab
                          ? () {
                              setState(() {
                                _perventMultipleTab = false;
                              });

                              Timer(
                                  Duration(seconds: 1),
                                  () => setState(
                                      () => _perventMultipleTab = true));
                              Provider.of<AudioProvider>(context, listen: false)
                                  .playSoundEffect("click3", 1.0);
                              Navigator.pop(context);
                            }
                          : null,
                      child: Container(
                        margin: EdgeInsets.only(
                          top: deviceHeight > 500
                              ? (deviceHeight * 0.25) +
                                  (deviceWidth * 0.55) * 0.04
                              : (deviceHeight * 0.2) +
                                  (deviceWidth * 0.55) * 0.04,
                          right: deviceHeight > 500
                              ? (deviceWidth * 0.55) * 0.04
                              : (deviceWidth * 0.55) * 0.04,
                        ),
                        width: deviceHeight > 500
                            ? (deviceWidth * 0.55) * 0.06
                            : (deviceWidth * 0.47) * 0.06,
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: SvgPicture.asset(
                              'assets/images/themePopup/closePopup.svg'),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              ///////////////////// Facebook Btn
              /* Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ParentalConsent(),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 234),
                        width: 442,
                        child: Image.asset('assets/images/loginDialog/face.png'),
                      ),
                    ),
                  ),
                ), */
              ///////////////////// Google Btn
              /* Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ParentalConsent(),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 144),
                        width: 442,
                        child:
                            Image.asset('assets/images/loginDialog/google.png'),
                      ),
                    ),
                  ),
                ), */
              ////////////////////// Guest Mode
              /*  Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        return;
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 92),
                        child: Material(
                          color: Colors.transparent,
                          child: Text(
                            'Use as Guest',
                            style: TextStyle(
                                fontFamily: 'NunitoRegular',
                                fontSize: deviceHeight > 500 ? 19 : 15,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ), */
              ////////////////////////////////// Loading

              Visibility(
                visible: _loadingVisible,
                child: Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 200,
                      height: 200,
                      child: FlareLoading(
                        name: 'assets/animation/loading.flr',
                        loopAnimation: 'loading',
                        endAnimation: _loadingStatusAnimation,
                        isLoading: _isLoading,
                        onSuccess: (_) {
                          print('finish loading');

                          if (Provider.of<DataProvider>(context, listen: false)
                                  .status ==
                              Status.Authenticated) {
                            FirebaseAuth.instance
                                .currentUser()
                                .then((currentUser) => {
                                      Firestore.instance
                                          .collection("WiseKidsUser")
                                          .document(currentUser.uid)
                                          .get()
                                          .then((DocumentSnapshot result) {
                                        /////////////////////////////// if consented skip to parentCenter
                                        if (result["acceptedConsent"]) {
                                          Navigator.pop(context);
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return ParentalKidsCenter();
                                              },
                                            ),
                                          );
                                        } else {
                                          ////////////////////// if not consented goto parentConsent
                                          Navigator.pop(context);
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return ParentalConsent(
                                                  consentDetail: _consent,
                                                );
                                              },
                                            ),
                                          );
                                        }
                                      }).catchError((err) => print(err))
                                    })
                                .catchError((err) => print(err));
                          }
                          /* else if (Provider.of<DataProvider>(context,
                                        listen: true)
                                    .status ==
                                Status.Unauthenticated) {
                              Navigator.pop(context);
                              Fluttertoast.showToast(
                                  msg: "Sign fail, try again later",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 2,
                                  backgroundColor: Colors.black54,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            } */
                        },
                        onError: (err, stack) {
                          print(err);
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onVerticalDragStart(DragStartDetails drag) {
    setState(() {
      _initialPosition = drag.globalPosition.dy;
    });
  }

  void _onVerticalDragUpdate(DragUpdateDetails drag) {
    setState(() {
      final temp = _currentPosition;
      _currentPosition = drag.globalPosition.dy - _initialPosition;
      if (_currentPosition < 0) {
        _currentPosition = temp;
      }
    });
  }

  void _onVerticalDragEnd(DragEndDetails drag) {
    if (_currentPosition > 100.0) {
      Navigator.pop(context);
      return;
    }
    setState(() {
      _currentPosition = 0.0;
    });
  }
}

class SelectThemeWidget extends StatefulWidget {
  String themePath;
  double deviceHeight;
  bool visible;

  SelectThemeWidget({
    @required this.themePath,
    Key key,
    @required this.deviceHeight,
    @required this.visible,
  }) : super(key: key);

  @override
  _SelectThemeWidgetState createState() => _SelectThemeWidgetState();
}

class _SelectThemeWidgetState extends State<SelectThemeWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: widget.deviceHeight > 500
              ? widget.deviceHeight * 0.08
              : widget.deviceHeight * 0.08,
          child: Image.asset(widget.themePath),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: Visibility(
              visible: widget.visible,
              child: Container(
                height: widget.deviceHeight > 500
                    ? widget.deviceHeight * 0.034
                    : widget.deviceHeight * 0.034,
                child: Image.asset('assets/images/themePopup/theme1Choose.png'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
