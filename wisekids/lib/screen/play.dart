import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/dataProvider.dart';
import '../provider/audioProvider.dart';
import './enterBook.dart';
import '../widget/slide_popup_dialog_play.dart' as playDialog; //// ori
//import '../widget/slide_popup_dialog_read.dart' as playDialog; /// test read dialog
//import '../widget/slide_popup_dialog_arInteractive.dart' as playDialog; /// test arInteractive dialog

/// test arInteractive dialog
import 'home.dart';

class Play extends StatefulWidget {
  @override
  _PlayState createState() => _PlayState();
}

class _PlayState extends State<Play> {
  void _showPlayDialog() {
    print('Show Congrat Dialog');
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
      Future.delayed(Duration(milliseconds: 500), () {
        Provider.of<AudioProvider>(context, listen: false)
            .playSoundEffect("achievement1", 0.5);
        playDialog.showSlideDialog(
          context: context,
          child: Container(),
        );
        Provider.of<DataProvider>(context, listen: false).finishedPlay();
      });
    }
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
          ///////////////////// Bg
          Container(
            //width: deviceWidth,
            height: deviceHeight,
            child: Image.asset(
              'assets/images/play/playBgLong.png',
              fit: BoxFit.fitHeight,
            ),
          ),
          ///////////////////// Back Btn
          GestureDetector(
            onTap: () {
              Provider.of<AudioProvider>(context, listen: false)
                  .playSoundEffect("click3", 1.0);
              Provider.of<AudioProvider>(context, listen: false)
                  .stopPlayTheme();
              Provider.of<AudioProvider>(context, listen: false)
                  .playCandyMonsterTheme();
              Navigator.pop(
                context,
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
              child: Image.asset('assets/images/play/backBtn.png'),
            ),
          ),
          /////////////////////////////////////// shelf
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: deviceHeight > 500
                    ? deviceHeight * (180 / 768)
                    : deviceHeight * (180 / 768),
                child: AspectRatio(
                  aspectRatio: 1024 / 180,
                  child: Container(
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
                    child: Padding(
                      padding: EdgeInsets.all(
                          deviceHeight * (180 / 768) * (20 / 180)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          //////////////////////////////////////////// toothbrush
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Spacer(),
                              AbsorbPointer(
                                absorbing: toothBrushAccepted,
                                child: Draggable(
                                  onDragEnd: (details) {
                                    Provider.of<AudioProvider>(context,
                                            listen: false)
                                        .playSoundEffect("click3", 1.0);
                                  },
                                  onDragStarted: () {
                                    Provider.of<AudioProvider>(context,
                                            listen: false)
                                        .playSoundEffect("select", 1.0);
                                  },
                                  data: 'toothBrush',
                                  feedback: Container(
                                    alignment: Alignment.center,
                                    height: deviceHeight > 500
                                        ? deviceHeight *
                                            (180 / 768) *
                                            (68 / 180)
                                        : deviceHeight *
                                            (180 / 768) *
                                            (48 / 180),
                                    child: Image.asset(
                                      'assets/images/play/toothBrush.png',
                                      gaplessPlayback: true,
                                    ),
                                  ),
                                  childWhenDragging: Container(
                                    height:
                                        deviceHeight * (180 / 768) * (48 / 180),
                                    //width: 155,
                                    child: Image.asset(
                                      'assets/images/play/toothBrush_Grey.png',
                                      gaplessPlayback: true,
                                    ),
                                  ),
                                  child: !toothBrushAccepted
                                      ? Container(
                                          height: deviceHeight *
                                              (180 / 768) *
                                              (48 / 180),
                                          child: Image.asset(
                                            'assets/images/play/toothBrush.png',
                                            gaplessPlayback: true,
                                          ),
                                        )
                                      : Container(
                                          height: deviceHeight *
                                              (180 / 768) *
                                              (48 / 180),
                                          //width: 155,
                                          child: Image.asset(
                                            'assets/images/play/toothBrush_Grey.png',
                                            gaplessPlayback: true,
                                          ),
                                        ),
                                ),
                              ),
                              Spacer(),
                              //////////////////////////////// text
                              AnimatedOpacity(
                                opacity: toothBrushShelfTextOpacity,
                                duration: Duration(
                                    milliseconds: shelfTextFadeDuration),
                                curve: Curves.easeOutExpo,
                                child: Container(
                                  height: deviceHeight > 500
                                      ? deviceHeight * (180 / 768) * (27 / 180)
                                      : deviceHeight * (180 / 768) * (40 / 180),
                                  //margin: EdgeInsets.only(top: 19, bottom: 18),
                                  child: FittedBox(
                                    fit: BoxFit.fitHeight,
                                    child: Text(
                                      'Toothbrush',
                                      style: TextStyle(
                                          fontFamily: 'NunitoBold',
                                          color: Color.fromRGBO(
                                              0, 142, 255, 1.00)),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          ///////////////////////////////////////////// Candy
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Spacer(),
                              AbsorbPointer(
                                absorbing: candyAccepted,
                                child: Draggable(
                                  onDragEnd: (details) {
                                    Provider.of<AudioProvider>(context,
                                            listen: false)
                                        .playSoundEffect("click3", 1.0);
                                  },
                                  onDragStarted: () {
                                    Provider.of<AudioProvider>(context,
                                            listen: false)
                                        .playSoundEffect("select", 1.0);
                                  },
                                  data: 'candy',
                                  feedback: Container(
                                    alignment: Alignment.center,
                                    height: deviceHeight > 500
                                        ? deviceHeight *
                                            (180 / 768) *
                                            (95 / 180)
                                        : deviceHeight *
                                            (180 / 768) *
                                            (75 / 180),
                                    child: Image.asset(
                                      'assets/images/play/candy.png',
                                      gaplessPlayback: true,
                                    ),
                                  ),
                                  childWhenDragging: Container(
                                    height:
                                        deviceHeight * (180 / 768) * (75 / 180),
                                    child: Image.asset(
                                      'assets/images/play/candy_Grey.png',
                                      gaplessPlayback: true,
                                    ),
                                  ),
                                  onDraggableCanceled:
                                      (Velocity velocity, Offset offset) {
                                    setState(() => positionToothbrush = offset);
                                  },
                                  child: !candyAccepted
                                      ? Container(
                                          height: deviceHeight *
                                              (180 / 768) *
                                              (75 / 180),
                                          child: Image.asset(
                                            'assets/images/play/candy.png',
                                            gaplessPlayback: true,
                                          ),
                                        )
                                      : Container(
                                          height: deviceHeight *
                                              (180 / 768) *
                                              (75 / 180),
                                          child: Image.asset(
                                            'assets/images/play/candy_Grey.png',
                                            gaplessPlayback: true,
                                          ),
                                        ),
                                ),
                              ),
                              Spacer(),
                              //////////////////////////////////// Text
                              AnimatedOpacity(
                                opacity: candyShelfTextOpacity,
                                duration: Duration(
                                    milliseconds: shelfTextFadeDuration),
                                curve: Curves.easeOutExpo,
                                child: Container(
                                  height: deviceHeight > 500
                                      ? deviceHeight * (180 / 768) * (27 / 180)
                                      : deviceHeight * (180 / 768) * (40 / 180),
                                  child: FittedBox(
                                    fit: BoxFit.fitHeight,
                                    child: Text(
                                      'Candy',
                                      style: TextStyle(
                                          fontFamily: 'NunitoBold',
                                          //fontSize: 20,
                                          color: Color.fromRGBO(
                                              0, 142, 255, 1.00)),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          ///////////////////////////////////////////// Monster
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Spacer(),
                              AbsorbPointer(
                                absorbing: monsterAccepted,
                                child: Draggable(
                                  onDragEnd: (details) {
                                    Provider.of<AudioProvider>(context,
                                            listen: false)
                                        .playSoundEffect("click3", 1.0);
                                  },
                                  onDragStarted: () {
                                    Provider.of<AudioProvider>(context,
                                            listen: false)
                                        .playSoundEffect("select", 1.0);
                                  },
                                  data: 'monster',
                                  feedback: Container(
                                    margin: EdgeInsets.only(
                                        left: deviceHeight *
                                            (180 / 768) *
                                            (100 / 180) *
                                            (109 / 100) *
                                            (25 / 109)),
                                    alignment: Alignment.center,
                                    height: deviceHeight > 500
                                        ? deviceHeight *
                                            (180 / 768) *
                                            (160 / 180)
                                        : deviceHeight *
                                            (180 / 768) *
                                            (100 / 180),
                                    child: Image.asset(
                                      'assets/images/play/candyMonster.png',
                                      gaplessPlayback: true,
                                    ),
                                  ),
                                  childWhenDragging: Container(
                                    margin: EdgeInsets.only(
                                        left: deviceHeight *
                                            (180 / 768) *
                                            (100 / 180) *
                                            (109 / 100) *
                                            (25 / 109)),
                                    height: deviceHeight *
                                        (180 / 768) *
                                        (100 / 180),
                                    child: Image.asset(
                                      'assets/images/play/candyMonster_Grey.png',
                                      gaplessPlayback: true,
                                    ),
                                  ),
                                  onDraggableCanceled:
                                      (Velocity velocity, Offset offset) {
                                    setState(() => positionToothbrush = offset);
                                  },
                                  child: !monsterAccepted
                                      ? Container(
                                          margin: EdgeInsets.only(
                                              left: deviceHeight *
                                                  (180 / 768) *
                                                  (100 / 180) *
                                                  (109 / 100) *
                                                  (25 / 109)),
                                          height: deviceHeight *
                                              (180 / 768) *
                                              (100 / 180),
                                          child: Image.asset(
                                            'assets/images/play/candyMonster.png',
                                            gaplessPlayback: true,
                                          ),
                                        )
                                      : Container(
                                          margin: EdgeInsets.only(
                                              left: deviceHeight *
                                                  (180 / 768) *
                                                  (100 / 180) *
                                                  (109 / 100) *
                                                  (25 / 109)),
                                          height: deviceHeight *
                                              (180 / 768) *
                                              (100 / 180),
                                          child: Image.asset(
                                            'assets/images/play/candyMonster_Grey.png',
                                            gaplessPlayback: true,
                                          ),
                                        ),
                                ),
                              ),
                              Spacer(),
                              ///////////////////////////////// Text
                              AnimatedOpacity(
                                opacity: monsterShelfTextOpacity,
                                duration: Duration(
                                    milliseconds: shelfTextFadeDuration),
                                curve: Curves.easeOutExpo,
                                child: Container(
                                  height: deviceHeight > 500
                                      ? deviceHeight * (180 / 768) * (27 / 180)
                                      : deviceHeight * (180 / 768) * (40 / 180),
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Text(
                                      'Monster',
                                      style: TextStyle(
                                          fontFamily: 'NunitoBold',
                                          color: Color.fromRGBO(
                                              0, 142, 255, 1.00)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          ///////////////////////////////////////////// Tooth
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Spacer(),
                              AbsorbPointer(
                                absorbing: toothAccepted,
                                child: Draggable(
                                  onDragEnd: (details) {
                                    Provider.of<AudioProvider>(context,
                                            listen: false)
                                        .playSoundEffect("click3", 1.0);
                                  },
                                  onDragStarted: () {
                                    Provider.of<AudioProvider>(context,
                                            listen: false)
                                        .playSoundEffect("select", 1.0);
                                  },
                                  data: 'tooth',
                                  feedback: Container(
                                    alignment: Alignment.center,
                                    height: deviceHeight > 500
                                        ? deviceHeight *
                                            (180 / 768) *
                                            (150 / 180)
                                        : deviceHeight *
                                            (180 / 768) *
                                            (90 / 180),
                                    child: Image.asset(
                                      'assets/images/play/tooth.png',
                                      gaplessPlayback: true,
                                    ),
                                  ),
                                  childWhenDragging: Container(
                                    height:
                                        deviceHeight * (180 / 768) * (90 / 180),
                                    child: Image.asset(
                                      'assets/images/play/tooth_Grey.png',
                                      gaplessPlayback: true,
                                    ),
                                  ),
                                  onDraggableCanceled:
                                      (Velocity velocity, Offset offset) {
                                    setState(() => positionToothbrush = offset);
                                  },
                                  child: !toothAccepted
                                      ? Container(
                                          height: deviceHeight *
                                              (180 / 768) *
                                              (90 / 180),
                                          child: Image.asset(
                                            'assets/images/play/tooth.png',
                                            gaplessPlayback: true,
                                          ),
                                        )
                                      : Container(
                                          height: deviceHeight *
                                              (180 / 768) *
                                              (90 / 180),
                                          child: Image.asset(
                                            'assets/images/play/tooth_Grey.png',
                                            gaplessPlayback: true,
                                          ),
                                        ),
                                ),
                              ),
                              Spacer(),
                              ///////////////////////////// text
                              AnimatedOpacity(
                                opacity: toothShelfTextOpacity,
                                duration: Duration(
                                    milliseconds: shelfTextFadeDuration),
                                curve: Curves.easeOutExpo,
                                child: Container(
                                  height: deviceHeight > 500
                                      ? deviceHeight * (180 / 768) * (27 / 180)
                                      : deviceHeight * (180 / 768) * (40 / 180),
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Text(
                                      'Tooth',
                                      style: TextStyle(
                                          fontFamily: 'NunitoBold',
                                          fontSize: 20,
                                          color: Color.fromRGBO(
                                              0, 142, 255, 1.00)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          //////////////////////////////////////////////// Mirror
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Spacer(),
                              AbsorbPointer(
                                absorbing: mirrorAccepted,
                                child: Draggable(
                                  onDragEnd: (details) {
                                    Provider.of<AudioProvider>(context,
                                            listen: false)
                                        .playSoundEffect("click3", 1.0);
                                  },
                                  onDragStarted: () {
                                    Provider.of<AudioProvider>(context,
                                            listen: false)
                                        .playSoundEffect("select", 1.0);
                                  },
                                  data: 'mirror',
                                  feedback: Container(
                                    alignment: Alignment.center,
                                    height: deviceHeight > 500
                                        ? deviceHeight *
                                            (180 / 768) *
                                            (110 / 180)
                                        : deviceHeight *
                                            (180 / 768) *
                                            (90 / 180),
                                    child: Image.asset(
                                      'assets/images/play/mirror.png',
                                      gaplessPlayback: true,
                                    ),
                                  ),
                                  childWhenDragging: Container(
                                    height:
                                        deviceHeight * (180 / 768) * (90 / 180),
                                    child: Image.asset(
                                      'assets/images/play/mirror_Grey.png',
                                      gaplessPlayback: true,
                                    ),
                                  ),
                                  onDraggableCanceled:
                                      (Velocity velocity, Offset offset) {
                                    setState(() => positionToothbrush = offset);
                                  },
                                  child: !mirrorAccepted
                                      ? Container(
                                          height: deviceHeight *
                                              (180 / 768) *
                                              (90 / 180),
                                          child: Image.asset(
                                            'assets/images/play/mirror.png',
                                            gaplessPlayback: true,
                                          ),
                                        )
                                      : Container(
                                          height: deviceHeight *
                                              (180 / 768) *
                                              (90 / 180),
                                          child: Image.asset(
                                            'assets/images/play/mirror_Grey.png',
                                            gaplessPlayback: true,
                                          ),
                                        ),
                                ),
                              ),
                              Spacer(),
                              ////////////////////////////////// text
                              AnimatedOpacity(
                                opacity: mirrorShelfTextOpacity,
                                duration: Duration(
                                    milliseconds: shelfTextFadeDuration),
                                curve: Curves.easeOutExpo,
                                child: Container(
                                  height: deviceHeight > 500
                                      ? deviceHeight * (180 / 768) * (27 / 180)
                                      : deviceHeight * (180 / 768) * (40 / 180),
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Text(
                                      'Mirror',
                                      style: TextStyle(
                                          fontFamily: 'NunitoBold',
                                          fontSize: 20,
                                          color: Color.fromRGBO(
                                              0, 142, 255, 1.00)),
                                    ),
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
              ),
            ),
          ),

          //////////////////////////////////////// Pop Text
          Container(
            height: deviceHeight,
            child: Center(
              child: AspectRatio(
                aspectRatio: 1024 / 768,
                child: Stack(
                  ///////////////////////// Candy

                  children: <Widget>[
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: AnimatedOpacity(
                          opacity: candyPopTextOpacity,
                          duration: Duration(milliseconds: popTextFadeDuration),
                          curve: Curves.easeOutExpo,
                          child: Container(
                            height: deviceHeight > 500
                                ? deviceHeight * (35 / 768)
                                : deviceHeight * (40 / 768),
                            margin: EdgeInsets.only(
                                bottom: deviceHeight * (322.3 / 768),
                                left: deviceHeight * (70 / 768)),
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                'Candy',
                                style: TextStyle(
                                    fontFamily: 'NunitoBold',
                                    fontSize: 25,
                                    color: Color.fromRGBO(0, 142, 255, 1.00)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    ///////////////////////// Mirror
                    AnimatedOpacity(
                      opacity: mirrorPopTextOpacity,
                      duration: Duration(milliseconds: popTextFadeDuration),
                      curve: Curves.easeOutExpo,
                      child: Container(
                        height: deviceHeight > 500
                            ? deviceHeight * (35 / 768)
                            : deviceHeight * (40 / 768),
                        margin: EdgeInsets.only(
                            top: deviceHeight * (254.6 / 768),
                            left: deviceHeight * (186.6 / 768)),
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            'Mirror',
                            style: TextStyle(
                                fontFamily: 'NunitoBold',
                                fontSize: 25,
                                color: Color.fromRGBO(0, 142, 255, 1.00)),
                          ),
                        ),
                      ),
                    ),
                    //////////////////////// Tooth
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: AnimatedOpacity(
                          opacity: toothPopTextOpacity,
                          duration: Duration(milliseconds: popTextFadeDuration),
                          curve: Curves.easeOutExpo,
                          child: Container(
                            height: deviceHeight > 500
                                ? deviceHeight * (35 / 768)
                                : deviceHeight * (40 / 768),
                            margin: EdgeInsets.only(
                                bottom:
                                    deviceHeight * (251 / 768) * (210 / 251)),
                            child: FittedBox(
                              fit: BoxFit.contain,
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
                    ),
                    ///////////////////////// Toothbrush
                    Positioned.fill(
                      child: Align(
                          alignment: Alignment.topRight,
                          child: AnimatedOpacity(
                            opacity: toothBrushPopTextOpacity,
                            duration:
                                Duration(milliseconds: popTextFadeDuration),
                            curve: Curves.easeOutExpo,
                            child: Container(
                              height: deviceHeight > 500
                                  ? deviceHeight * (35 / 768)
                                  : deviceHeight * (40 / 768),
                              margin: EdgeInsets.only(
                                  top: deviceHeight * (72 / 768) * (250 / 72),
                                  right:
                                      deviceHeight * (72 / 768) * (104 / 72)),
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  'Toothbrush',
                                  style: TextStyle(
                                      fontFamily: 'NunitoBold',
                                      fontSize: 25,
                                      color: Color.fromRGBO(0, 142, 255, 1.00)),
                                ),
                              ),
                            ),
                          )),
                    ),
                    ///////////////////////// Monster
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: AnimatedOpacity(
                          opacity: monsterPopTextOpacity,
                          duration: Duration(milliseconds: popTextFadeDuration),
                          curve: Curves.easeOutExpo,
                          child: Container(
                            height: deviceHeight > 500
                                ? deviceHeight * (35 / 768)
                                : deviceHeight * (40 / 768),
                            margin: EdgeInsets.only(
                                bottom: deviceHeight * (390 / 768),
                                right: deviceHeight * (200 / 768)),
                            child: FittedBox(
                              fit: BoxFit.contain,
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
                    ),

                    /////////////////////////////////////////////////////////////////////////// Drag Target
                    ///////////////////////////////////////////////////////////////////////////
                    ///////////////////////////////////////////////////////////////////////////
                    ///////////////////////////////////////////////////////////////////////////
                    ///////////////////////////////////////////////////////////////////////////
                    ///////////////////////////////////////////////////////////////////////////
                    //////////////////////////////////////////// Tooth
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.topRight,
                        child: DragTarget(
                          builder: (context, List<String> candidateData,
                              rejectedData) {
                            return toothAccepted
                                ? Container(
                                    //color: Colors.red[300],
                                    margin: EdgeInsets.only(
                                        top: deviceHeight *
                                            (251 / 768) *
                                            (265 / 251),
                                        right: deviceHeight *
                                            (251 / 768) *
                                            (290 / 251) *
                                            (369 / 290)),
                                    height: deviceHeight * (251 / 768),
                                    child: Image.asset(
                                        'assets/images/play/tooth.png'),
                                  )
                                : Container(
                                    margin: EdgeInsets.only(
                                        top: deviceHeight *
                                            (251 / 768) *
                                            (265 / 251),
                                        right: deviceHeight *
                                            (251 / 768) *
                                            (290 / 251) *
                                            (369 / 290)),
                                    height: deviceHeight * (251 / 768),
                                    child: AspectRatio(
                                        aspectRatio: 290 / 251,
                                        child: Container(
                                            //color: Colors.red[300],
                                            )),
                                  );
                          },
                          onWillAccept: (data) {
                            return data == 'tooth';
                          },
                          onAccept: (data) {
                            Provider.of<AudioProvider>(context, listen: false)
                                .playSoundEffect("matchCorrect", 0.5);

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
                          builder: (context, List<String> candidateData,
                              rejectedData) {
                            return toothBrushAccepted
                                ? Container(
                                    margin: EdgeInsets.only(
                                        top: deviceHeight *
                                            (72 / 768) *
                                            (175 / 72),
                                        right: deviceHeight *
                                            (72 / 768) *
                                            (64 / 72)),
                                    height: deviceHeight * (72 / 768),
                                    child: Image.asset(
                                        'assets/images/play/toothBrush.png'),
                                  )
                                : Container(
                                    margin: EdgeInsets.only(
                                        top: deviceHeight *
                                            (72 / 768) *
                                            (175 / 72),
                                        right: deviceHeight *
                                            (72 / 768) *
                                            (64 / 72)),
                                    height: deviceHeight * (72 / 768),
                                    child: AspectRatio(
                                      aspectRatio: 233 / 72,
                                      child: Container(),
                                    ),
                                  );
                          },
                          onWillAccept: (data) {
                            return data == 'toothBrush';
                          },
                          onAccept: (data) {
                            Provider.of<AudioProvider>(context, listen: false)
                                .playSoundEffect("matchCorrect", 0.5);
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
                        alignment: Alignment.bottomLeft,
                        child: DragTarget(
                          builder: (context, List<String> candidateData,
                              rejectedData) {
                            return candyAccepted
                                ? Container(
                                    margin: EdgeInsets.only(
                                        bottom: deviceHeight * (231 / 768),
                                        left: deviceHeight * (49 / 768)),
                                    height: deviceHeight * (75 / 768),
                                    child: Image.asset(
                                        'assets/images/play/candy.png'),
                                  )
                                : Container(
                                    margin: EdgeInsets.only(
                                        bottom: deviceHeight * (231 / 768),
                                        left: deviceHeight * (49 / 768)),
                                    height: deviceHeight * (75 / 768),
                                    child: AspectRatio(
                                      aspectRatio: 119 / 75,
                                      child: Container(),
                                    ),
                                  );
                          },
                          onWillAccept: (data) {
                            return data == 'candy';
                          },
                          onAccept: (data) {
                            Provider.of<AudioProvider>(context, listen: false)
                                .playSoundEffect("matchCorrect", 0.5);
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
                        alignment: Alignment.bottomRight,
                        child: DragTarget(
                          builder: (context, List<String> candidateData,
                              rejectedData) {
                            return monsterAccepted
                                ? Container(
                                    margin: EdgeInsets.only(
                                        bottom: deviceHeight * (207 / 768),
                                        right: deviceHeight * (172 / 768)),
                                    height: deviceHeight * (190 / 768),
                                    child: Image.asset(
                                        'assets/images/play/candyMonster.png'),
                                  )
                                : Container(
                                    margin: EdgeInsets.only(
                                        bottom: deviceHeight * (207 / 768),
                                        right: deviceHeight * (172 / 768)),
                                    height: deviceHeight * (190 / 768),
                                    child: AspectRatio(
                                      aspectRatio: 180 / 190,
                                      child: Container(),
                                    ),
                                  );
                          },
                          onWillAccept: (data) {
                            return data == 'monster';
                          },
                          onAccept: (data) {
                            Provider.of<AudioProvider>(context, listen: false)
                                .playSoundEffect("matchCorrect", 0.5);
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
                          builder: (context, List<String> candidateData,
                              rejectedData) {
                            return mirrorAccepted
                                ? Container(
                                    margin: EdgeInsets.only(
                                        top: deviceHeight * (91 / 768),
                                        left: deviceHeight * (120 / 768)),
                                    height: deviceHeight * (146 / 768),
                                    child: Image.asset(
                                        'assets/images/play/mirror.png'),
                                  )
                                : Container(
                                    margin: EdgeInsets.only(
                                        top: deviceHeight * (91 / 768),
                                        left: deviceHeight * (120 / 768)),
                                    height: deviceHeight * (146 / 768),
                                    child: AspectRatio(
                                      aspectRatio: 208 / 146,
                                      child: Container(),
                                    ),
                                  );
                          },
                          onWillAccept: (data) {
                            return data == 'mirror';
                          },
                          onAccept: (data) {
                            Provider.of<AudioProvider>(context, listen: false)
                                .playSoundEffect("matchCorrect", 0.5);
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
                  ],
                ),
              ),
            ),
          ),
          //////////////////////////////////////////////////////////////
          //////////////////////////////////////////////////////////////
          //////////////////////////////////////////////////////////////
          /////////////////////////////////////////////////////////////////
          /////////////////////////////////////////////////////////////////
          /////////////////////////////////////////////////////////////////
          /////////////////////////////////////////////////////////////////
          /////////////////////////////////////////////////////////////////
          /////////////////////////////////////////////////////////////////
          /////////////////////////////////////////////////////////////////
          /////////////////////////////////////////////////////////////////
          /////////////////////////////////////////////////////////////////
          /////////////////////////////////////////////////////////////////
          /////////////////////////////////////////////////////////////////
          /////////////////////////////////////////////////////////////////

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
