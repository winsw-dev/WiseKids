import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../screen/parentalConsent.dart';

import 'package:provider/provider.dart';
import '../provider/dataProvider.dart';

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

  var avatarSwipeController = new SwiperController();

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
        child: Center(
          child: Stack(
            children: <Widget>[
              ///////////////////// Bg
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: 977,
                    child: Image.asset(
                        'assets/images/loginDialog/loginDialogBg.png'),
                  ),
                ),
              ),
              ///////////////////// Close Btn
              Positioned.fill(
                child: Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      return;
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 250, top: 210),
                      child: SvgPicture.asset(
                          'assets/images/loginDialog/close.svg'),
                    ),
                  ),
                ),
              ),
              ///////////////////// Facebook Btn
              Positioned.fill(
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
              ),
              ///////////////////// Google Btn
              Positioned.fill(
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
              ),
              ////////////////////// Guest Mode
              Positioned.fill(
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
