import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:provider/provider.dart';
import '../provider/dataProvider.dart';

Future<T> showSlideDialog<T>({
  @required BuildContext context,
  @required Widget child,
  String popUpMode,
  int editWhichKid,
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
    barrierDismissible: true,
    barrierLabel: "Dismiss",
    transitionDuration: transitionDuration,
    transitionBuilder: (context, animation1, animation2, widget) {
      final curvedValue = Curves.easeInOut.transform(animation1.value) - 1.0;
      return Transform(
        transform: Matrix4.translationValues(0.0, curvedValue * -300, 0.0),
        child: Opacity(
          opacity: animation1.value,
          child: SelectAvatarAddKidsDialog(popUpMode: popUpMode,editWhichKid: editWhichKid,
            child: child,
            
            backgroundColor: backgroundColor ?? Theme.of(context).canvasColor,
          ),
        ),
      );
    },
  );
}


////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////


class SelectAvatarAddKidsDialog extends StatefulWidget {
  final int editWhichKid;
  final String popUpMode;
  final Widget child;
  final Color backgroundColor;

  SelectAvatarAddKidsDialog({
    @required this.child,
    @required this.backgroundColor,
    @required this.popUpMode, this.editWhichKid
  });

  @override
  _SelectAvatarAddKidsDialogState createState() => _SelectAvatarAddKidsDialogState();
}

class _SelectAvatarAddKidsDialogState extends State<SelectAvatarAddKidsDialog> {
  var _initialPosition = 0.0;
  var _currentPosition = 0.0;
  bool _perventMultipleTab = true;

  var _avatarSwipeController = new SwiperController();

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

  Color themeColor(int currentTheme) {
    if (currentTheme == 1) {
      return Colors.white;
    } else if (currentTheme == 2) {
      return Color.fromRGBO(255, 165, 198, 1.00);
    } else if (currentTheme == 3) {
      return Color.fromRGBO(26, 8, 66, 1.00);
    } else if (currentTheme == 4) {
      return Color.fromRGBO(0, 192, 224, 1.00);
    } else if (currentTheme == 5) {
      return Color.fromRGBO(133, 203, 139, 1.00);
    }
  }

 

  ///////////////////////////////////////////// use this override to prevent [ setState() called after dispose() ] error!!
  @override
   void setState(fn) {
    if(mounted){
      super.setState(fn);
    }
  }
  /////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {

    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets ,
      /* MediaQuery.of(context).viewInsets +
          EdgeInsets.only(top: deviceHeight / 3.0 + _currentPosition), */
      duration: Duration(milliseconds: 100),
      curve: Curves.bounceOut,
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
                        : deviceHeight * 0.2),
                width: deviceHeight > 500
                    ? deviceWidth * 0.55
                    : deviceWidth * 0.47,
                height:
                    deviceHeight > 500 ? deviceHeight * 0.61 : double.infinity,
                child: Material(
                  /////////////////////////////////////////// Popup Bg color
                  //color: Color.fromRGBO(255, 249, 232, 1.00),
                  color: Colors.white,
                  ///////////////////////////////////////////
                  elevation: 24.0,
                  type: MaterialType.card,
                  child: Column(
                    children: <Widget>[
                      Container(
                        /* width: deviceHeight > 500
                            ? deviceWidth * 0.55
                            : deviceWidth * 0.48,
                        height: deviceHeight * 0.61, */
                        child: Stack(
                          children: <Widget>[
                            /////////////////////////////////////// Theme Bg
                            Consumer<DataProvider>(
                              builder: (context, themeProvider, child) =>
                                  Container(
                                decoration: BoxDecoration(
                                  color: themeColor(themeProvider.addkidsTheme),
                                  borderRadius: BorderRadius.all(
                                    ///////////////////////////// round corner bottom left,right
                                    Radius.circular(30),
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(31.5),
                                      topRight: Radius.circular(31.5)),
                                  child: Image.asset(
                                    themePopupBg[
                                        themeProvider.addkidsTheme-1],
                                    gaplessPlayback: true,
                                  ),
                                ),
                              ),
                            ),
                            /////////////////////////////////////// White Bg
                            /* Positioned.fill(
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.all(
                                      ///////////////////////////// round corner bottom left,right
                                      Radius.circular(30),
                                    ),
                                  ),
                                  height: 271,
                                ),
                              ),
                            ), */

                            /////////////////////////////////////// Cloud
                            Container(
                              /* width: deviceHeight > 500
                                  ? deviceWidth * 0.55
                                  : deviceWidth * 0.4, */
                              margin: EdgeInsets.only(
                                  top: deviceHeight > 500
                                      ? (deviceHeight * 0.61) * 0.31
                                      : (deviceHeight - (deviceHeight * 0.2)) *
                                          0.31),
                              child: Image.asset(
                                'assets/images/themePopup/cloudPopup.png',
                                fit: BoxFit.fitWidth,
                              ),
                            ),

                            /////////////////////////////////////// Close Btn
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
                                          Navigator.pop(context);
                                        }
                                      : null,
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      top: deviceHeight > 500
                                          ? (deviceWidth * 0.55) * 0.023
                                          : (deviceWidth * 0.55) * 0.023,
                                      right: deviceHeight > 500
                                          ? (deviceWidth * 0.55) * 0.023
                                          : (deviceWidth * 0.55) * 0.023,
                                    ),
                                    width: deviceHeight > 500
                                        ? (deviceWidth * 0.55) * 0.08
                                        : (deviceWidth * 0.47) * 0.08,
                                    child: AspectRatio(
                                      aspectRatio: 1,
                                      child: SvgPicture.asset(
                                          'assets/images/themePopup/closePopup.svg'),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            //////////////////////////////////////  Avatar Swiper
                            Column(
                              children: <Widget>[
                                Container(
                                  width: deviceHeight > 500
                                      ? deviceWidth * 0.55
                                      : deviceWidth * 0.47,
                                  /* height: deviceHeight > 500
                                      ? deviceHeight * 0.255
                                      : (deviceHeight - (deviceHeight * 0.2)) *
                                          0.45, */

                                  margin: EdgeInsets.only(
                                      top: deviceHeight > 500
                                          ? (deviceHeight * 0.61) * 0.15
                                          : (deviceHeight -
                                                  (deviceHeight * 0.2)) *
                                              0.15),
                                  child: AspectRatio(
                                    aspectRatio: 565 / 195,
                                    child: NotificationListener<
                                        OverscrollIndicatorNotification>(
                                      onNotification:
                                          (OverscrollIndicatorNotification
                                              overscroll) {
                                        overscroll.disallowGlow();
                                      },
                                      child: new Swiper(
                                        index:widget.popUpMode=='createProfile'? Provider.of<DataProvider>(
                                                context,
                                                listen: false)
                                            .selectAvatarSwiperIndexAddKids():Provider.of<DataProvider>(
                                                context,
                                                listen: false).selectAvatarSwiperIndexEditKids(Provider.of<DataProvider>(
                                                context,
                                                listen: false).cacheEditKidsProfileAvatar),
                                        loop: false,
                                        controller: _avatarSwipeController,
                                        onTap: (int index) {
                                          if (index == 0) {
                                            _avatarSwipeController.move(0,
                                                animation: true);
                                          } else if (index == 1) {
                                            _avatarSwipeController.move(1,
                                                animation: true);
                                          } else if (index == 2) {
                                            _avatarSwipeController.move(2,
                                                animation: true);
                                          }
                                        },
                                        onIndexChanged:widget.popUpMode=='createProfile'?  (int index) {
                                          setState(() {
                                            Provider.of<DataProvider>(context,
                                                    listen: false)
                                                .selectAvatarSwiperAddKids(index);
                                          });
                                        }:(int index) {
                                          Provider.of<DataProvider>(context,
                                                    listen: false)
                                                .editProfileAvatar(widget.editWhichKid, index);


                                        },
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Consumer<DataProvider>(
                                            builder: (context, theme, child) =>
                                                Container(
                                              decoration: new BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                boxShadow: [
                                                  BoxShadow(
                                                    ///////////////////////// Shadow color
                                                    color: shadowColor[theme
                                                        .addkidsTheme-1],
                                                    blurRadius:
                                                        15.0, // has the effect of softening the shadow
                                                    spreadRadius:
                                                        -5, // has the effect of extending the shadow
                                                    offset: Offset(
                                                      0.0, // horizontal, move right 10
                                                      8.0, // vertical, move down 10
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
                                            ),
                                          );
                                        },
                                        itemCount: 3,
                                        viewportFraction: 0.31,
                                        scale: 0.1,
                                      ),
                                    ),
                                  ),
                                ),
                                ///////////////////////////////// Select Your Avatar Spacer
                                Consumer<DataProvider>(
                                  builder: (context, theme, child) => Container(
                                    width: deviceHeight > 500
                                        ? deviceWidth * 0.55 * 0.83
                                        : deviceWidth * 0.47 * 0.82,
                                    margin: EdgeInsets.only(
                                        top: deviceHeight > 500
                                            ? (deviceHeight * 0.61) * 0.02
                                            : (deviceHeight -
                                                    (deviceHeight * 0.2)) *
                                                0.02),
                                    child: SvgPicture.asset(
                                      selectYourThemeSvg[
                                          theme.addkidsTheme-1],
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                ),
                                /////////////////////////////////////  Select Theme
                                Container(
                                  height: deviceHeight > 500
                                      ? (deviceHeight * 0.61) -
                                          (((((deviceHeight * 0.61) * 0.15) +
                                                      ((deviceWidth * 0.55) *
                                                          (195 / 565))) +
                                                  ((deviceHeight * 0.61) *
                                                      0.02)) +
                                              ((deviceWidth * 0.55 * 0.83) *
                                                  (24 / 489)))
                                      : null,
                                  margin: EdgeInsets.only(
                                      top: deviceHeight > 500
                                          ? 0 //(deviceHeight * 0.61) * 0.1
                                          : (deviceHeight -
                                                  (deviceHeight * 0.2)) *
                                              0.07),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Wrap(
                                        spacing: deviceHeight > 500
                                            ? deviceWidth * 0.02
                                            : deviceWidth * 0.02,
                                        children: <Widget>[
                                          ///////////////////////////////// choose theme1
                                          GestureDetector(
                                            onTap: widget.popUpMode=='createProfile'? () => /* {
                                              WidgetsBinding.instance
                                                  .addPostFrameCallback((_) { */
                                                // Add Your Code here.
                                                Provider.of<DataProvider>(
                                                        context,
                                                        listen: false)
                                                    .chooseThemeAddKids(1)//;
                                              /* });
                                            } */:() => Provider.of<DataProvider>(
                                                        context,
                                                        listen: false)
                                                    .chooseThemeEditKidsProfile(1),
                                            child: Consumer<DataProvider>(
                                              builder: (context, themeProvider,
                                                      child) =>
                                                  SelectThemeWidget(
                                                visible: themeProvider
                                                    .cacheEditKidsTheme1Visibility,
                                                themePath:
                                                    'assets/images/themePopup/theme1Preview.png',
                                                deviceHeight: deviceHeight,
                                                deviceWidth: deviceWidth,
                                              ),
                                            ),
                                          ),
                                          //////////////////////////////// choose theme2
                                          GestureDetector(
                                            onTap: widget.popUpMode=='createProfile'? () =>/*{
                                               WidgetsBinding.instance
                                                  .addPostFrameCallback((_) { */
                                                Provider.of<DataProvider>(
                                                        context,
                                                        listen: false)
                                                    .chooseThemeAddKids(2)
                                              /* });
                                            } */:() =>Provider.of<DataProvider>(
                                                        context,
                                                        listen: false)
                                                    .chooseThemeEditKidsProfile(2),
                                            child: Consumer<DataProvider>(
                                              builder: (context, themeProvider,
                                                      child) =>
                                                  SelectThemeWidget(
                                                visible: themeProvider
                                                    .cacheEditKidsTheme2Visibility,
                                                themePath:
                                                    'assets/images/themePopup/theme2Preview.png',
                                                deviceHeight: deviceHeight,
                                                deviceWidth: deviceWidth,
                                              ),
                                            ),
                                          ),
                                          //////////////////////////////// choose theme3
                                          GestureDetector(
                                            onTap:widget.popUpMode=='createProfile'? () =>/* {
                                              WidgetsBinding.instance
                                                  .addPostFrameCallback((_) { */
                                                Provider.of<DataProvider>(
                                                        context,
                                                        listen: false)
                                                    .chooseThemeAddKids(3)
                                              /* });
                                            } */:() =>Provider.of<DataProvider>(
                                                        context,
                                                        listen: false)
                                                    .chooseThemeEditKidsProfile(3),
                                            child: Consumer<DataProvider>(
                                              builder: (context, themeProvider,
                                                      child) =>
                                                  SelectThemeWidget(
                                                visible: themeProvider
                                                    .cacheEditKidsTheme3Visibility,
                                                themePath:
                                                    'assets/images/themePopup/theme3Preview.png',
                                                deviceHeight: deviceHeight,
                                                deviceWidth: deviceWidth,
                                              ),
                                            ),
                                          ),
                                          /////////////////////////////// choose theme4
                                          GestureDetector(
                                            onTap:widget.popUpMode=="createProfile"? () =>/* {
                                              WidgetsBinding.instance
                                                  .addPostFrameCallback((_) { */
                                                Provider.of<DataProvider>(
                                                        context,
                                                        listen: false)
                                                    .chooseThemeAddKids(4)
                                             /*  });
                                            } */:() =>Provider.of<DataProvider>(
                                                        context,
                                                        listen: false)
                                                    .chooseThemeEditKidsProfile(4),
                                            child: Consumer<DataProvider>(
                                              builder: (context, themeProvider,
                                                      child) =>
                                                  SelectThemeWidget(
                                                visible: themeProvider
                                                    .cacheEditKidsTheme4Visibility,
                                                themePath:
                                                    'assets/images/themePopup/theme4Preview.png',
                                                deviceHeight: deviceHeight,
                                                deviceWidth: deviceWidth,
                                              ),
                                            ),
                                          ),
                                          /////////////////////////////// choose theme5
                                          GestureDetector(
                                            onTap:widget.popUpMode=='createProfile'? () =>/* {
                                              WidgetsBinding.instance
                                                  .addPostFrameCallback((_) { */
                                                Provider.of<DataProvider>(
                                                        context,
                                                        listen: false)
                                                    .chooseThemeAddKids(5)
                                              /* });
                                            } */:() => Provider.of<DataProvider>(
                                                        context,
                                                        listen: false)
                                                    .chooseThemeEditKidsProfile(5),
                                            child: Consumer<DataProvider>(
                                              builder: (context, themeProvider,
                                                      child) =>
                                                  SelectThemeWidget(
                                                visible: themeProvider
                                                    .cacheEditKidsTheme5Visibility,
                                                themePath:
                                                    'assets/images/themePopup/theme5Preview.png',
                                                deviceHeight: deviceHeight,
                                                deviceWidth: deviceWidth,
                                              ),
                                            ),
                                          ),
                                        ],
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
                    borderRadius: BorderRadius.only(
                      topLeft: deviceHeight > 500
                          ? Radius.circular(31.5)
                          : Radius.circular(31.5),
                      topRight: deviceHeight > 500
                          ? Radius.circular(31.5)
                          : Radius.circular(31.5),
                      bottomLeft: deviceHeight > 500
                          ? Radius.circular(30)
                          : Radius.circular(0),
                      bottomRight: deviceHeight > 500
                          ? Radius.circular(30)
                          : Radius.circular(0),
                    ),
                  ),
                ),
              ),
              //////////////////////////////////////// select Avatar Sign
              Positioned.fill(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: EdgeInsets.only(
                        top: deviceHeight > 500
                            ? deviceHeight * 0.0
                            : (deviceHeight * 0.18) -
                                ((deviceHeight * 0.18) / 2)),
                    width: deviceHeight > 500
                        ? deviceWidth * 0.55 * 0.69
                        : deviceWidth * 0.47 * 0.69,
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
  double deviceWidth;
  bool visible;

  SelectThemeWidget({
    @required this.themePath,
    Key key,
    @required this.deviceHeight,
    @required this.deviceWidth,
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
          /* height: widget.deviceHeight > 500
              ? widget.deviceHeight * 0.08
              : widget.deviceHeight * 0.11, */
          width: widget.deviceHeight > 500
              ? widget.deviceWidth * 0.55 / 7.2
              : widget.deviceWidth * 0.47 / 7.5,
          child: Image.asset(
            widget.themePath,
            fit: BoxFit.fitWidth,
          ),
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