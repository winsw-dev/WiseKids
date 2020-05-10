import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:transparent_image/transparent_image.dart';

import '../widget/slide_popup_dialog.dart' as slideDialog;
import '../widget/slide_popup_dialog_vocab.dart' as vocabDialog;
import '../widget/slide_popup_dialog_login.dart' as loginDialog;
import '../widget/selectkids_popup.dart';
import './enterBook.dart';

import 'package:provider/provider.dart';
import '../provider/dataProvider.dart';

class Home extends StatefulWidget {
  /* Home({Key key, this.selectedAvatar}) : super(key: key); 
  final String selectedAvatar; */
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //var fadeInDuration = 100; for switch case
  var fadeInDuration = 100;

  List<String> bookShelf = [
    'assets/animation/book2.flr',
    'assets/animation/book3.flr',
    'assets/animation/book4.flr',
    'assets/animation/book5.flr',
    'assets/animation/book6.flr',
    'assets/animation/book7.flr',
    'assets/animation/book1.flr',
  ];

  List<String> starScoreBg = [
    'assets/images/theme1/profileStarSign.svg',
    'assets/images/theme2/profileStarSign.svg',
    'assets/images/theme3/profileStarSign.svg',
    'assets/images/theme4/profileStarSign.svg',
    'assets/images/theme5/profileStarSign.svg'
  ];

  List<String> loginBtnSvg = [
    'assets/images/theme1/login_button.svg',
    'assets/images/theme2/login_button.svg',
    'assets/images/theme3/login_button.svg',
    'assets/images/theme4/login_button.svg',
    'assets/images/theme5/login_button.svg'
  ];

  void _showThemeDialog() {
    slideDialog.showSlideDialog(
      context: context,
      child: Container(
        color: Colors.white,
      ),
    );
  }

  void _showLoginDialog() {
    loginDialog.showSlideDialog(
      context: context,
      child: Container(
        color: Colors.white,
      ),
    );
  }

  void _showVocabDialog() {
    vocabDialog.showSlideDialog(
      context: context,
      child: Container(),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('--------------------Build full-------------------------');

    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      top: deviceHeight > 500 ? false : true,
      bottom: false,
      right: false,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Consumer<DataProvider>(
              builder: (context, theme, child) {
                /* return  IndexedStack(     /// [not work] this solution make switch theme in notime (no flickering) but cause memory leak error when navigate back and forth between pages
                  index: theme.theme - 1,
                  children: <Widget>[
                    
                    Theme1(
                        deviceWidth: deviceWidth,
                        deviceHeight: deviceHeight,
                        fadeInDuration: fadeInDuration),
                    Theme2(
                        deviceWidth: deviceWidth,
                        deviceHeight: deviceHeight,
                        fadeInDuration: fadeInDuration),
                    Theme3(
                        deviceWidth: deviceWidth,
                        deviceHeight: deviceHeight,
                        fadeInDuration: fadeInDuration),
                    Theme4(
                        deviceWidth: deviceWidth,
                        deviceHeight: deviceHeight,
                        fadeInDuration: fadeInDuration),
                    Theme5(
                        deviceWidth: deviceWidth,
                        deviceHeight: deviceHeight,
                        fadeInDuration: fadeInDuration),
                  ],
                ); */
                switch (theme.theme[theme.currentKids]) {
                  case 1:
                    return Theme1(
                        deviceWidth: deviceWidth,
                        deviceHeight: deviceHeight,
                        fadeInDuration: fadeInDuration);

                  case 2:
                    return Theme2(
                      deviceWidth: deviceWidth,
                      deviceHeight: deviceHeight,
                      fadeInDuration: fadeInDuration,
                    );

                    break;
                  case 3:
                    return Theme3(
                        deviceWidth: deviceWidth,
                        deviceHeight: deviceHeight,
                        fadeInDuration: fadeInDuration);

                  case 4:
                    return Theme4(
                        deviceWidth: deviceWidth,
                        deviceHeight: deviceHeight,
                        fadeInDuration: fadeInDuration);

                  case 5:
                    return Theme5(
                        deviceWidth: deviceWidth,
                        deviceHeight: deviceHeight,
                        fadeInDuration: fadeInDuration);
                  default:
                    return Container();
                }
              },
            ),

            /////////////////////////////////////////////////////////////
            Column(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                          top: deviceHeight > 500
                              ? deviceHeight * 0.026
                              : deviceHeight * 0.036,
                          left: deviceHeight > 500
                              ? deviceHeight * 0.03
                              : deviceHeight * 0.04),
                      child: Stack(
                        children: <Widget>[
                          /////////////////////////////////////////////////// Profile overall
                          GestureDetector(
                            onTap: _showThemeDialog,
                            child: Consumer<DataProvider>(
                              builder: (context, theme, child) => Container(
                                width: deviceWidth * 0.13,
                                height: deviceWidth * 0.13,
                                margin: EdgeInsets.only(
                                    bottom: deviceHeight * 0.004),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(1000),
                                  border: Border.all(
                                      width: deviceHeight > 500 ? 6 : 3,
                                      color: theme
                                          .profileBorderColor //                   <--- border width here
                                      ),
                                ),
                                child: Consumer<DataProvider>(
                                    builder: (context, avatar, child) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(1000),
                                    child: Image.asset(
                                      'assets/images/avatar_' +
                                          avatar.avatar[avatar.currentKids] +
                                          '.png',
                                      gaplessPlayback: true,
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ),

                          ////////////////////////////////////////////////// Star Score overall
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Stack(
                                children: <Widget>[
                                  /////////////////////////// Star Score bg
                                  Consumer<DataProvider>(
                                    builder: (context, theme, child) =>
                                        Container(
                                      width: deviceHeight > 500
                                          ? deviceWidth * 0.093
                                          : deviceWidth * 0.1,
                                      height: deviceHeight > 500
                                          ? (deviceWidth * 0.134) * 0.237
                                          : (deviceWidth * 0.134) * 0.237,
                                      child: SvgPicture.asset(
                                        starScoreBg[
                                            theme.theme[theme.currentKids] - 1],
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  /////////////////////////// Star icon
                                  Positioned.fill(
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            left: deviceHeight > 500
                                                ? deviceWidth * 0.009
                                                : deviceWidth * 0.01),
                                        height: deviceHeight > 500
                                            ? (deviceWidth * 0.134) * 0.16
                                            : (deviceWidth * 0.134) * 0.16,
                                        child: Image.asset(
                                            "assets/images/theme1/starScore.png"),
                                      ),
                                    ),
                                  ),
                                  ///////////////////////////// Star Amount
                                  Positioned.fill(
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        height: deviceHeight > 500
                                            ? (deviceWidth * 0.134) * 0.19
                                            : (deviceWidth * 0.134) * 0.19,
                                        margin: EdgeInsets.only(
                                            right: deviceHeight > 500
                                                ? deviceWidth * 0.011
                                                : deviceWidth * 0.012),
                                        child: FittedBox(
                                          fit: BoxFit.fitHeight,
                                          child: Consumer<DataProvider>(
                                    builder: (context, provider, child) => Text(
                                              provider.kidsStar[provider.currentKids].toString(),
                                              style: TextStyle(
                                                  fontFamily: 'NunitoBold',
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  ///////////////////////////////
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //////////////////////////////////////// Vocabbulary
                    GestureDetector(
                      onTap: _showVocabDialog,
                      child: Container(
                        margin: EdgeInsets.only(
                            top: deviceHeight * 0.026 +
                                ((deviceHeight * 0.134) *
                                    0.14), //calculate with avatar box constraint height and margin
                            left: deviceHeight > 500
                                ? deviceHeight * 0.02
                                : deviceHeight * 0.035),
                        height: deviceHeight > 500
                            ? (deviceWidth * 0.134) * 0.7
                            : (deviceWidth * 0.134) * 0.7,
                        /* width: deviceHeight > 500
                            ? deviceHeight * 0.123
                            : deviceHeight * 0.193, */
                        child: AspectRatio(
                            aspectRatio: 1 / 1,
                            child: SvgPicture.asset(
                              'assets/icon/vocabulary.svg',
                            )),
                      ),
                    ),
                    //////////////////////////////////////// Login Btn
                    Spacer(),
                    GestureDetector(
                      onTap: Provider.of<DataProvider>(context, listen: false)
                                  .status ==
                              Status.Authenticated
                          ? () {
                              showDialog(
                                context: context,
                                builder: (_) => FunkyOverlay(),
                              );
                            }
                          : _showLoginDialog,
                      child: Container(
                        height: deviceHeight > 500
                            ? deviceWidth * 0.075
                            : deviceWidth * 0.065,
                        margin: EdgeInsets.only(
                          right: deviceHeight > 500
                              ? deviceWidth * 0.03
                              : deviceWidth * 0.03,
                          top: deviceHeight > 500
                              ? deviceHeight * 0.026 +
                                  ((deviceHeight * 0.134) * 0.27)
                              : deviceHeight * 0.036 +
                                  ((deviceHeight * 0.134) * 0.27),
                        ),
                        child: Stack(
                          children: <Widget>[
                            Consumer<DataProvider>(
                                builder: (context, theme, child) => AspectRatio(
                                      aspectRatio: 178 / 58,
                                      child: SvgPicture.asset(
                                          loginBtnSvg[
                                              theme.theme[theme.currentKids] -
                                                  1],
                                          fit: BoxFit.fitWidth),
                                    )),
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: deviceHeight > 500
                                          ? deviceWidth * 0.023
                                          : deviceWidth * 0.023,
                                      right: deviceHeight > 500
                                          ? deviceWidth * 0.023
                                          : deviceWidth * 0.023),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        height: deviceHeight > 500
                                            ? (deviceWidth * 0.075) * 0.45
                                            : (deviceWidth * 0.065) * 0.50,
                                        child: FittedBox(
                                          fit: BoxFit.fitHeight,
                                          child: Provider.of<DataProvider>(
                                                          context,
                                                          listen: false)
                                                      .status ==
                                                  Status.Authenticated
                                              ? Consumer<DataProvider>(
                                                  builder: (context, provider,
                                                          child) =>
                                                      Text(
                                                    provider.displayName[
                                                        provider.currentKids],
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'NunitoBlack',
                                                        //fontSize: deviceHeight > 500 ? 20 : 16,
                                                        color: provider.theme[provider.currentKids]==2? Color.fromRGBO(245, 98, 167, 1.0):Colors.white),
                                                  ),
                                                )
                                              : Text(
                                                  'Login',
                                                  style: TextStyle(
                                                      fontFamily: 'NunitoBlack',
                                                      //fontSize: deviceHeight > 500 ? 20 : 16,
                                                      color: Colors.white),
                                                ),
                                        ),
                                      ),
                                      Spacer(),
                                      Provider.of<DataProvider>(context,
                                                      listen: false)
                                                  .status ==
                                              Status.Authenticated
                                          ? Container(
                                              height: deviceHeight > 500
                                                  ? (deviceWidth * 0.075) * 0.13
                                                  : (deviceWidth * 0.065) *
                                                      0.15,
                                              child: AspectRatio(
                                                aspectRatio: 17 / 10,
                                                child: Consumer<DataProvider>(
                                                  builder: (context, provider,
                                                          child) => SvgPicture.asset(
                                                    'assets/icon/arrowDown.svg',
                                                    color: provider.theme[provider.currentKids]==2? Color.fromRGBO(245, 98, 167, 1.0):Colors.white,
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Container(
                                              height: deviceHeight > 500
                                                  ? (deviceWidth * 0.075) * 0.28
                                                  : (deviceWidth * 0.065) *
                                                      0.30,
                                              child: AspectRatio(
                                                aspectRatio: 10 / 17,
                                                child: Consumer<DataProvider>(
                                                  builder: (context, provider,
                                                          child) => SvgPicture.asset(
                                                    'assets/icon/arrowRight.svg',
                                                    color: provider.theme[provider.currentKids]==2? Color.fromRGBO(245, 98, 167, 1.0):Colors.white,
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
                  ],
                ),
                //////////////////////////////////////////////////////////// BookShelf Swiper
                Container(
                  margin: EdgeInsets.only(
                    top: deviceHeight > 500
                        ? ((deviceHeight * 0.6) -
                                ((deviceHeight -
                                        ((deviceHeight * 0.03) +
                                            (deviceWidth * 0.13))) *
                                    0.56)) /
                            2
                        : ((deviceHeight * 0.7) -
                                ((deviceHeight -
                                        ((deviceHeight * 0.04) +
                                            (deviceWidth * 0.13))) *
                                    0.85)) /
                            4,
                  ),
                  height: deviceHeight > 500
                      ? (deviceHeight -
                              ((deviceHeight * 0.03) + (deviceWidth * 0.13))) *
                          0.56
                      : (deviceHeight -
                              ((deviceHeight * 0.04) + (deviceWidth * 0.13))) *
                          0.85,
                  width: MediaQuery.of(context).size.width,
                  child: new Swiper(
                    onTap: (index) {},

                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        /* decoration: new BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black,
                                  blurRadius:
                                      10.0, // has the effect of softening the shadow
                                  spreadRadius:
                                      -1, // has the effect of extending the shadow
                                  offset: Offset(
                                    0.0, // horizontal, move right 10
                                    2.0, // vertical, move down 10
                                  ),
                                ),
                              ],
                            ), */
                        /* margin: EdgeInsets.only(
                          left: 12, right: 12, bottom: 10, top: 10), */
                        //padding: EdgeInsets.only(bottom: 20),
                        child: GestureDetector(
                          onTap: index == 6
                              ? () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EnterBook(),
                                    ),
                                  );
                                }
                              : () {},
                          child: Container(
                            child: FlareActor(bookShelf[index],
                                animation: 'bookAnimation'),
                          ),
                        ),
                      );
                    },
                    itemCount: 7,
                    //itemHeight: 206,
                    //itemWidth: 147,

                    viewportFraction: 0.3,
                    scale: 1.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Theme5 extends StatelessWidget {
  const Theme5(
      {Key key,
      @required this.deviceWidth,
      @required this.deviceHeight,
      this.fadeInDuration})
      : super(key: key);

  final double deviceWidth;
  final double deviceHeight;
  final int fadeInDuration;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        //////////////////////// preCache BG
        Container(
          width: deviceWidth,
          height: deviceHeight,
          color: Color.fromRGBO(110, 181, 137, 1.00),
        ),
        //////////////////////// BG
        Container(
          width: deviceWidth,
          height: deviceHeight,
          /* child: Image.asset(
            'assets/images/theme5/bg.png',
            fit: BoxFit.fill,
          ), */
          child: FittedBox(
            fit: BoxFit.fill,
            child: FadeInImage(
                fadeInDuration: Duration(milliseconds: fadeInDuration),
                placeholder: MemoryImage(kTransparentImage),
                image: AssetImage('assets/images/theme5/bg.png')),
          ),
        ),
        ///////////////////////// Forrest
        Container(
          margin: EdgeInsets.only(
              bottom: deviceHeight > 500 ? 0 : deviceHeight * 0.23),
          width: deviceWidth,
          height: deviceHeight * 0.82,
          /* child: Image.asset(
            'assets/images/theme5/forest.png',
            fit: BoxFit.fitWidth,
          ), */
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: FadeInImage(
                fadeInDuration: Duration(milliseconds: fadeInDuration),
                placeholder: MemoryImage(kTransparentImage),
                image: AssetImage('assets/images/theme5/forest.png')),
          ),
        ),
        ///////////////////////// Floor
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: deviceWidth,
              height: deviceHeight * 0.23,
              /* child: Image.asset(
                'assets/images/theme5/floor.png',
                fit: BoxFit.fitWidth,
              ), */
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: FadeInImage(
                    fadeInDuration: Duration(milliseconds: fadeInDuration),
                    placeholder: MemoryImage(kTransparentImage),
                    image: AssetImage('assets/images/theme5/floor.png')),
              ),
            ),
          ),
        ),
        ///////////////////////// Bird
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomRight,
            child: Container(
              margin: EdgeInsets.only(
                  right: deviceHeight > 500
                      ? deviceWidth * 0.4
                      : deviceWidth * 0.3,
                  bottom: deviceHeight > 500
                      ? deviceWidth * 0.06
                      : deviceWidth * 0.04),
              //width: deviceWidth,
              height: deviceHeight > 500
                  ? deviceHeight * 0.13
                  : deviceHeight * 0.18,
              /* child: Image.asset(
                'assets/images/theme5/bird.png',
                
              ), */
              child: FadeInImage(
                  fadeInDuration: Duration(milliseconds: fadeInDuration),
                  placeholder: MemoryImage(kTransparentImage),
                  image: AssetImage('assets/images/theme5/bird.png')),
            ),
          ),
        ),
      ],
    );
  }
}

class Theme4 extends StatelessWidget {
  const Theme4(
      {Key key,
      @required this.deviceWidth,
      @required this.deviceHeight,
      this.fadeInDuration})
      : super(key: key);

  final double deviceWidth;
  final double deviceHeight;
  final int fadeInDuration;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        //////////////////////// PreCache BG
        Container(
          width: deviceWidth,
          height: deviceHeight,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [
                0.1,
                0.25,
                1.0,
              ],
                  colors: [
                Color.fromRGBO(0, 195, 226, 1.0),
                Color.fromRGBO(3, 151, 199, 1.0),
                Color.fromRGBO(21, 17, 102, 1.0),
              ])),
        ),
        //////////////////////// BG
        Container(
          width: deviceWidth,
          height: deviceHeight,
          /* child: Image.asset(
            'assets/images/theme4/bg.png',
            gaplessPlayback: true,
            fit: BoxFit.fill,
          ), */
          child: FittedBox(
            fit: BoxFit.fill,
            child: FadeInImage(
                fadeInDuration: Duration(milliseconds: fadeInDuration),
                placeholder: MemoryImage(kTransparentImage),
                image: AssetImage('assets/images/theme4/bg.png')),
          ),
        ),
        ////////////////////////// Seaweed Sub left 1
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              margin: EdgeInsets.only(
                  left: deviceWidth * 0.01, bottom: deviceHeight * 0.26),
              height: deviceHeight > 500
                  ? (deviceHeight * 0.27) * 0.53
                  : (deviceHeight * 0.27) * 0.53,
              /* child: Image.asset(
                'assets/images/theme4/subSeaWeedLeft1.png',
                gaplessPlayback: true,
              ), */
              child: FadeInImage(
                  fadeInDuration: Duration(milliseconds: fadeInDuration),
                  placeholder: MemoryImage(kTransparentImage),
                  image:
                      AssetImage('assets/images/theme4/subSeaWeedLeft1.png')),
            ),
          ),
        ),
        ////////////////////////// Seaweed Sub left 2
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              margin: EdgeInsets.only(
                  left: deviceWidth * 0.48,
                  bottom: (deviceHeight * 0.26) * 0.27),
              height: deviceHeight > 500
                  ? (deviceHeight * 0.27) * 0.48
                  : (deviceHeight * 0.27) * 0.48,
              /* child: Image.asset(
                'assets/images/theme4/subSeaWeedCenter.png',
                gaplessPlayback: true,
              ), */
              child: FadeInImage(
                  fadeInDuration: Duration(milliseconds: fadeInDuration),
                  placeholder: MemoryImage(kTransparentImage),
                  image:
                      AssetImage('assets/images/theme4/subSeaWeedCenter.png')),
            ),
          ),
        ),
        ////////////////////////// Seaweed Sub Right 2
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomRight,
            child: Container(
              margin: EdgeInsets.only(
                  right: deviceWidth * 0.33,
                  bottom: (deviceHeight * 0.26) * 0.57),
              height: deviceHeight > 500
                  ? (deviceHeight * 0.27) * 0.53
                  : (deviceHeight * 0.27) * 0.53,
              /* child: Image.asset(
                'assets/images/theme4/subSeaWeedRight2.png',
                gaplessPlayback: true,
              ), */
              child: FadeInImage(
                  fadeInDuration: Duration(milliseconds: fadeInDuration),
                  placeholder: MemoryImage(kTransparentImage),
                  image:
                      AssetImage('assets/images/theme4/subSeaWeedRight2.png')),
            ),
          ),
        ),
        ////////////////////////// Seaweed Sub Right 1
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomRight,
            child: Container(
              margin: EdgeInsets.only(
                  right: deviceWidth * 0.21,
                  bottom: (deviceHeight * 0.26) * 0.76),
              height: deviceHeight > 500
                  ? (deviceHeight * 0.27) * 0.7
                  : (deviceHeight * 0.27) * 0.7,
              /* child: Image.asset(
                'assets/images/theme4/subSeaWeedRight1.png',
                gaplessPlayback: true,
              ), */
              child: FadeInImage(
                  fadeInDuration: Duration(milliseconds: fadeInDuration),
                  placeholder: MemoryImage(kTransparentImage),
                  image:
                      AssetImage('assets/images/theme4/subSeaWeedRight1.png')),
            ),
          ),
        ),
        //////////////////////// Land
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: deviceWidth,
              height: deviceHeight * 0.27,
              /* child: Image.asset(
                'assets/images/theme4/land.png',
                gaplessPlayback: true,
                fit: BoxFit.fill,
              ), */
              child: FittedBox(
                fit: BoxFit.fill,
                child: FadeInImage(
                    fadeInDuration: Duration(milliseconds: fadeInDuration),
                    placeholder: MemoryImage(kTransparentImage),
                    image: AssetImage('assets/images/theme4/land.png')),
              ),
            ),
          ),
        ),
        ////////////////////////// fish pack left
        Positioned.fill(
          child: Align(
            alignment: Alignment.topLeft,
            child: Container(
              margin: EdgeInsets.only(
                  left: deviceWidth * 0.035, top: deviceHeight * 0.11),
              height: deviceHeight > 500
                  ? (deviceHeight * 0.27) * 0.803
                  : (deviceHeight * 0.27) * 1,
              /* child: Image.asset(
                'assets/images/theme4/fishLeft.png',
                gaplessPlayback: true,
              ), */
              child: FadeInImage(
                  fadeInDuration: Duration(milliseconds: fadeInDuration),
                  placeholder: MemoryImage(kTransparentImage),
                  image: AssetImage('assets/images/theme4/fishLeft.png')),
            ),
          ),
        ),
        ////////////////////////// fish pack Right
        Positioned.fill(
          child: Align(
            alignment: Alignment.topRight,
            child: Container(
              margin: EdgeInsets.only(
                  right: deviceWidth * 0.17, top: deviceHeight * 0.22),
              height: deviceHeight > 500
                  ? (deviceHeight * 0.27) * 0.36
                  : (deviceHeight * 0.27) * 0.56,
              /* child: Image.asset(
                'assets/images/theme4/fishRight.png',
                gaplessPlayback: true,
              ), */
              child: FadeInImage(
                  fadeInDuration: Duration(milliseconds: fadeInDuration),
                  placeholder: MemoryImage(kTransparentImage),
                  image: AssetImage('assets/images/theme4/fishRight.png')),
            ),
          ),
        ),
        ////////////////////////// Stingray Center
        Positioned.fill(
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: deviceHeight * 0.22),
              height: deviceHeight > 500
                  ? (deviceHeight * 0.27) * 0.49
                  : (deviceHeight * 0.27) * 0.69,
              /* child: Image.asset(
                'assets/images/theme4/stingray.png',
                gaplessPlayback: true,
              ), */
              child: FadeInImage(
                  fadeInDuration: Duration(milliseconds: fadeInDuration),
                  placeholder: MemoryImage(kTransparentImage),
                  image: AssetImage('assets/images/theme4/stingray.png')),
            ),
          ),
        ),
        ////////////////////////// Stingray Center
        Positioned.fill(
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: deviceHeight > 500
                  ? (deviceHeight * 0.27) * 2.85
                  : (deviceHeight * 0.27) * 2.85,
              /* child: Image.asset(
                'assets/images/theme4/godRay.png',
                gaplessPlayback: true,
              ), */
              child: FadeInImage(
                  fadeInDuration: Duration(milliseconds: fadeInDuration),
                  placeholder: MemoryImage(kTransparentImage),
                  image: AssetImage('assets/images/theme4/godRay.png')),
            ),
          ),
        ),
        ////////////////////////// Seaweed Main left
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              margin: EdgeInsets.only(
                      left: deviceWidth * 0.2, bottom: deviceHeight * 0.22) *
                  0.07,
              height: deviceHeight > 500
                  ? (deviceHeight * 0.27) * 1.11
                  : (deviceHeight * 0.27) * 1.11,
              /* child: Image.asset(
                'assets/images/theme4/seaWeedLeft.png',
                gaplessPlayback: true,
              ), */
              child: FadeInImage(
                  fadeInDuration: Duration(milliseconds: fadeInDuration),
                  placeholder: MemoryImage(kTransparentImage),
                  image: AssetImage('assets/images/theme4/seaWeedLeft.png')),
            ),
          ),
        ),
        ////////////////////////// Seaweed Main Right
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomRight,
            child: Container(
              margin: EdgeInsets.only(bottom: deviceHeight * 0.22) * 0.07,
              height: deviceHeight > 500
                  ? (deviceHeight * 0.27) * 1.65
                  : (deviceHeight * 0.27) * 1.65,
              /* child: Image.asset(
                'assets/images/theme4/seaWeedRight.png',
                gaplessPlayback: true,
              ), */
              child: FadeInImage(
                  fadeInDuration: Duration(milliseconds: fadeInDuration),
                  placeholder: MemoryImage(kTransparentImage),
                  image: AssetImage('assets/images/theme4/seaWeedRight.png')),
            ),
          ),
        ),
        //////////////////////// Bubble
        Positioned.fill(
          child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: deviceWidth,
                height: deviceHeight,
                /* child: Image.asset(
                  'assets/images/theme4/bubble.png',
                  gaplessPlayback: true,
                ), */
                child: FadeInImage(
                    fadeInDuration: Duration(milliseconds: fadeInDuration),
                    placeholder: MemoryImage(kTransparentImage),
                    image: AssetImage('assets/images/theme4/bubble.png')),
              )),
        ),
      ],
    );
  }
}

class Theme3 extends StatelessWidget {
  const Theme3(
      {Key key,
      @required this.deviceWidth,
      @required this.deviceHeight,
      this.fadeInDuration})
      : super(key: key);

  final double deviceWidth;
  final double deviceHeight;
  final int fadeInDuration;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        //////////////////////// PreCache BG
        Container(
          width: deviceWidth,
          height: deviceHeight,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [
                0.1,
                0.5,
                1.0,
              ],
                  colors: [
                Color.fromRGBO(26, 7, 63, 1.0),
                Color.fromRGBO(38, 42, 167, 1.0),
                Color.fromRGBO(47, 156, 188, 1.0),
              ])),
        ),
        //////////////////////// BG
        Container(
          width: deviceWidth,
          height: deviceHeight,
          /* child: Image.asset(
            'assets/images/theme3/bg.png',
            gaplessPlayback: true,
            fit: BoxFit.fill,
          ), */
          child: FittedBox(
            fit: BoxFit.fill,
            child: FadeInImage(
                fadeInDuration: Duration(milliseconds: fadeInDuration),
                placeholder: MemoryImage(kTransparentImage),
                image: AssetImage('assets/images/theme3/bg.png')),
          ),
        ),
        //////////////////////// Left cloud
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              height: deviceHeight * 0.33,
              /* child: Image.asset('assets/images/theme3/cloudLeft.png',
                  gaplessPlayback: true), */
              child: FadeInImage(
                  fadeInDuration: Duration(milliseconds: fadeInDuration),
                  placeholder: MemoryImage(kTransparentImage),
                  image: AssetImage('assets/images/theme3/cloudLeft.png')),
            ),
          ),
        ),
        //////////////////////// Right cloud
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomRight,
            child: Container(
              height: deviceHeight * 0.46,
              /* child: Image.asset('assets/images/theme3/cloudRight.png',
                  gaplessPlayback: true), */
              child: FadeInImage(
                  fadeInDuration: Duration(milliseconds: fadeInDuration),
                  placeholder: MemoryImage(kTransparentImage),
                  image: AssetImage('assets/images/theme3/cloudRight.png')),
            ),
          ),
        ),
        ///////////////////////// Star
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: Container(
                height: deviceHeight,
                /* child: Image.asset(
                'assets/images/theme3/star.png',
                gaplessPlayback: true,
                fit: BoxFit.fill,
              ), */
                child:
                    /* FittedBox(
                fit: BoxFit.fill,
                child: FadeInImage(
                    fadeInDuration: Duration(milliseconds: fadeInDuration),
                    placeholder: MemoryImage(kTransparentImage),
                    image: AssetImage('assets/images/theme3/star.png')),
              ), */
                    Image.asset(
                  'assets/images/theme3/star.png',
                  fit: BoxFit.fill,
                )),
          ),
        ),
        //////////////////////// Star2
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              margin: EdgeInsets.only(
                  left: (deviceWidth * 0.25) * 0.805,
                  bottom: (deviceHeight * 0.33) * 1.17),
              height: (deviceHeight * 0.33) * 0.45,
              /* child: Image.asset('assets/images/theme3/star3.png',
                  gaplessPlayback: true), */
              child: FadeInImage(
                  fadeInDuration: Duration(milliseconds: fadeInDuration),
                  placeholder: MemoryImage(kTransparentImage),
                  image: AssetImage('assets/images/theme3/star3.png')),
            ),
          ),
        ),
        //////////////////////// Moon
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomRight,
            child: Container(
              margin: EdgeInsets.only(
                  right: (deviceWidth * 0.25) * 1.24,
                  bottom: (deviceHeight * 0.33) * 0.5),
              height: (deviceHeight * 0.33) * 0.82,
              /* child: Image.asset('assets/images/theme3/moon.png',
                  gaplessPlayback: true), */
              child: FadeInImage(
                  fadeInDuration: Duration(milliseconds: fadeInDuration),
                  placeholder: MemoryImage(kTransparentImage),
                  image: AssetImage('assets/images/theme3/moon.png')),
            ),
          ),
        ),
        //////////////////////// Rocket
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              margin: EdgeInsets.only(
                  left: deviceHeight > 500
                      ? (deviceWidth * 0.25) * 0.4
                      : (deviceWidth * 0.25) * 0.6,
                  bottom: deviceHeight > 500
                      ? (deviceHeight * 0.33) * 0.063
                      : (deviceHeight * 0.33) * 0.06),
              height: deviceHeight > 500
                  ? (deviceHeight * 0.33) * 0.64
                  : (deviceHeight * 0.33) * 0.64,
              /* child: Image.asset('assets/images/theme3/rocket.png',
                  gaplessPlayback: true), */
              child: FadeInImage(
                  fadeInDuration: Duration(milliseconds: fadeInDuration),
                  placeholder: MemoryImage(kTransparentImage),
                  image: AssetImage('assets/images/theme3/rocket.png')),
            ),
          ),
        ),
        ////////////////////////// UFO
        Positioned.fill(
          child: Align(
            alignment: Alignment.topRight,
            child: Container(
              margin: EdgeInsets.only(
                  right: (deviceWidth * 0.25) * 1.18,
                  top: (deviceHeight * 0.33) * 0.44),
              height: deviceHeight > 500
                  ? (deviceHeight * 0.33) * 0.26
                  : (deviceHeight * 0.33) * 0.46,
              /* child: Image.asset('assets/images/theme3/ufo.png',
                  gaplessPlayback: true), */
              child: FadeInImage(
                  fadeInDuration: Duration(milliseconds: fadeInDuration),
                  placeholder: MemoryImage(kTransparentImage),
                  image: AssetImage('assets/images/theme3/ufo.png')),
            ),
          ),
        ),
      ],
    );
  }
}

///////////////////////////////////////////////////////////// Theme2
class Theme2 extends StatelessWidget {
  const Theme2(
      {Key key,
      @required this.deviceWidth,
      @required this.deviceHeight,
      this.fadeInDuration})
      : super(key: key);

  final double deviceWidth;
  final double deviceHeight;
  final int fadeInDuration;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        //////////////////////// preCache BG
        Container(
          width: deviceWidth,
          height: deviceHeight,
          color: Color.fromRGBO(243, 250, 255, 1.00),
        ),
        //////////////////////// BG
        Container(
          width: deviceWidth,
          /* child: Image.asset(
            'assets/images/theme2/theme2Bg.png',
            gaplessPlayback: true,
            fit: BoxFit.fitWidth,
          ), */
          /* child: FittedBox(
            fit: BoxFit.fitWidth,
            child: FadeInImage(
                fadeInDuration: Duration(milliseconds: fadeInDuration),
                placeholder: MemoryImage(kTransparentImage),
                image: AssetImage('assets/images/theme2/theme2Bg.png')),
          ), */
          child: Image.asset(
            'assets/images/theme2/theme2Bg.png',
            fit: BoxFit.fitWidth,
          ),
        ),

        //////////////////////// Star Top
        Container(
            width: deviceWidth,
            /* child: Image.asset(
            'assets/images/theme2/starTop.png',
            gaplessPlayback: true,
            fit: BoxFit.fitWidth,
          ), */
            child:
                /* FittedBox(
            fit: BoxFit.fitWidth,
            child: FadeInImage(
                fadeInDuration: Duration(milliseconds: fadeInDuration),
                placeholder: MemoryImage(kTransparentImage),
                image: AssetImage('assets/images/theme2/starTop.png')),
          ), */
                Image.asset(
              'assets/images/theme2/starTop.png',
              fit: BoxFit.fitWidth,
            )),
        //////////////////////// Star Low
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                width: deviceWidth,
                /* child: Image.asset(
                'assets/images/theme2/starLow.png',
                gaplessPlayback: true,
                fit: BoxFit.fitWidth,
              ), */
                child:
                    /* FittedBox(
                fit: BoxFit.fitWidth,
                child: FadeInImage(
                    fadeInDuration: Duration(milliseconds: fadeInDuration),
                    placeholder: MemoryImage(kTransparentImage),
                    image: AssetImage('assets/images/theme2/starLow.png')),
              ),
            ), */
                    Image.asset(
                  'assets/images/theme2/starLow.png',
                  fit: BoxFit.fitWidth,
                )),
          ),
        ),

        //////////////////////// Monitor

        Positioned.fill(
          child: Align(
            alignment: Alignment.topCenter,
            child: Stack(
              children: <Widget>[
                Container(
                  //alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(
                    top: deviceHeight > 500
                        ? ((deviceHeight * 0.026 +
                                    ((deviceHeight * 0.134) * 0.27)) *
                                2) +
                            deviceWidth * 0.075
                        : ((deviceHeight * 0.036 +
                                    ((deviceHeight * 0.134) * 0.27)) *
                                2) +
                            deviceWidth * 0.065,
                    /* top: deviceHeight > 500
            ? deviceHeight * 0.235
            : deviceHeight * 0.26 */
                  ),
                  width: deviceHeight > 500 ? deviceWidth : deviceWidth * 0.87,
                  height: deviceHeight > 500
                      ? deviceHeight * 0.66
                      : deviceHeight * 0.7,
                  /* child: Image.asset(
                    'assets/images/theme2/monitor.png',
                    gaplessPlayback: true,
                    fit: BoxFit.fill,
                  ), */
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: FadeInImage(
                        fadeInDuration: Duration(milliseconds: fadeInDuration),
                        placeholder: MemoryImage(kTransparentImage),
                        image: AssetImage('assets/images/theme2/monitor.png')),
                  ),
                ),
                ///////////////////////////// heart
                Container(
                  alignment: Alignment.bottomRight,
                  margin: EdgeInsets.only(
                    top: deviceHeight > 500
                        ? ((deviceHeight * 0.026 +
                                    ((deviceHeight * 0.134) * 0.27)) *
                                2) +
                            deviceWidth * 0.075
                        : ((deviceHeight * 0.036 +
                                    ((deviceHeight * 0.134) * 0.27)) *
                                2) +
                            deviceWidth * 0.065,
                  ),
                  width: deviceHeight > 500 ? deviceWidth : deviceWidth * 0.87,
                  height: deviceHeight > 500
                      ? deviceHeight * 0.66
                      : deviceHeight * 0.7,
                  child: Container(
                    margin: EdgeInsets.only(
                        top: deviceHeight > 500
                            ? (deviceHeight * 0.66) * 0.38
                            : (deviceHeight * 0.7) * 0.38,
                        bottom: deviceHeight > 500
                            ? (deviceHeight * 0.66) * 0.145
                            : (deviceHeight * 0.7) * 0.145,
                        right: deviceHeight > 500
                            ? (deviceWidth) * 0.01
                            : (deviceWidth * 0.87) * 0.01),
                    /* child: Image.asset(
                      'assets/images/theme2/starnHeart.png',
                      gaplessPlayback: true,
                    ), */

                    child: FadeInImage(
                        fadeInDuration: Duration(milliseconds: fadeInDuration),
                        placeholder: MemoryImage(kTransparentImage),
                        image:
                            AssetImage('assets/images/theme2/starnHeart.png')),
                  ),
                ),
                ////////////////////////////////////// Picker
                Container(
                  alignment: Alignment.topRight,
                  margin: EdgeInsets.only(
                    top: deviceHeight > 500
                        ? ((deviceHeight * 0.026 +
                                    ((deviceHeight * 0.134) * 0.27)) *
                                2) +
                            deviceWidth * 0.075
                        : ((deviceHeight * 0.036 +
                                    ((deviceHeight * 0.134) * 0.27)) *
                                2) +
                            deviceWidth * 0.065,
                  ),
                  width: deviceHeight > 500 ? deviceWidth : deviceWidth * 0.87,
                  height: deviceHeight > 500
                      ? deviceHeight * 0.66
                      : deviceHeight * 0.7,
                  child: Container(
                    margin: EdgeInsets.only(
                        top: deviceHeight > 500
                            ? (deviceHeight * 0.66) * 0.055
                            : (deviceHeight * 0.7) * 0.055,
                        bottom: deviceHeight > 500
                            ? (deviceHeight * 0.66) * 0.553
                            : (deviceHeight * 0.7) * 0.553,
                        right: deviceHeight > 500
                            ? (deviceWidth) * 0.1
                            : (deviceWidth * 0.87) * 0.1),
                    /*  child: Image.asset(
                      'assets/images/theme2/keep.png',
                      gaplessPlayback: true,
                    ), */
                    child: FadeInImage(
                        fadeInDuration: Duration(milliseconds: fadeInDuration),
                        placeholder: MemoryImage(kTransparentImage),
                        image: AssetImage('assets/images/theme2/keep.png')),
                  ),
                ),
                ///////////////////////////////////////// Mornitor Btn
                Container(
                  alignment: Alignment.bottomLeft,
                  margin: EdgeInsets.only(
                    top: deviceHeight > 500
                        ? ((deviceHeight * 0.026 +
                                    ((deviceHeight * 0.134) * 0.27)) *
                                2) +
                            deviceWidth * 0.075
                        : ((deviceHeight * 0.036 +
                                    ((deviceHeight * 0.134) * 0.27)) *
                                2) +
                            deviceWidth * 0.065,
                  ),
                  width: deviceHeight > 500 ? deviceWidth : deviceWidth * 0.87,
                  height: deviceHeight > 500
                      ? deviceHeight * 0.66
                      : deviceHeight * 0.7,
                  child: Container(
                    margin: EdgeInsets.only(
                        top: deviceHeight > 500
                            ? (deviceHeight * 0.66) * 0.9
                            : (deviceHeight * 0.7) * 0.9,
                        bottom: deviceHeight > 500
                            ? (deviceHeight * 0.66) * 0.03
                            : (deviceHeight * 0.7) * 0.03,
                        left: deviceHeight > 500
                            ? (deviceWidth) * 0.022
                            : (deviceWidth * 0.87) * 0.022),
                    /* child: Image.asset('assets/images/theme2/monitorBtn.png',
                        gaplessPlayback: true), */
                    child: FadeInImage(
                        fadeInDuration: Duration(milliseconds: fadeInDuration),
                        placeholder: MemoryImage(kTransparentImage),
                        image:
                            AssetImage('assets/images/theme2/monitorBtn.png')),
                  ),
                ),
              ],
            ),
          ),
        ),
        /////////////////////////////////////// Controller pad
        Positioned.fill(
          child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: deviceHeight > 500
                    ? (deviceHeight * 0.66) * 0.23
                    : (deviceHeight * 0.7) * 0,
                /* child: Image.asset('assets/images/theme2/controlPad.png',
                    gaplessPlayback: true), */
                child: FadeInImage(
                    fadeInDuration: Duration(milliseconds: fadeInDuration),
                    placeholder: MemoryImage(kTransparentImage),
                    image: AssetImage('assets/images/theme2/controlPad.png')),
              )),
        ),
      ],
    );
  }
}

///////////////////////////////////////////////////////////// Theme1
class Theme1 extends StatelessWidget {
  const Theme1(
      {Key key,
      @required this.deviceWidth,
      @required this.deviceHeight,
      this.fadeInDuration})
      : super(key: key);

  final double deviceWidth;
  final double deviceHeight;
  final int fadeInDuration;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        //////////////////////// BG
        Container(
          width: deviceWidth,
          height: deviceWidth,
          color: Color.fromRGBO(255, 249, 232, 1.00),
        ),

        //////////////////////// BlackBoard
        Positioned.fill(
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(
                top: deviceHeight > 500
                    ? ((deviceHeight * 0.026 +
                                ((deviceHeight * 0.134) * 0.27)) *
                            2) +
                        deviceWidth * 0.075
                    : ((deviceHeight * 0.036 +
                                ((deviceHeight * 0.134) * 0.27)) *
                            2) +
                        deviceWidth * 0.065,
                /* top: deviceHeight > 500
        ? deviceHeight * 0.235
        : deviceHeight * 0.26 */
              ),
              width: deviceHeight > 500 ? deviceWidth : deviceWidth * 0.87,
              height:
                  deviceHeight > 500 ? deviceHeight * 0.6 : deviceHeight * 0.7,
              /* child: Image.asset(
                'assets/images/theme1/blackBoard.png',
                fit: BoxFit.fill,
                gaplessPlayback: true,
              ), */
              child: FittedBox(
                  fit: BoxFit.fill,
                  child:
                      /* FadeInImage(
                    fadeInDuration: Duration(milliseconds: fadeInDuration),
                    placeholder: MemoryImage(kTransparentImage),
                    image: AssetImage('assets/images/theme1/blackBoard.png')), */
                      Image.asset('assets/images/theme1/blackBoard.png')),
            ),
          ),
        ),

        //////////////////////// Plant
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Container(
                margin: EdgeInsets.only(
                    left: deviceHeight > 500
                        ? deviceWidth * 0.015
                        : deviceWidth * 0.012),
                height: deviceHeight > 500
                    ? deviceHeight * 0.22
                    : deviceHeight * 0.22,
                /* child: Image.asset('assets/images/theme1/plant.png',
                  gaplessPlayback: true), */
                child:
                    /* FadeInImage(
                  fadeInDuration: Duration(milliseconds: fadeInDuration),
                  placeholder: MemoryImage(kTransparentImage),
                  image: AssetImage('assets/images/theme1/plant.png')), */
                    Image.asset('assets/images/theme1/plant.png')),
          ),
        ),

        ///////////////////////// Desk
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomRight,
            child: Container(
                height: deviceHeight > 500
                    ? deviceHeight * 0.097
                    : deviceHeight * 0.097,
                /* child: Image.asset(
                'assets/images/theme1/desk.png',
                gaplessPlayback: true,
                fit: BoxFit.fill,
              ), */
                /* child: FittedBox(
                fit: BoxFit.fill, */
                child:
                    /* FadeInImage(
                  fadeInDuration: Duration(milliseconds: fadeInDuration),
                  placeholder: MemoryImage(kTransparentImage),
                  image: AssetImage('assets/images/theme1/desk.png')), */
                    Image.asset('assets/images/theme1/desk.png')
                //),
                ),
          ),
        ),
      ],
    );
  }
}
