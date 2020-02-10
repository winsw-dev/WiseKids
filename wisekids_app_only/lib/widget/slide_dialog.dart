import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:provider/provider.dart';
import '../provider/dataProvider.dart';

class SlideDialog extends StatefulWidget {
  final Widget child;
  final Color backgroundColor;

  SlideDialog({
    @required this.child,
    @required this.backgroundColor,
  });

  @override
  _SlideDialogState createState() => _SlideDialogState();
}

class _SlideDialogState extends State<SlideDialog> {
  var _initialPosition = 0.0;
  var _currentPosition = 0.0;

  var avatarSwipeController = new SwiperController();

  List<String> avatar = [
    "assets/images/avatar_boy.png",
    "assets/images/avatar_girl.png",
    "assets/images/avatar_cat.png"
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
              /////////////////////////////////////////////// popup Card
              Container(
                margin: EdgeInsets.only(
                    top: deviceHeight > 500
                        ? deviceHeight * 0.09
                        : deviceHeight * 0.09),
                width: deviceWidth * 0.55,
                height: deviceHeight * 0.61,
                child: Material(
                  /////////////////////////////////////////// Popup Bg color
                  color: Color.fromRGBO(255, 249, 232, 1.00),
                  ///////////////////////////////////////////
                  elevation: 24.0,
                  type: MaterialType.card,
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: deviceWidth * 0.55,
                        height: deviceHeight * 0.61,
                        child: Stack(
                          children: <Widget>[
                            /////////////////////////////////////// Theme Bg
                            Container(
                              child: Image.asset(
                                  'assets/images/themePopup/theme1Bg.png'),
                            ),
                            /////////////////////////////////////// White Bg
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      ///////////////////////////// round corner bottom left,right
                                      Radius.circular(30.0),
                                    ),
                                  ),
                                  height: 271,
                                ),
                              ),
                            ),

                            /////////////////////////////////////// Cloud
                            Container(
                              margin: EdgeInsets.only(
                                  top: deviceHeight > 500
                                      ? deviceHeight * 0.19
                                      : deviceHeight * 0.19),
                              child: Image.asset(
                                  'assets/images/themePopup/cloudPopup.png'),
                            ),

                            /////////////////////////////////////// Close Btn
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.topRight,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                    return;
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        top: deviceHeight > 500
                                            ? deviceHeight * 0.013
                                            : deviceHeight * 0.013,
                                        right: deviceHeight > 500
                                            ? deviceHeight * 0.013
                                            : deviceHeight * 0.013),
                                    width: deviceHeight > 500
                                        ? deviceWidth * 0.044
                                        : deviceWidth * 0.044,
                                    child: SvgPicture.asset(
                                        'assets/images/themePopup/closePopup.svg'),
                                  ),
                                ),
                              ),
                            ),
                            //////////////////////////////////////  Avatar Swiper
                            Column(
                              children: <Widget>[
                                Container(
                                  height: deviceHeight > 500
                                      ? deviceHeight * 0.255
                                      : deviceHeight * 0.23,
                                  margin: EdgeInsets.only(
                                      top: deviceHeight > 500
                                          ? deviceHeight * 0.075
                                          : deviceHeight * 0.075),
                                  child: new Swiper(
                                    index: Provider.of<DataProvider>(context,
                                            listen: false)
                                        .selectAvatarSwiperIndex(),
                                    loop: false,
                                    controller: avatarSwipeController,
                                    onTap: (int index) {
                                      if (index == 0) {
                                        avatarSwipeController.move(0,
                                            animation: true);
                                      } else if (index == 1) {
                                        avatarSwipeController.move(1,
                                            animation: true);
                                      } else if (index == 2) {
                                        avatarSwipeController.move(2,
                                            animation: true);
                                      }
                                    },
                                    onIndexChanged: (int index) {
                                      setState(() {
                                        Provider.of<DataProvider>(context,
                                                listen: false)
                                            .selectAvatarSwiper(index);
                                      });
                                    },
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        decoration: new BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          boxShadow: [
                                            BoxShadow(
                                              ///////////////////////// Shadow color
                                              color: Color.fromRGBO(
                                                  255, 96, 82, 0.36),
                                              blurRadius:
                                                  15.0, // has the effect of softening the shadow
                                              spreadRadius:
                                                  -5, // has the effect of extending the shadow
                                              offset: Offset(
                                                0.0, // horizontal, move right 10
                                                10.0, // vertical, move down 10
                                              ),
                                            )
                                          ],
                                        ),
                                        margin: EdgeInsets.only(
                                            /* left: 8, right: 8, */ bottom:
                                                20),
                                        child: new ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.asset(
                                            avatar[index],
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      );
                                    },
                                    itemCount: 3,
                                    viewportFraction: 0.31,
                                    scale: 0.1,
                                  ),
                                ),
                                ///////////////////////////////// Select Your Avatar Spacer
                                Container(
                                  margin: EdgeInsets.only(
                                      top: deviceHeight > 500
                                          ? deviceHeight * 0.035
                                          : deviceHeight * 0.035),
                                  child: SvgPicture.asset(
                                      'assets/images/themePopup/selectYourAvatarSpacer.svg'),
                                ),
                                /////////////////////////////////////  Select Theme
                                Container(
                                  margin: EdgeInsets.only(
                                      top: deviceHeight > 500
                                          ? deviceHeight * 0.045
                                          : deviceHeight * 0.045),
                                  child: Wrap(
                                    spacing: deviceHeight > 500
                                        ? deviceWidth * 0.02
                                        : deviceWidth * 0.02,
                                    children: <Widget>[
                                      ///////////////////////////////// choose theme1
                                      GestureDetector(
                                        onTap: () {
                                          WidgetsBinding.instance
                                              .addPostFrameCallback((_) {
                                            // Add Your Code here.
                                            Provider.of<DataProvider>(context,
                                                    listen: false)
                                                .chooseTheme(1);
                                          });
                                        },
                                        child: Consumer<DataProvider>(
                                          builder:
                                              (context, themeProvider, child) =>
                                                  SelectThemeWidget(
                                            visible:
                                                themeProvider.theme1Visibility,
                                            themePath:
                                                'assets/images/themePopup/theme1Preview.png',
                                            deviceHeight: deviceHeight,
                                          ),
                                        ),
                                      ),
                                      //////////////////////////////// choose theme2
                                      GestureDetector(
                                        onTap: () {
                                          WidgetsBinding.instance
                                              .addPostFrameCallback((_) {
                                            Provider.of<DataProvider>(context,
                                                    listen: false)
                                                .chooseTheme(2);
                                          });
                                        },
                                        child: Consumer<DataProvider>(
                                          builder:
                                              (context, themeProvider, child) =>
                                                  SelectThemeWidget(
                                            visible:
                                                themeProvider.theme2Visibility,
                                            themePath:
                                                'assets/images/themePopup/theme2Preview.png',
                                            deviceHeight: deviceHeight,
                                          ),
                                        ),
                                      ),
                                      //////////////////////////////// choose theme3
                                      GestureDetector(
                                        onTap: () {
                                          WidgetsBinding.instance
                                              .addPostFrameCallback((_) {
                                            Provider.of<DataProvider>(context,
                                                    listen: false)
                                                .chooseTheme(3);
                                          });
                                        },
                                        child: Consumer<DataProvider>(
                                          builder:
                                              (context, themeProvider, child) =>
                                                  SelectThemeWidget(
                                            visible:
                                                themeProvider.theme3Visibility,
                                            themePath:
                                                'assets/images/themePopup/theme3Preview.png',
                                            deviceHeight: deviceHeight,
                                          ),
                                        ),
                                      ),
                                      /////////////////////////////// choose theme4
                                      GestureDetector(
                                        onTap: () {
                                          WidgetsBinding.instance
                                              .addPostFrameCallback((_) {
                                            Provider.of<DataProvider>(context,
                                                    listen: false)
                                                .chooseTheme(4);
                                          });
                                        },
                                        child: Consumer<DataProvider>(
                                          builder:
                                              (context, themeProvider, child) =>
                                                  SelectThemeWidget(
                                            visible:
                                                themeProvider.theme4Visibility,
                                            themePath:
                                                'assets/images/themePopup/theme4Preview.png',
                                            deviceHeight: deviceHeight,
                                          ),
                                        ),
                                      ),
                                      /////////////////////////////// choose theme5
                                      GestureDetector(
                                        onTap: () {
                                          WidgetsBinding.instance
                                              .addPostFrameCallback((_) {
                                            Provider.of<DataProvider>(context,
                                                    listen: false)
                                                .chooseTheme(5);
                                          });
                                        },
                                        child: Consumer<DataProvider>(
                                          builder:
                                              (context, themeProvider, child) =>
                                                  SelectThemeWidget(
                                            visible:
                                                themeProvider.theme5Visibility,
                                            themePath:
                                                'assets/images/themePopup/theme5Preview.png',
                                            deviceHeight: deviceHeight,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      widget.child,
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30.0),
                    ),
                  ),
                ),
              ),
              //////////////////////////////////////// select Avatar Sign
              Positioned.fill(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: deviceHeight > 500
                        ? deviceWidth * 0.38
                        : deviceWidth * 0.38,
                    child: Image.asset(
                        'assets/images/themePopup/selectAvatarSign.png'),
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
