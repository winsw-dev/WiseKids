import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:transparent_image/transparent_image.dart';
import 'package:flare_flutter/flare.dart';
import 'package:flare_flutter/flare_cache.dart';
import 'package:flare_flutter/flare_controls.dart';

import 'package:flare_flutter/flare_actor.dart';

import '../widget/slide_popup_dialog_warning.dart' as warningDialog;
import './play.dart';

import 'package:provider/provider.dart';
import '../provider/dataProvider.dart';
import 'home.dart';
import 'unityArBook.dart';
import '../screen/stickerCollected.dart';

class EnterBook extends StatefulWidget {
  final int pickedBook;
  EnterBook({@required this.pickedBook});

  @override
  _EnterBookState createState() => _EnterBookState();
}

class _EnterBookState extends State<EnterBook> {
  List<String> enterBookThemeBg = [
    'assets/images/enterBook/enterBookTheme1.png',
    'assets/images/enterBook/enterBookTheme2.png',
    'assets/images/enterBook/enterBookTheme3.png',
    'assets/images/enterBook/enterBookTheme4.png',
    'assets/images/enterBook/enterBookTheme5.png',
  ];

  List<String> bookCoverImage = [
    'assets/images/enterBook/book2.png',
    'assets/images/enterBook/book3.png',
    'assets/images/enterBook/book4.png',
    'assets/images/enterBook/book5.png',
    'assets/images/enterBook/book6.png',
    'assets/images/enterBook/book7.png',
    'assets/images/enterBook/book1.png',
  ];

  Image bookImage; // it doesn't help flashing image problem in this scenario
  @override // it doesn't help flashing image problem in this scenario
  void initState() {
    super.initState();

    bookImage = Image.asset(
      'assets/images/enterBook/book1.png',
      fit: BoxFit.contain,
    );
  }

  @override // it doesn't help flashing image problem in this scenario
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(bookImage.image, context);
  }

  var fadeInDuration = 100;

  void _showWarningDialog() {
    warningDialog.showSlideDialog(
      context: context,
      child: Container(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      ////////////////////// avoid bottom notch pading
      resizeToAvoidBottomPadding: false,
      body: Stack(
        children: <Widget>[
          //////////////////////////////////////  Enter Book Theme Bg
          Consumer<DataProvider>(builder: (context, theme, child) {
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
          }),

          Container(
            height: deviceHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                widget.pickedBook == 6 ? Container() : Spacer(),
                Spacer(),
                Spacer(),
                ///////////////////////////// Book Pic
                Hero(
                  tag: 'book' + widget.pickedBook.toString(),
                  child: Container(
                      height: deviceHeight > 500
                          ? deviceHeight * 0.66
                          : deviceHeight * 0.75,
                      child: AspectRatio(
                        aspectRatio: 1251 / 1620,
                        child: Image.asset(
                          bookCoverImage[widget.pickedBook],
                          fit: BoxFit.contain,
                        )
                        /* Image.asset(
                      'assets/images/enterBook/book1.png',
                      //fit: BoxFit.fitHeight,
                    ) */
                        ,
                      )),
                ),

                /////////////////////////////////// Column Btn
                Spacer(),
                Container(
                  /*  margin: EdgeInsets.only(
                      left: deviceHeight > 500
                          ? deviceWidth * (119 / 1024)
                          : deviceWidth * (119 / 1024)), */
                  /*  height: deviceHeight > 500
                      ? deviceHeight * 0.66
                      : deviceHeight * 0.66, */
                  child: widget.pickedBook == 6
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            /////////////////// read Btn
                            GestureDetector(
                              ////// debug StickerCollected page
                              onLongPress:
                                  !bool.fromEnvironment("dart.vm.product")
                                      ? () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  StickerCollected(),
                                            ),
                                          );
                                        }
                                      : null,

                              onTap: () {
                                ////////////////////////////////////////////////// Navigate to AR
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UnityARBook(),
                                  ),
                                );
                              },
                              child: Container(
                                height: deviceHeight > 500
                                    ? deviceHeight * (121 / 768)
                                    : deviceHeight * (170 / 768),
                                child: AspectRatio(
                                  aspectRatio: 268 / 121,
                                  child: FlareActor(
                                      "assets/animation/btnAnimation.flr",
                                      artboard: 'ReadBtn',
                                      animation: 'animation'),

                                  /*  Stack(
                                    children: <Widget>[
                                      AspectRatio(
                                        aspectRatio: 216 / 93,
                                        child: SvgPicture.asset(
                                          'assets/images/enterBook/readBtn.svg',
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      ////////////////////// Text Read
                                      Positioned.fill(
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Container(
                                            height: deviceHeight > 500
                                                ? deviceHeight * 0.121
                                                : deviceHeight * 0.2,
                                            child: FractionallySizedBox(
                                              heightFactor: 0.46,
                                              child: FittedBox(
                                                fit: BoxFit.fitHeight,
                                                child: Text(
                                                  'Read',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'NunitoExtraBold',
                                                      fontSize:
                                                          deviceHeight > 500
                                                              ? 30
                                                              : 15,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ), */
                                ),
                              ),
                            ),
                            /////////////////// spacer
                            SizedBox(
                                height: deviceHeight > 500
                                    ? deviceHeight * 0.055 -
                                        (deviceHeight * 28 / 768)
                                    : deviceHeight * 0.08 -
                                        (deviceHeight * 28 / 768)),
                            /////////////////// play Btn

                            Provider.of<DataProvider>(context, listen: false)
                                        .bookStatistic[
                                            Provider.of<DataProvider>(context,
                                                    listen: false)
                                                .currentKids]['readBook']
                                        .length >
                                    0
                                ? GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              //StickerCollected(),
                                              Play(),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: deviceHeight > 500
                                          ? deviceHeight * (121 / 768)
                                          : deviceHeight * (170 / 768),
                                      child: AspectRatio(
                                        aspectRatio: 268 / 121,
                                        child: FlareActor(
                                            "assets/animation/btnAnimation.flr",
                                            artboard: 'PlayBtn',
                                            animation: 'animation'),
                                        /* height: deviceHeight > 500
                                          ? deviceHeight * 0.121
                                          : deviceHeight * 0.2,
                                      child: AspectRatio(
                                        aspectRatio: 216 / 93,
                                        child: Stack(
                                          children: <Widget>[
                                            AspectRatio(
                                              aspectRatio: 216 / 93,
                                              child: SvgPicture.asset(
                                                'assets/images/enterBook/playBtn.svg',
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            ////////////////////// Text Play
                                            Positioned.fill(
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Container(
                                                  height: deviceHeight > 500
                                                      ? deviceHeight * 0.121
                                                      : deviceHeight * 0.2,
                                                  child: FractionallySizedBox(
                                                    heightFactor: 0.46,
                                                    child: FittedBox(
                                                      fit: BoxFit.fitHeight,
                                                      child: Text(
                                                        'Play',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'NunitoExtraBold',
                                                            fontSize:
                                                                deviceHeight >
                                                                        500
                                                                    ? 30
                                                                    : 15,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),*/
                                      ),
                                    ),
                                  )
                                : Container()
                            /* ///////////////////////////////// Play Btn Disable
                          Container(
                              child: Stack(
                                children: <Widget>[
                                  Material(
                                    color: Colors.transparent,
                                    child: Ink(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(500),
                                        color:
                                            Color.fromRGBO(237, 237, 243, 1.00),
                                      ),
                                      child: InkWell(
                                        borderRadius:
                                            BorderRadius.circular(500),
                                        onTap: () {
                                          print('play mode still locked');
                                        },
                                        child: Container(
                                          height: deviceHeight > 500
                                              ? deviceHeight * 0.121
                                              : deviceHeight * 0.2,
                                          child: AspectRatio(
                                              aspectRatio: 216 / 93),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned.fill(
                                      child: Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      child: FractionallySizedBox(
                                        heightFactor: 0.46,
                                        child: FittedBox(
                                          fit: BoxFit.fitHeight,
                                          child: Text(
                                            "Play",
                                            style: TextStyle(
                                                fontFamily: 'NunitoExtraBold',
                                                color: Color.fromRGBO(
                                                    160, 163, 168, 1.00)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )),
                                ],
                              ),
                            ), */
                            ////////////////////////////////////////////////////////////
                          ],
                          ////////////////////////////////////////////////////////// Locked Book
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Spacer(),
                            //////////////////////////////////////////// Balloon
                            Container(
                              height: deviceHeight > 500
                                  ? deviceHeight * 0.121 * (125 / 93)
                                  : deviceHeight * 0.2 * (125 / 93),
                              child: Image.asset(
                                  'assets/images/enterBook/balloon.png'),
                            ),
                            ////////////////////////////////////////////
                            Container(
                              height: deviceHeight > 500
                                  ? deviceHeight * 0.121 * (169 / 93) +
                                      ((deviceHeight * 0.121) / 2)
                                  : deviceHeight * 0.2 * (169 / 93) +
                                      ((deviceHeight * 0.2) / 2),
                              child: AspectRatio(
                                aspectRatio: 307 / 215.5,
                                child: Stack(
                                  children: <Widget>[
                                    ////////////////////////////////////// white Box
                                    Positioned.fill(
                                      child: Align(
                                        alignment: Alignment.topCenter,
                                        child: Container(
                                          height: deviceHeight > 500
                                              ? deviceHeight *
                                                  0.121 *
                                                  (169 / 93)
                                              : deviceHeight * 0.2 * (169 / 93),
                                          decoration: new BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(24),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color.fromRGBO(
                                                    0, 0, 0, 0.16),
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
                                          child: AspectRatio(
                                            aspectRatio: 307 / 169,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                bottom: deviceHeight > 500
                                                    ? (deviceHeight * 0.121) / 2
                                                    : (deviceHeight * 0.2) / 2,
                                                top: deviceHeight > 500
                                                    ? (deviceHeight * 0.121) *
                                                        (7 / 93)
                                                    : (deviceHeight * 0.2) *
                                                        (7 / 93),
                                              ),
                                              child: Column(
                                                children: <Widget>[
                                                  Spacer(),
                                                  Container(
                                                    height: deviceHeight > 500
                                                        ? (deviceHeight *
                                                                0.121) *
                                                            (68 / 93)
                                                        : (deviceHeight * 0.2) *
                                                            (68 / 93),
                                                    child: FittedBox(
                                                      fit: BoxFit.contain,
                                                      child: Text(
                                                        'Use 3 stars\nto unlock this book',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'NunitoBold',
                                                            color:
                                                                Color.fromRGBO(
                                                                    251,
                                                                    71,
                                                                    149,
                                                                    1.0)),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  //Spacer(),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    //////////////////////////////////////////// Unlock Btn
                                    Positioned.fill(
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: GestureDetector(
                                          onTap: () {
                                            _showWarningDialog();
                                          },
                                          child: Container(
                                            height: deviceHeight > 500
                                                ? deviceHeight * (121 / 768)
                                                : deviceHeight * (170 / 768),
                                            /* height: deviceHeight > 500
                                                ? deviceHeight * 0.121
                                                : deviceHeight * 0.2, */
                                            child: AspectRatio(
                                              aspectRatio: 216 / 93,
                                              child: FlareActor(
                                                  "assets/animation/btnAnimation.flr",
                                                  artboard: 'UnlockBookBtn',
                                                  animation: 'animation'),
                                              /* Stack(
                                                children: <Widget>[
                                                  AspectRatio(
                                                    aspectRatio: 216 / 93,
                                                    child: SvgPicture.asset(as
                                                      'assets/images/enterBook/playBtn.svg',
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                  ////////////////////// Text Play
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      ////////////////////////////// Star Icon
                                                      Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                            right: deviceHeight >
                                                                    500
                                                                ? deviceHeight *
                                                                    0.121 *
                                                                    (20 / 93)
                                                                : deviceHeight *
                                                                    0.2 *
                                                                    (20 / 93),
                                                          ),
                                                          height: deviceHeight >
                                                                  500
                                                              ? deviceHeight *
                                                                  0.121 *
                                                                  (38 / 93)
                                                              : deviceHeight *
                                                                  0.2 *
                                                                  (38 / 93),
                                                          child: Image.asset(
                                                            'assets/images/enterBook/star.png',
                                                            fit: BoxFit.contain,
                                                          )),
                                                      ////////////////////////////// 3 Text
                                                      Container(
                                                        height:
                                                            deviceHeight > 500
                                                                ? deviceHeight *
                                                                    0.121
                                                                : deviceHeight *
                                                                    0.2,
                                                        child:
                                                            FractionallySizedBox(
                                                          heightFactor: 0.46,
                                                          child: FittedBox(
                                                            fit: BoxFit
                                                                .fitHeight,
                                                            child: Text(
                                                              '3',
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'NunitoExtraBold',
                                                                  fontSize:
                                                                      deviceHeight >
                                                                              500
                                                                          ? 30
                                                                          : 15,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ), */
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                ),
                widget.pickedBook == 6 ? Container() : Spacer(),
                Spacer(),
                Spacer(),
              ],
            ),
          ),

          /* ///////////////////////////////////////////  Row of Book and Btn
          Container(
            margin: EdgeInsets.only(
                top: deviceHeight > 500
                    ? deviceHeight * 0.18
                    : deviceHeight * 0.18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ///////////////////////////////////Book Preview
                Container(
                  height: deviceHeight > 500
                      ? deviceHeight * 0.66
                      : deviceHeight * 0.66,
                  child: Image.asset(
                    'assets/images/enterBook/book1.png',
                    fit: BoxFit.fitHeight,
                  ),
                ),
                /////////////////////////////////// Column Btn
                Container(
                  margin: EdgeInsets.only(
                      left: deviceHeight > 500
                          ? deviceWidth * 0.12
                          : deviceWidth * 0.12),
                  height: deviceHeight > 500
                      ? deviceHeight * 0.66
                      : deviceHeight * 0.66,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      /////////////////// read Btn
                      GestureDetector(
                        onTap: () {
                          ////////////////////////////////////////////////// Navigate to AR
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UnityARBook(),
                            ),
                          );
                        },
                        child: Container(
                          child: Stack(
                            children: <Widget>[
                              Container(
                                height: deviceHeight > 500
                                ? deviceHeight * 0.121
                                : deviceHeight * 0.2,
                                child: SvgPicture.asset(
                                    'assets/images/enterBook/readBtn.svg'),
                              ),
                              ////////////////////// Text Read
                              Positioned.fill(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    child: Text(
                                      'Read',
                                      style: TextStyle(
                                          fontFamily: 'NunitoExtraBold',
                                          fontSize:
                                              deviceHeight > 500 ? 30 : 15,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      /////////////////// spacer
                      SizedBox(
                          height: deviceHeight > 500
                              ? deviceHeight * 0.055
                              : deviceHeight * 0.055),
                      /////////////////// play Btn
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Play(),
                            ),
                          );
                        },
                        child: Stack(
                          children: <Widget>[
                            Container(
                              height: deviceHeight > 500
                                ? deviceHeight * 0.121
                                : deviceHeight * 0.2,
                              child: SvgPicture.asset(
                                  'assets/images/enterBook/playBtn.svg'),
                            ),
                            ////////////////////// Text Play
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  child: Text(
                                    'Play',
                                    style: TextStyle(
                                        fontFamily: 'NunitoExtraBold',
                                        fontSize: deviceHeight > 500 ? 30 : 15,
                                        color: Colors.white),
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
              ],
            ),
          ),
          ////////////////////////////// Wink Animation
          Positioned.fill(
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: deviceHeight > 500
                    ? deviceWidth * 0.59
                    : deviceWidth * 0.59,
                child:
                    FlareActor("assets/animation/wink.flr", animation: 'wink'),
              ),
            ),
          ), */
          ////////////////////////////// Wink Animation
          Positioned.fill(
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: deviceHeight > 500
                    ? deviceWidth * 0.59
                    : deviceWidth * 0.59,
                child:
                    FlareActor("assets/animation/wink.flr", animation: 'wink'),
              ),
            ),
          ),
          ////////////////////////////////////// Go Home Btn
          GestureDetector(
            onTap: () {
              Navigator.pop(
                context,
                MaterialPageRoute(
                  builder: (context) => Home(),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.only(
                top: deviceHeight > 500
                    ? deviceWidth * 0.02
                    : deviceWidth * 0.02,
                left: deviceHeight > 500
                    ? deviceWidth * 0.02
                    : deviceWidth * 0.02,
              ),
              height: deviceHeight > 500
                  ? deviceHeight * 0.104
                  : deviceHeight * 0.17,
              child: Image.asset('assets/images/enterBook/homeBtn.png'),
            ),
          ),
        ],
      ),
    );
  }
}

//////////////////////////////////////////////////////
////////////////////////////////////////////////////// Theme Class
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
                      ? deviceWidth * 0.33
                      : deviceWidth * 0.42,
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
        /* Positioned.fill(
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
        ), */
        ////////////////////////// Stingray Center
        Positioned.fill(
          child: Align(
            alignment: Alignment.topRight,
            child: Container(
              margin: EdgeInsets.only(
                  top: deviceHeight * 0.1, right: deviceHeight * 0.1),
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
        ////////////////////////// God ray
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
            alignment: Alignment.topRight,
            child: Container(
              margin: EdgeInsets.only(
                  right: (deviceWidth * 0.25) * 0,
                  top: (deviceHeight * 0.33) * 0.1),
              height: (deviceHeight * 0.33) * 0.9,
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
        /*  Positioned.fill(
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
        ), */
        ////////////////////////// UFO
        Positioned.fill(
          child: Align(
            alignment: Alignment.topLeft,
            child: Container(
              margin: EdgeInsets.only(
                  left: (deviceWidth * 0.25) * 0.05,
                  top: (deviceHeight * 0.33) * 1.6),
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

        /* //////////////////////// Monitor

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
        ), */
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
        /////////////////////// Pattern
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: deviceHeight * 0.358 + deviceHeight * 0.2,
              child: Image.asset(
                'assets/images/theme1/pattern.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),

        /////////////////////// Floor
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: deviceHeight * 0.358,
              width: deviceWidth,
              child: FittedBox(
                  fit: BoxFit.fill,
                  child: Image.asset(
                      'assets/images/selectAvatarAssets/floor.png')),
            ),
          ),
        ),

        //////////////////////// BlackBoard
        /*  Positioned.fill(
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
        ), */

        //////////////////////// Plant
        /* Positioned.fill(
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
        ), */
      ],
    );
  }
}
