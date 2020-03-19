import 'package:flutter/material.dart';
import 'package:wisekids_app/screen/enterBook.dart';
import '../widget/slide_popup_dialog_play.dart' as playDialog;
import 'home.dart';

class Play extends StatefulWidget {
  @override
  _PlayState createState() => _PlayState();
}

class _PlayState extends State<Play> {
  void _showPlayDialog() {
    print('object');
    playDialog.showSlideDialog(
      context: context,
      child: Container(),
    );
  }

  ////////////////////////////////////////////////
  bool toothBrushAccepted = false;
  bool candyAccepted = false;
  bool monsterAccepted = false;
  bool toothAccepted = false;
  bool mirrorAccepted = false;
  ////////////////////////////////////////////////
  double toothBrushPopTextOpacity = 0.0;
  double candyPopTextOpacity = 0.0;
  double monsterPopTextOpacity = 0.0;
  double toothPopTextOpacity = 0.0;
  double mirrorPopTextOpacity = 0.0;

  int popTextFadeDuration = 500;
  ///////////////////////////////////////////////
  double toothBrushShelfTextOpacity = 1.0;
  double candyShelfTextOpacity = 1.0;
  double monsterShelfTextOpacity = 1.0;
  double toothShelfTextOpacity = 1.0;
  double mirrorShelfTextOpacity = 1.0;

  int shelfTextFadeDuration = 500;
  //////////////////////////////////////////////
  Offset positionToothbrush;
  Offset positionCandy;
  Offset toothBrush;
  Offset mirror;
  double width = 100.0, height = 100.0;

  @override
  void initState() {
    super.initState();
    //positionToothbrush = Offset(60, 175);
    positionCandy = Offset(843, 175);
    toothBrush = Offset(60, 483);
    mirror = Offset(843, 483);
  }

  void correctAllSticker() {
    if (mirrorAccepted &&
        monsterAccepted &&
        toothAccepted &&
        toothBrushAccepted &&
        candyAccepted == true) {
          Future.delayed(Duration(milliseconds: 1250), () {
        playDialog.showSlideDialog(
        context: context,
        child: Container(),
      );
      });
      
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          ///////////////////// Bg
          Container(
            width: deviceWidth,
            height: deviceHeight,
            child: Image.asset('assets/images/play/playBg.png'),
          ),
          ///////////////////// Back Btn
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => EnterBook(),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.only(top: 15, left: 15),
              height: 74,
              child: Image.asset('assets/images/play/backBtn.png'),
            ),
          ),
          /////////////////////////////////////// shelf
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 180,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(40, 163, 240, 0.47),
                        blurRadius:
                            20.0, // has the effect of softening the shadow
                        spreadRadius:
                            0, // has the effect of extending the shadow
                        offset: Offset(
                          0.0, // horizontal, move right 10
                          3.0, // vertical, move down 10
                        ),
                      ),
                    ],
                    color: Color.fromRGBO(255, 255, 255, 0.93),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),

                ////////////////////////////////////////////////////////////////////////// Items dragable
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    //////////////////////////////////////////// toothbrush
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Draggable(
                          data: 'toothBrush',
                          feedback: Container(
                            alignment: Alignment.center,
                            height: 70,
                            child: Image.asset(
                                'assets/images/play/toothBrush.png'),
                          ),
                          childWhenDragging: Container(
                            height: 48,
                            width: 155,
                            child: Image.asset(
                                'assets/images/play/toothBrush_Grey.png'),
                          ),
                          child: !toothBrushAccepted
                              ? Container(
                                  height: 48,
                                  child: Image.asset(
                                      'assets/images/play/toothBrush.png'),
                                )
                              : Container(
                                  height: 48,
                                  width: 155,
                                  child: Image.asset(
                                      'assets/images/play/toothBrush_Grey.png'),
                                ),
                        ),
                        //////////////////////////////// text
                        AnimatedOpacity(
                          opacity: toothBrushShelfTextOpacity,
                          duration:
                              Duration(milliseconds: shelfTextFadeDuration),
                          curve: Curves.easeOutExpo,
                          child: Container(
                            margin: EdgeInsets.only(top: 19, bottom: 18),
                            child: Text(
                              'Toothbrush',
                              style: TextStyle(
                                  fontFamily: 'NunitoBold',
                                  fontSize: 20,
                                  color: Color.fromRGBO(0, 142, 255, 1.00)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    ///////////////////////////////////////////// Candy
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Draggable(
                          data: 'candy',
                          feedback: Container(
                            alignment: Alignment.center,
                            height: 90,
                            child: Image.asset('assets/images/play/candy.png'),
                          ),
                          childWhenDragging: Container(
                            height: 75,
                            width: 119,
                            child: Image.asset(
                                'assets/images/play/candy_Grey.png'),
                          ),
                          onDraggableCanceled:
                              (Velocity velocity, Offset offset) {
                            setState(() => positionToothbrush = offset);
                          },
                          child: !candyAccepted
                              ? Container(
                                  height: 75,
                                  child: Image.asset(
                                      'assets/images/play/candy.png'),
                                )
                              : Container(
                                  height: 75,
                                  width: 119,
                                  child: Image.asset(
                                      'assets/images/play/candy_Grey.png'),
                                ),
                        ),
                        //////////////////////////////////// Text
                        AnimatedOpacity(
                          opacity: candyShelfTextOpacity,
                          duration:
                              Duration(milliseconds: shelfTextFadeDuration),
                          curve: Curves.easeOutExpo,
                          child: Container(
                            margin: EdgeInsets.only(top: 19, bottom: 18),
                            child: Text(
                              'Candy',
                              style: TextStyle(
                                  fontFamily: 'NunitoBold',
                                  fontSize: 20,
                                  color: Color.fromRGBO(0, 142, 255, 1.00)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    ///////////////////////////////////////////// Monster
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Draggable(
                          data: 'monster',
                          feedback: Container(
                            alignment: Alignment.center,
                            height: 135,
                            child: Image.asset(
                                'assets/images/play/candyMonster.png'),
                          ),
                          childWhenDragging: Container(
                            height: 115,
                            width: 134,
                            child: Image.asset(
                                'assets/images/play/candyMonster_Grey.png'),
                          ),
                          onDraggableCanceled:
                              (Velocity velocity, Offset offset) {
                            setState(() => positionToothbrush = offset);
                          },
                          child: !monsterAccepted
                              ? Container(
                                  margin: EdgeInsets.only(left: 25),
                                  height: 115,
                                  child: Image.asset(
                                      'assets/images/play/candyMonster.png'),
                                )
                              : Container(
                                  height: 115,
                                  width: 134,
                                  child: Image.asset(
                                      'assets/images/play/candyMonster_Grey.png'),
                                ),
                        ),
                        ///////////////////////////////// Text
                        AnimatedOpacity(
                          opacity: monsterShelfTextOpacity,
                          duration:
                              Duration(milliseconds: shelfTextFadeDuration),
                          curve: Curves.easeOutExpo,
                          child: Container(
                            margin: EdgeInsets.only(bottom: 18),
                            child: Text(
                              'Monster',
                              style: TextStyle(
                                  fontFamily: 'NunitoBold',
                                  fontSize: 20,
                                  color: Color.fromRGBO(0, 142, 255, 1.00)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    ///////////////////////////////////////////// Tooth
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Draggable(
                          data: 'tooth',
                          feedback: Container(
                            alignment: Alignment.center,
                            height: 120,
                            child: Image.asset('assets/images/play/tooth.png'),
                          ),
                          childWhenDragging: Container(
                            height: 88,
                            width: 102,
                            child: Image.asset(
                                'assets/images/play/tooth_Grey.png'),
                          ),
                          onDraggableCanceled:
                              (Velocity velocity, Offset offset) {
                            setState(() => positionToothbrush = offset);
                          },
                          child: !toothAccepted
                              ? Container(
                                  height: 88,
                                  child: Image.asset(
                                      'assets/images/play/tooth.png'),
                                )
                              : Container(
                                  height: 88,
                                  width: 102,
                                  child: Image.asset(
                                      'assets/images/play/tooth_Grey.png'),
                                ),
                        ),
                        ///////////////////////////// text
                        AnimatedOpacity(
                          opacity: toothShelfTextOpacity,
                          duration:
                              Duration(milliseconds: shelfTextFadeDuration),
                          curve: Curves.easeOutExpo,
                          child: Container(
                            margin: EdgeInsets.only(top: 5, bottom: 18),
                            child: Text(
                              'Tooth',
                              style: TextStyle(
                                  fontFamily: 'NunitoBold',
                                  fontSize: 20,
                                  color: Color.fromRGBO(0, 142, 255, 1.00)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    //////////////////////////////////////////////// Mirror
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Draggable(
                          data: 'mirror',
                          feedback: Container(
                            alignment: Alignment.center,
                            height: 100,
                            child: Image.asset('assets/images/play/mirror.png'),
                          ),
                          childWhenDragging: Container(
                            height: 80,
                            width: 114,
                            child: Image.asset(
                                'assets/images/play/mirror_Grey.png'),
                          ),
                          onDraggableCanceled:
                              (Velocity velocity, Offset offset) {
                            setState(() => positionToothbrush = offset);
                          },
                          child: !mirrorAccepted
                              ? Container(
                                  height: 80,
                                  child: Image.asset(
                                      'assets/images/play/mirror.png'),
                                )
                              : Container(
                                  height: 80,
                                  width: 114,
                                  child: Image.asset(
                                      'assets/images/play/mirror_Grey.png'),
                                ),
                        ),
                        ////////////////////////////////// text
                        AnimatedOpacity(
                          opacity: mirrorShelfTextOpacity,
                          duration:
                              Duration(milliseconds: shelfTextFadeDuration),
                          curve: Curves.easeOutExpo,
                          child: Container(
                            margin: EdgeInsets.only(top: 14, bottom: 18),
                            child: Text(
                              'Mirror',
                              style: TextStyle(
                                  fontFamily: 'NunitoBold',
                                  fontSize: 20,
                                  color: Color.fromRGBO(0, 142, 255, 1.00)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          //////////////////////////////////////// Pop Text
          ///////////////////////// Candy
          AnimatedOpacity(
            opacity: candyPopTextOpacity,
            duration: Duration(milliseconds: popTextFadeDuration),
            curve: Curves.easeOutExpo,
            child: Container(
              margin: EdgeInsets.only(top: 445, left: 78),
              child: Text(
                'Candy',
                style: TextStyle(
                    fontFamily: 'NunitoBold',
                    fontSize: 25,
                    color: Color.fromRGBO(0, 142, 255, 1.00)),
              ),
            ),
          ),
          ///////////////////////// Mirror
          AnimatedOpacity(
            opacity: mirrorPopTextOpacity,
            duration: Duration(milliseconds: popTextFadeDuration),
            curve: Curves.easeOutExpo,
            child: Container(
              margin: EdgeInsets.only(top: 50, left: 205),
              child: Text(
                'Mirror',
                style: TextStyle(
                    fontFamily: 'NunitoBold',
                    fontSize: 25,
                    color: Color.fromRGBO(0, 142, 255, 1.00)),
              ),
            ),
          ),
          //////////////////////// Tooth
          Positioned.fill(
            child: Align(
              alignment: Alignment.topRight,
              child: AnimatedOpacity(
                opacity: toothPopTextOpacity,
                duration: Duration(milliseconds: popTextFadeDuration),
                curve: Curves.easeOutExpo,
                child: Container(
                  margin: EdgeInsets.only(top: 550, right: 510),
                  child: Text(
                    'Tooth',
                    style: TextStyle(
                        fontFamily: 'NunitoBold',
                        fontSize: 25,
                        color: Color.fromRGBO(0, 142, 255, 1.00)),
                  ),
                ),
              ),
            ),
          ),
          ///////////////////////// Toothbrush
          Positioned.fill(
            child: Align(
                alignment: Alignment.topRight,
                child: AnimatedOpacity(
                  opacity: toothBrushPopTextOpacity,
                  duration: Duration(milliseconds: popTextFadeDuration),
                  curve: Curves.easeOutExpo,
                  child: Container(
                    margin: EdgeInsets.only(top: 265, right: 120),
                    child: Text(
                      'Toothbrush',
                      style: TextStyle(
                          fontFamily: 'NunitoBold',
                          fontSize: 25,
                          color: Color.fromRGBO(0, 142, 255, 1.00)),
                    ),
                  ),
                )),
          ),
          ///////////////////////// Monster
          Positioned.fill(
            child: Align(
              alignment: Alignment.topRight,
              child: AnimatedOpacity(
                opacity: monsterPopTextOpacity,
                duration: Duration(milliseconds: popTextFadeDuration),
                curve: Curves.easeOutExpo,
                child: Container(
                  margin: EdgeInsets.only(top: 360, right: 240),
                  child: Text(
                    'Monster',
                    style: TextStyle(
                        fontFamily: 'NunitoBold',
                        fontSize: 25,
                        color: Color.fromRGBO(0, 142, 255, 1.00)),
                  ),
                ),
              ),
            ),
          ),

          /////////////////////////////////////////////////////////////////////////// Drag Target
          //////////////////////////////////////////// Tooth
          Positioned.fill(
            child: Align(
              alignment: Alignment.topRight,
              child: DragTarget(
                builder: (context, List<String> candidateData, rejectedData) {
                  return toothAccepted
                      ? Container(
                          margin: EdgeInsets.only(top: 279, right: 389),
                          height: 266,
                          child: Image.asset('assets/images/play/tooth.png'),
                        )
                      : Container(
                          margin: EdgeInsets.only(top: 279, right: 400),
                          height: 266,
                          width: 285,
                        );
                },
                onWillAccept: (data) {
                  return data == 'tooth';
                },
                onAccept: (data) {
                  setState(() {
                    toothAccepted = true;
                    print('Tooth Accepted');
                    toothShelfTextOpacity = 0.0;
                    toothPopTextOpacity = 1.0;
                    correctAllSticker();
                  });
                },
              ),
            ),
          ),
          /////////////////////////////////////////// toothbrush
          Positioned.fill(
            child: Align(
              alignment: Alignment.topRight,
              child: DragTarget(
                builder: (context, List<String> candidateData, rejectedData) {
                  return toothBrushAccepted
                      ? Container(
                          margin: EdgeInsets.only(top: 185, right: 67),
                          height: 76,
                          child:
                              Image.asset('assets/images/play/toothBrush.png'),
                        )
                      : Container(
                          margin: EdgeInsets.only(top: 185, right: 67),
                          width: 240,
                          height: 76,
                        );
                },
                onWillAccept: (data) {
                  return data == 'toothBrush';
                },
                onAccept: (data) {
                  setState(() {
                    toothBrushAccepted = true;
                    print('toothbrush Accepted');
                    toothBrushShelfTextOpacity = 0.0;
                    toothBrushPopTextOpacity = 1.0;
                    correctAllSticker();
                  });
                },
              ),
            ),
          ),
          //////////////////////////////////////////// candy
          Positioned.fill(
            child: Align(
              alignment: Alignment.topLeft,
              child: DragTarget(
                builder: (context, List<String> candidateData, rejectedData) {
                  return candyAccepted
                      ? Container(
                          margin: EdgeInsets.only(top: 488, left: 53),
                          height: 78,
                          child: Image.asset('assets/images/play/candy.png'),
                        )
                      : Container(
                          margin: EdgeInsets.only(top: 488, left: 53),
                          height: 78,
                          width: 120,
                        );
                },
                onWillAccept: (data) {
                  return data == 'candy';
                },
                onAccept: (data) {
                  setState(() {
                    candyAccepted = true;
                    print('Candy Accepted');
                    candyShelfTextOpacity = 0.0;
                    candyPopTextOpacity = 1.0;
                    correctAllSticker();
                  });
                },
              ),
            ),
          ),
          //////////////////////////////////////////// Monster
          Positioned.fill(
            child: Align(
              alignment: Alignment.topRight,
              child: DragTarget(
                builder: (context, List<String> candidateData, rejectedData) {
                  return monsterAccepted
                      ? Container(
                          margin: EdgeInsets.only(top: 392, right: 182),
                          height: 200,
                          child: Image.asset(
                              'assets/images/play/candyMonster.png'),
                        )
                      : Container(
                          margin: EdgeInsets.only(top: 392, right: 182),
                          height: 200,
                          width: 200,
                        );
                },
                onWillAccept: (data) {
                  return data == 'monster';
                },
                onAccept: (data) {
                  setState(() {
                    monsterAccepted = true;
                    print('Monster Accepted');
                    monsterShelfTextOpacity = 0.0;
                    monsterPopTextOpacity = 1.0;
                    correctAllSticker();
                  });
                },
              ),
            ),
          ),

          //////////////////////////////////////////// Mirror
          Positioned.fill(
            child: Align(
              alignment: Alignment.topLeft,
              child: DragTarget(
                builder: (context, List<String> candidateData, rejectedData) {
                  return mirrorAccepted
                      ? Container(
                          margin: EdgeInsets.only(top: 96, left: 127),
                          height: 154,
                          child: Image.asset('assets/images/play/mirror.png'),
                        )
                      : Container(
                          margin: EdgeInsets.only(top: 96, left: 127),
                          height: 154,
                          width: 220,
                        );
                },
                onWillAccept: (data) {
                  return data == 'mirror';
                },
                onAccept: (data) {
                  setState(() {
                    mirrorAccepted = true;
                    print('Mirror Accepted');
                    mirrorShelfTextOpacity = 0.0;
                    mirrorPopTextOpacity = 1.0;
                    correctAllSticker();
                  });
                },
              ),
            ),
          ),
          //////////////////////////////////////////////////////////////
          ///

          //////////////////////////////////////////////////////// Box + DragTarget
          /*Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(69, 222, 222, 0.2),
                        blurRadius:
                            20.0, // has the effect of softening the shadow
                        spreadRadius:
                            0, // has the effect of extending the shadow
                        offset: Offset(
                          0.0, // horizontal, move right 10
                          2.0, // vertical, move down 10
                        ),
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)),
                width: deviceWidth * 0.527,
                height: deviceHeight * 0.707,
                child: Container(
                  alignment: Alignment.center,
                  //margin: EdgeInsets.only(left: 40),
                  ////////////////////////////////////////////////////////////////////
                  child: Wrap(
                    spacing: 100,
                    runSpacing: 55,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          //////////////////////////// mirror Target
                          DragTarget(
                            builder: (context, List<String> candidateData,
                                rejectedData) {
                              return mirrorAccepted
                                  ? Container(
                                      width: 200,
                                      height: 178,
                                      child: Image.asset(
                                        'assets/images/play/mirror.png',
                                      ),
                                    )
                                  : Container(
                                      width: 200,
                                      height: 178,
                                      child: Image.asset(
                                        'assets/images/play/mirrorGrey.png',
                                      ),
                                    );
                            },
                            onWillAccept: (data) {
                              return data == 'mirror';
                            },
                            onAccept: (data) {
                              setState(() {
                                mirrorAccepted = true;
                                print('mirror Accepted');
                              });
                              correctAllSticker();
                            },
                          ),
                          ///////////////////////////////////// mirror Text
                          Container(
                            margin: EdgeInsets.only(top: 17),
                            child: Text(
                              'Mirror',
                              style: TextStyle(
                                color: Color.fromRGBO(69, 223, 224, 1.0),
                                fontFamily: 'NunitoBold',
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      ///////////////////////////////////////// toothBrush Target
                      Column(
                        children: <Widget>[
                          DragTarget(
                            builder: (context, List<String> candidateData,
                                rejectedData) {
                              return toothBrushAccepted
                                  ? Container(
                                      margin: EdgeInsets.only(top: 10),
                                      height: 146,
                                      child: Image.asset(
                                          'assets/images/play/toothBrush.png'),
                                    )
                                  : Container(
                                      margin: EdgeInsets.only(top: 10),
                                      height: 146,
                                      child: Image.asset(
                                          'assets/images/play/toothBrushGrey.png'),
                                    );
                            },
                            onWillAccept: (data) {
                              return data == 'toothBrush';
                            },
                            onAccept: (data) {
                              setState(() {
                                toothBrushAccepted = true;
                                print('toothbrush Accepted');
                                correctAllSticker();
                              });
                            },
                          ),
                          /////////////////////////////////////////////// toothBrush Text
                          Container(
                            margin: EdgeInsets.only(top: 40),
                            child: Text(
                              'Toothbrush',
                              style: TextStyle(
                                color: Color.fromRGBO(69, 223, 224, 1.0),
                                fontFamily: 'NunitoBold',
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      //////////////////////////////////////////////////// Candy Target
                      Column(
                        children: <Widget>[
                          DragTarget(
                            builder: (context, List<String> candidateData,
                                rejectedData) {
                              return candyAccepted
                                  ? Container(
                                      height: 157,
                                      child: Image.asset(
                                          'assets/images/play/Toffy.png'),
                                    )
                                  : Container(
                                      height: 157,
                                      child: Image.asset(
                                          'assets/images/play/candyGrey.png'),
                                    );
                            },
                            onWillAccept: (data) {
                              return data == 'candy';
                            },
                            onAccept: (data) {
                              setState(() {
                                candyAccepted = true;
                                print('candy Accepted');
                              });
                              correctAllSticker();
                            },
                          ),
                          ///////////////////////////////////// candy text
                          Container(
                            margin: EdgeInsets.only(top: 17),
                            child: Text(
                              'Candy',
                              style: TextStyle(
                                color: Color.fromRGBO(69, 223, 224, 1.0),
                                fontFamily: 'NunitoBold',
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          DragTarget(
                            builder: (context, List<String> candidateData,
                                rejectedData) {
                              return cupCakeAccepted
                                  ? Container(
                                      margin: EdgeInsets.only(top: 20),
                                      height: 128,
                                      child: Image.asset(
                                          'assets/images/play/cupCake.png'),
                                    )
                                  : Container(
                                      margin: EdgeInsets.only(top: 20),
                                      height: 128,
                                      child: Image.asset(
                                          'assets/images/play/cupCakeGrey.png'),
                                    );
                            },
                            onWillAccept: (data) {
                              return data == 'cupCake';
                            },
                            onAccept: (data) {
                              setState(() {
                                cupCakeAccepted = true;
                                print('cupcake Accepted');
                              });
                              correctAllSticker();
                            },
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 26),
                            child: Text(
                              'Cupcake',
                              style: TextStyle(
                                color: Color.fromRGBO(69, 223, 224, 1.0),
                                fontFamily: 'NunitoBold',
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),*/

          /*
          ///////////////////////////////////////////////////////////////// Prop Dragable
          ////////////// cupcake
          Positioned(
            left: positionCupCake.dx,
            top: positionCupCake.dy - height + 100,
            child: Draggable(
              data: 'cupCake',
              feedback: Container(
                alignment: Alignment.center,
                height: 154,
                child: Image.asset('assets/images/play/cupCake.png'),
              ),
              child: !cupCakeAccepted
                  ? Container(
                      height: 128,
                      child: Image.asset('assets/images/play/cupCake.png'),
                    )
                  : Container(),
              childWhenDragging: Container(),
              onDraggableCanceled: (Velocity velocity, Offset offset) {
                setState(() => positionCupCake = offset);
              },
            ),
          ),
          ////////////// Candy
          Positioned(
            left: positionCandy.dx,
            top: positionCandy.dy - height + 100,
            child: Draggable(
              data: 'candy',
              feedback: Container(
                alignment: Alignment.center,
                height: 188,
                child: Image.asset('assets/images/play/Toffy.png'),
              ),
              child: !candyAccepted
                  ? Container(
                      height: 157,
                      child: Image.asset('assets/images/play/Toffy.png'),
                    )
                  : Container(),
              childWhenDragging: Container(),
              onDraggableCanceled: (Velocity velocity, Offset offset) {
                setState(() => positionCandy = offset);
              },
            ),
          ),
          ////////////// toothBrush
          Positioned(
            left: toothBrush.dx,
            top: toothBrush.dy - height + 100,
            child: Draggable(
              data: 'toothBrush',
              feedback: Container(
                alignment: Alignment.center,
                height: 175,
                child: Image.asset('assets/images/play/toothBrush.png'),
              ),
              child: !toothBrushAccepted
                  ? Container(
                      height: 146,
                      child: Image.asset('assets/images/play/toothBrush.png'),
                    )
                  : Container(),
              childWhenDragging: Container(),
              onDraggableCanceled: (Velocity velocity, Offset offset) {
                setState(() => toothBrush = offset);
              },
            ),
          ),
          ////////////// Mirror
          Positioned(
            left: mirror.dx,
            top: mirror.dy - height + 100,
            child: Draggable(
              data: 'mirror',
              feedback: Container(
                alignment: Alignment.center,
                height: 214,
                child: Image.asset('assets/images/play/mirror.png'),
              ),
              child: !mirrorAccepted
                  ? Container(
                      height: 178,
                      child: Image.asset('assets/images/play/mirror.png'),
                    )
                  : Container(),
              childWhenDragging: Container(),
              onDraggableCanceled: (Velocity velocity, Offset offset) {
                setState(() => mirror = offset);
                /*  Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Home(),
                  ),
                );
                playDialog.showSlideDialog(
                  context: context,
                  child: Container(),
                );
                 */
              },
            ),
          ),
          ////////
          */
        ],
      ),
    );
  }
}
