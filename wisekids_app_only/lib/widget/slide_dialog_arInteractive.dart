import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flare_flutter/flare_actor.dart';

class SlideDialogArInteractive extends StatefulWidget {
  final Widget child;

  SlideDialogArInteractive({
    @required this.child,
  });

  @override
  _SlideDialogArInteractiveState createState() =>
      _SlideDialogArInteractiveState();
}

class _SlideDialogArInteractiveState extends State<SlideDialogArInteractive> {
  //var _initialPosition = 0.0;
  var _currentPosition = 0.0;

  //////////////////////////////////////// monster variable
  bool monster1Glow = false;
  bool monster2Glow = false;
  bool monster3Glow = false;
  bool monster4Glow = false;
  bool monster5Glow = false;
  bool monster6Glow = false;
  bool monster7Glow = false;
  bool monster8Glow = false;
  bool monster9Glow = false;
  bool monster10Glow = false;

  double monster1Opacity = 1.0;
  double monster2Opacity = 1.0;
  double monster3Opacity = 1.0;
  double monster4Opacity = 1.0;
  double monster5Opacity = 1.0;
  double monster6Opacity = 1.0;
  double monster7Opacity = 1.0;
  double monster8Opacity = 1.0;
  double monster9Opacity = 1.0;
  double monster10Opacity = 1.0;

  int fadeDelay = 250; //millisecond
  int fadeDuration = 500; //millisecond

  String numberVocab = 'ONE !';
  double fadeTextOpacity = 0.0;
  int fadeTextDuration = 0;
  int touchLockIndex = 1;
  int textNumberCount = 1;

  int fadeExcellenceDuration = 0;
  int fadeMonsterGoneDuration = 0;
  double fadeExcellenceOpacity = 0.0;
  double fadeMonsterGoneOpacity = 0.0;

  bool animationController = false;

  int fadeBlackBGDuration = 0;
  double fadeBlackBGOpacity = 0.0;

  void textVocab() {
    if (textNumberCount == 1) {
      numberVocab = 'ONE !';
    } else if (textNumberCount == 2) {
      numberVocab = 'TWO !';
    } else if (textNumberCount == 3) {
      numberVocab = 'THREE !';
    } else if (textNumberCount == 4) {
      numberVocab = 'FOUR !';
    } else if (textNumberCount == 5) {
      numberVocab = 'FIVE !';
    } else if (textNumberCount == 6) {
      numberVocab = 'SIX !';
    } else if (textNumberCount == 7) {
      numberVocab = 'SEVEN !';
    } else if (textNumberCount == 8) {
      numberVocab = 'EIGHT !';
    } else if (textNumberCount == 9) {
      numberVocab = 'NINE !';
    } else if (textNumberCount == 10) {
      numberVocab = 'TEN !';
      setState(() {
        animationController = true;
       
      });
      Future.delayed(Duration(milliseconds: 750), () {
        setState(() {
           fadeBlackBGOpacity = 1.0;
        });
      });
      Future.delayed(Duration(milliseconds: 750), () {
        setState(() {
          fadeExcellenceOpacity = 1.0;
        });
      });
      Future.delayed(Duration(milliseconds: 750), () {
        setState(() {
          fadeMonsterGoneOpacity = 1.0;
          
        });
      });
      Future.delayed(Duration(milliseconds: 3000), () {
        setState(() {
          
          Navigator.pop(context);
        });
      });
    }

    textNumberCount++;

    Future.delayed(Duration(milliseconds: 0), () {
      setState(() {
        fadeTextOpacity = 1.0;
        touchLockIndex = 0;
      });
    });
    Future.delayed(Duration(milliseconds: 650), () {
      setState(() {
        fadeTextOpacity = 0.0;
        touchLockIndex = 1;
      });
    });
  }

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
        child: Stack(
          children: <Widget>[
            Center(
              //////////////////////////// mountBg
              child: Container(
                width: 941,
                //height: MediaQuery.of(context).size.height,
                child: Image.asset('assets/images/arInteractive/mountBg.png'),
              ),
            ),

            Center(
              child: Container(
                height: 712,
                width: 941,
                child: Stack(
                  children: <Widget>[
                    /////////////////////////////////////////// Text Vocabulary
                    Material(
                      color: Colors.transparent,
                      child: Center(
                        child: AnimatedOpacity(
                          duration: Duration(milliseconds: fadeTextDuration),
                          curve: Curves.elasticInOut,
                          opacity: fadeTextOpacity,
                          child: Container(
                            margin: EdgeInsets.only(bottom: 190),
                            child: Text(
                              numberVocab,
                              style: TextStyle(
                                  fontFamily: 'NunitoBold',
                                  fontSize: 50,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),

                    /////////////////////// monster1
                    monster1Glow
                        ? AnimatedOpacity(
                            duration: Duration(milliseconds: fadeDuration),
                            curve: Curves.elasticInOut,
                            opacity: monster1Opacity,
                            child: Container(
                              margin: EdgeInsets.only(top: 373.4, left: 10),
                              height: 208,
                              child: Image.asset(
                                  'assets/images/arInteractive/monster1_light.png'),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              setState(() {
                                monster1Glow = true;
                                textVocab();
                                Future.delayed(
                                    Duration(milliseconds: fadeDelay), () {
                                  setState(() {
                                    monster1Opacity = 0.0;
                                  });
                                });
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 413, left: 7),
                              height: 121,
                              child: Image.asset(
                                  'assets/images/arInteractive/monster1.png'),
                            ),
                          ),
                    /////////////////////// monster2
                    monster2Glow
                        ? AnimatedOpacity(
                            duration: Duration(milliseconds: fadeDuration),
                            curve: Curves.elasticInOut,
                            opacity: monster2Opacity,
                            child: Container(
                              margin: EdgeInsets.only(top: 198, left: 52),
                              height: 273,
                              child: Image.asset(
                                  'assets/images/arInteractive/monster2_light.png'),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              setState(() {
                                monster2Glow = true;
                                textVocab();
                                Future.delayed(
                                    Duration(milliseconds: fadeDelay), () {
                                  setState(() {
                                    monster2Opacity = 0.0;
                                  });
                                });
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 266, left: 134),
                              height: 182,
                              child: Image.asset(
                                  'assets/images/arInteractive/monster2.png'),
                            ),
                          ),

                    /////////////////////// monster3
                    monster3Glow
                        ? AnimatedOpacity(
                            duration: Duration(milliseconds: fadeDuration),
                            curve: Curves.elasticInOut,
                            opacity: monster3Opacity,
                            child: Container(
                              margin: EdgeInsets.only(top: 455.4, left: 99),
                              height: 131,
                              child: Image.asset(
                                  'assets/images/arInteractive/monster3_light.png'),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              setState(() {
                                monster3Glow = true;
                                textVocab();
                                Future.delayed(
                                    Duration(milliseconds: fadeDelay), () {
                                  setState(() {
                                    monster3Opacity = 0.0;
                                  });
                                });
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 499, left: 150),
                              height: 66,
                              child: Image.asset(
                                  'assets/images/arInteractive/monster3.png'),
                            ),
                          ),
                    /////////////////////// monster4
                    monster4Glow
                        ? AnimatedOpacity(
                            duration: Duration(milliseconds: fadeDuration),
                            curve: Curves.elasticInOut,
                            opacity: monster4Opacity,
                            child: Container(
                              margin: EdgeInsets.only(top: 561.4, left: 200),
                              height: 104,
                              child: Image.asset(
                                  'assets/images/arInteractive/monster4_light.png'),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              setState(() {
                                monster4Glow = true;
                                textVocab();
                                Future.delayed(
                                    Duration(milliseconds: fadeDelay), () {
                                  setState(() {
                                    monster4Opacity = 0.0;
                                  });
                                });
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 588, left: 230),
                              height: 70,
                              child: Image.asset(
                                  'assets/images/arInteractive/monster4.png'),
                            ),
                          ),
                    /////////////////////// monster5
                    monster5Glow
                        ? AnimatedOpacity(
                            duration: Duration(milliseconds: fadeDuration),
                            curve: Curves.elasticInOut,
                            opacity: monster5Opacity,
                            child: Container(
                              margin: EdgeInsets.only(top: 73.4, left: 218),
                              height: 211,
                              child: Image.asset(
                                  'assets/images/arInteractive/monster5_light.png'),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              setState(() {
                                monster5Glow = true;
                                textVocab();
                                Future.delayed(
                                    Duration(milliseconds: fadeDelay), () {
                                  setState(() {
                                    monster5Opacity = 0.0;
                                  });
                                });
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 131, left: 280),
                              height: 129,
                              child: Image.asset(
                                  'assets/images/arInteractive/monster5.png'),
                            ),
                          ),
                    /////////////////////// monster6
                    monster6Glow
                        ? AnimatedOpacity(
                            duration: Duration(milliseconds: fadeDuration),
                            curve: Curves.elasticInOut,
                            opacity: monster6Opacity,
                            child: Container(
                              margin: EdgeInsets.only(top: 357.4, left: 347),
                              height: 236,
                              child: Image.asset(
                                  'assets/images/arInteractive/monster6_light.png'),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              setState(() {
                                monster6Glow = true;
                                textVocab();
                                Future.delayed(
                                    Duration(milliseconds: fadeDelay), () {
                                  setState(() {
                                    monster6Opacity = 0.0;
                                  });
                                });
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 401, left: 372),
                              height: 164,
                              child: Image.asset(
                                  'assets/images/arInteractive/monster6.png'),
                            ),
                          ),
                    /////////////////////// monster7
                    monster7Glow
                        ? AnimatedOpacity(
                            duration: Duration(milliseconds: fadeDuration),
                            curve: Curves.elasticInOut,
                            opacity: monster7Opacity,
                            child: Container(
                              margin: EdgeInsets.only(top: 410.4, left: 581),
                              height: 183,
                              child: Image.asset(
                                  'assets/images/arInteractive/monster7_light.png'),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              setState(() {
                                monster7Glow = true;
                                textVocab();
                                Future.delayed(
                                    Duration(milliseconds: fadeDelay), () {
                                  setState(() {
                                    monster7Opacity = 0.0;
                                  });
                                });
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 429, left: 626),
                              height: 138,
                              child: Image.asset(
                                  'assets/images/arInteractive/monster7.png'),
                            ),
                          ),
                    /////////////////////// monster8
                    monster8Glow
                        ? AnimatedOpacity(
                            duration: Duration(milliseconds: fadeDuration),
                            curve: Curves.elasticInOut,
                            opacity: monster8Opacity,
                            child: Container(
                              margin: EdgeInsets.only(top: 91.4, left: 563),
                              height: 255,
                              child: Image.asset(
                                  'assets/images/arInteractive/monster8_light.png'),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              setState(() {
                                monster8Glow = true;
                                textVocab();
                                Future.delayed(
                                    Duration(milliseconds: fadeDelay), () {
                                  setState(() {
                                    monster8Opacity = 0.0;
                                  });
                                });
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 149, left: 630),
                              height: 153,
                              child: Image.asset(
                                  'assets/images/arInteractive/monster8.png'),
                            ),
                          ),
                    /////////////////////// monster9
                    monster9Glow
                        ? AnimatedOpacity(
                            duration: Duration(milliseconds: fadeDuration),
                            curve: Curves.elasticInOut,
                            opacity: monster9Opacity,
                            child: Container(
                              margin: EdgeInsets.only(top: 480, left: 764),
                              height: 177,
                              child: Image.asset(
                                  'assets/images/arInteractive/monster9_light.png'),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              setState(() {
                                monster9Glow = true;
                                textVocab();
                                Future.delayed(
                                    Duration(milliseconds: fadeDelay), () {
                                  setState(() {
                                    monster9Opacity = 0.0;
                                  });
                                });
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 527, left: 784),
                              height: 94,
                              child: Image.asset(
                                  'assets/images/arInteractive/monster9.png'),
                            ),
                          ),
                    /////////////////////// monster10
                    monster10Glow
                        ? AnimatedOpacity(
                            duration: Duration(milliseconds: fadeDuration),
                            curve: Curves.elasticInOut,
                            opacity: monster10Opacity,
                            child: Container(
                              margin: EdgeInsets.only(top: 289.4, left: 847),
                              height: 172,
                              child: Image.asset(
                                  'assets/images/arInteractive/monster10_light.png'),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              setState(() {
                                monster10Glow = true;
                                textVocab();
                                Future.delayed(
                                    Duration(milliseconds: fadeDelay), () {
                                  setState(() {
                                    monster10Opacity = 0.0;
                                  });
                                });
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 305, left: 879),
                              height: 122,
                              child: Image.asset(
                                  'assets/images/arInteractive/monster10.png'),
                            ),
                          ),
                    ////////////////////////////////////////////////////// Gesture lock
                    Center(
                      child: IndexedStack(
                        index: touchLockIndex,
                        children: <Widget>[
                          Material(
                            color: Colors.transparent,
                            child: Container(
                              width: 941,
                              height: 712,
                            ),
                          ),
                          Container(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            
            ////////////////////////////////////////////////////// black opacity BG
            animationController
                ? AnimatedOpacity(
                  duration: Duration(milliseconds: fadeBlackBGDuration),
                      curve: Curves.fastOutSlowIn,
                      opacity: fadeBlackBGOpacity,
                                  child: Container(
                      color: Color.fromRGBO(0, 0, 0, 0.8),
                      
                    ),
                )
                : Container(),

            ////////////////////////////////////////////////////// star Animation
            /* animationController
                ? Center(
                  child: Container(
                      child: FlareActor("assets/animation/star.flr",
                          animation: 'star'),
                    ),
                )
                : Container(), */
            //////////////////////////////////////////////////////// Finished Text
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Material(
                    color: Colors.transparent,
                    child: AnimatedOpacity(
                      duration: Duration(milliseconds: fadeExcellenceDuration),
                      curve: Curves.elasticInOut,
                      opacity: fadeExcellenceOpacity,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: Text(
                          'Excellence !',
                          style: TextStyle(
                              fontFamily: 'NunitoBold',
                              fontSize: 50,
                              color: Color.fromRGBO(254, 71, 149, 1.0)),
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: AnimatedOpacity(
                      duration: Duration(milliseconds: fadeMonsterGoneDuration),
                      curve: Curves.elasticInOut,
                      opacity: fadeMonsterGoneOpacity,
                      child: Container(
                        child: Text(
                          'All candy monsters are gone now.',
                          style: TextStyle(
                              fontFamily: 'NunitoBold',
                              fontSize: 30,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  
                ],
              ),
            ),
            //////////////////////////// close Btn
            /* Positioned.fill(
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(500),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.1),
                        blurRadius:
                            10.0, // has the effect of softening the shadow
                        spreadRadius:
                            -1, // has the effect of extending the shadow
                        offset: Offset(
                          0.0, // horizontal, move right 10
                          0.0, // vertical, move down 10
                        ),
                      ),
                    ],
                  ),
                  margin: EdgeInsets.only(
                      right: deviceHeight > 500
                          ? deviceHeight * 0.05
                          : deviceHeight * 0.05,
                      top: deviceHeight > 500
                          ? deviceHeight * 0.05
                          : deviceHeight * 0.05),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        return;
                      },
                      child: Container(
                        height: deviceHeight > 500
                            ? deviceWidth * 0.078
                            : deviceWidth * 0.078,
                        child: SvgPicture.asset(
                            'assets/images/vocabulary/closeBtn.svg'),
                      )),
                ),
              ),
            ), */
            ////////////////////////////////////////////////////////////////
          ],
        ),
      ),
    );
  }

  /*  void _onVerticalDragStart(DragStartDetails drag) {
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
  } */
}
