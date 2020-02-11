import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flare_flutter/flare_actor.dart';

import '../screen/home.dart';

import 'package:provider/provider.dart';
import '../screen/play.dart';
import '../provider/dataProvider.dart';

class SlideDialogRead extends StatefulWidget {
  final Widget child;

  SlideDialogRead({
    @required this.child,
  });

  @override
  _SlideDialogReadState createState() => _SlideDialogReadState();
}

class _SlideDialogReadState extends State<SlideDialogRead> {
  var _initialPosition = 0.0;
  var _currentPosition = 0.0;

  var avatarSwipeController = new SwiperController();

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
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: <Widget>[
              Container(
                width: deviceWidth,
                height: deviceHeight,
                  child: FlareActor("assets/animation/balloon.flr",
                      animation: 'balloon')),
              Center(
                child: Stack(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        /////////////////////////////////////////////// dialog Bg
                        Container(
                            margin: EdgeInsets.only(
                                top: deviceHeight > 500
                                    ? deviceHeight * 0.07
                                    : deviceHeight * 0.094),
                            width: deviceHeight > 500
                                ? deviceWidth * 0.52
                                : deviceWidth * 0.5,
                            height: deviceHeight > 500
                                ? deviceHeight * 0.502
                                : deviceHeight * 0.402,
                            child: Image.asset(
                                'assets/images/readDialog/dialogBgFix.png')),

                        //////////////////////////////////////// Row of text and star score
                        Container(
                          width: deviceHeight > 500
                              ? deviceWidth * 0.52
                              : deviceWidth * 0.5,
                          height: deviceHeight > 500
                              ? deviceHeight * 0.496
                              : deviceHeight * 0.496,
                          child: Column(
                            //mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              //////////////////// What's next
                              Container(
                                margin: EdgeInsets.only(
                                    top: deviceHeight > 500
                                        ? deviceHeight * 0.185
                                        : deviceHeight * 0.203),
                                child: Text(
                                  'What\'s Next',
                                  style: TextStyle(
                                      fontFamily: 'NunitoExtraBold',
                                      fontSize: deviceHeight > 500 ? 56 : 56,
                                      color: Colors.white),
                                ),
                              ),
                              ///////////////////// Keep working on it, You are improving.
                              Container(
                                /* margin: EdgeInsets.only(
                                top: deviceHeight > 500
                                    ? deviceHeight * 0.000
                                    : deviceHeight * 0.013), */
                                child: Text(
                                  'Keep working on it, You are improving.',
                                  style: TextStyle(
                                      fontFamily: 'NunitoRegular',
                                      fontSize: deviceHeight > 500 ? 25 : 25,
                                      color: Colors.white),
                                ),
                              ),
                              ////////////////////// Star Score Slot
                              Container(
                                margin: EdgeInsets.only(
                                    top: deviceHeight > 500
                                        ? deviceHeight * 0.033
                                        : deviceHeight * 0.033),
                                child: Stack(
                                  children: <Widget>[
                                    Container(
                                      width: deviceHeight > 500
                                          ? deviceWidth * 0.14
                                          : deviceWidth * 0.14,
                                      height: deviceHeight > 500
                                          ? deviceHeight * 0.08
                                          : deviceHeight * 0.06,
                                      child: Image.asset(
                                        'assets/images/readDialog/starScoreSlot.png',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Positioned.fill(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              /////////////////////////// star score text
                                              Container(
                                                child: Text(
                                                  '3',
                                                  style: TextStyle(
                                                      fontFamily: 'NunitoBold',
                                                      fontSize:
                                                          deviceHeight > 500
                                                              ? 30
                                                              : 25,
                                                      color: Colors.white),
                                                ),
                                              ),
                                              /////////////////////////// spacer
                                              SizedBox(
                                                width: deviceHeight > 500
                                                    ? deviceWidth * 0.013
                                                    : deviceWidth * 0.011,
                                              ),
                                              /////////////////////////// star score icon
                                              Container(
                                                height: deviceHeight > 500
                                                    ? deviceHeight * 0.044
                                                    : deviceHeight * 0.044,
                                                child: SvgPicture.asset(
                                                    'assets/images/readDialog/starScore.svg'),
                                              )
                                            ],
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

                    //////////////////////////////// //////// 3 Star
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          margin: EdgeInsets.only(top: 10),
                          height: deviceHeight > 500
                              ? deviceHeight * 0.17
                              : deviceHeight * 0.17,
                          child:
                              Image.asset('assets/images/readDialog/3star.png'),
                        ),
                      ),
                    ),

                    ////////////////////////////////////////// Btn
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          margin: EdgeInsets.only(
                              top: deviceHeight > 500
                                  ? deviceHeight * 0.443
                                  : deviceHeight * 0.443),
                          child: Wrap(
                            children: <Widget>[
                              ///////////////////////  Read
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                  return;
                                },
                                child: Container(
                                  child: Stack(
                                    children: <Widget>[
                                      Container(
                                        height: deviceHeight > 500
                                            ? deviceHeight * 0.12
                                            : deviceHeight * 0.12,
                                        child: SvgPicture.asset(
                                            'assets/images/enterBook/readBtn.svg'),
                                      ),
                                      /////////////// text
                                      Positioned.fill(
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Container(
                                            child: Text(
                                              'Read again',
                                              style: TextStyle(
                                                  fontFamily: 'NunitoExtraBold',
                                                  fontSize: deviceHeight > 500
                                                      ? 30
                                                      : 25,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              /////////////////////// Spacer
                              SizedBox(
                                width: deviceHeight > 500
                                    ? deviceWidth * 0.03
                                    : deviceWidth * 0.03,
                              ),
                              ///////////////////////  Play
                              GestureDetector(onTap: (){
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Play(),
                                    ),
                                  );
                              },
                                                              child: Container(
                                  child: Stack(
                                    children: <Widget>[
                                      Container(
                                        height: deviceHeight > 500
                                            ? deviceHeight * 0.12
                                            : deviceHeight * 0.12,
                                        child: SvgPicture.asset(
                                            'assets/images/enterBook/playBtn.svg'),
                                      ),
                                      /////////////// text
                                      Positioned.fill(
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Container(
                                            child: Text(
                                              'Play',
                                              style: TextStyle(
                                                  fontFamily: 'NunitoExtraBold',
                                                  fontSize:
                                                      deviceHeight > 500 ? 30 : 25,
                                                  color: Colors.white),
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
                        ),
                      ),
                    ),
                    //////////////////////////////////////////// Close Btn
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: () {
                             Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Home(),
                                    ),
                                  );
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 75),
                            child: SvgPicture.asset(
                                'assets/images/readDialog/closeBtn.svg'),
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
