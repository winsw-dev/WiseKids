import 'dart:math';
import 'dart:async';

import 'package:flare_dart/math/mat2d.dart';
import 'package:flare_flutter/flare.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controller.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';

import 'package:image_sequence_animator/image_sequence_animator.dart';
import '../widget/slide_popup_dialog_read.dart' as readDialog;
import 'package:provider/provider.dart';
import '../provider/dataProvider.dart';
import './home.dart';

class StickerCollected extends StatefulWidget {
  @override
  _StickerCollectedState createState() => _StickerCollectedState();
}

class _StickerCollectedState extends State<StickerCollected> {
  ////////////////////////////////////////////////// All Sticker Controller
  bool _perventMultipleTab = false;

  @override
  void initState() {
    /////////////////////// delay 3.5 second before gestureDetector can tap to exit this page
    Future.delayed(const Duration(milliseconds: 3500), () {
      setState(() {
        _perventMultipleTab = true;
      });
    });
    ////////////////////////// init add tooth sticker widget to list
    //addStickerWidget(_toothloopController, toothOpacity);
    showText();

    super.initState();
  }

  /* @override
  void dispose() {
    super.dispose();
  } */

  final FlareControls _congratSign = FlareControls();

  double textOpacity = 0.0;
  /* @override
   void setState(fn) {
    if(mounted){
      super.setState(fn);
    }
  } */

  showText() async {
    Future.delayed(const Duration(milliseconds: 800), () {
      setState(() {
        textOpacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    // showText();
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            ////////////////////////// BG
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
                    Color.fromRGBO(188, 53, 235, 1.0),
                    Color.fromRGBO(251, 71, 149, 1.0),
                  ])),
            ),
            ////////////////////////////////////////////////////////////////////// CongratSign
            Positioned.fill(
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                    margin: EdgeInsets.only(
                        top: deviceHeight > 500
                            ? (deviceHeight * (82 / 768)) -
                                (deviceHeight * (22 / 768))
                            : (deviceHeight * (30 / 768)) -
                                (deviceHeight * (22 / 768))),
                    height: deviceHeight > 500
                        ? deviceHeight * (161 / 768)
                        : deviceHeight * (250 / 768),
                    child: FlareActor(
                      "assets/animation/CongratSignBounce.flr",
                      animation: 'animation',
                      controller: _congratSign,
                    )),
              ),
            ),

            ////////////////////////////////////////////////////////////////////// Sticker Collected Loop
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      top: deviceHeight > 500
                          ? (deviceHeight * (168 / 768))
                          : (deviceHeight * (126 / 768))),
                  child: Container(
                    width: deviceHeight > 500
                        ? (deviceHeight * (500 / 768) * 2) -
                            deviceHeight * (50 / 500)
                        : (deviceHeight * (600 / 768) * 2) -
                            deviceHeight * (40 / 500),
                    height: deviceHeight > 500
                        ? deviceHeight * (500 / 768)
                        : deviceHeight * (600 / 768),
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.center,
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

                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Home(),
                                        ),
                                      );
                                      readDialog.showSlideDialog(
                                        context: context,
                                        child: Container(),
                                      );
                                    }
                                  : null,
                              child: Container(
                                //margin: EdgeInsets.only(top:deviceHeight>500?(deviceHeight*(82/768))-(deviceHeight*(22/768)):(deviceHeight*(30/768))-(deviceHeight*(22/768))),
                                height: Provider.of<DataProvider>(context,
                                                listen: false)
                                            .deviceHeight >
                                        500
                                    ? Provider.of<DataProvider>(context,
                                                listen: false)
                                            .deviceHeight *
                                        (650 / 768)
                                    : Provider.of<DataProvider>(context,
                                                listen: false)
                                            .deviceHeight *
                                        (600 / 768),
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: FlareActor(
                                    "assets/animation/StickerCollectedLoop.flr",
                                    //controller: _animationLoopController,
                                    animation: 'stickerLoop',
                                    fit: BoxFit.fitHeight,
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
              ],
            ),

            ////////////////////////////// PaperShoot Animation
            Positioned.fill(
              child: Align(
                alignment: Alignment.topRight,
                child: IgnorePointer(
                  ignoringSemantics: true,
                  child: Container(
                    width: deviceWidth,
                    height: deviceHeight,
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: ImageSequenceAnimator(
                        "assets/animation/paperShoot",
                        "ParticlePaperShoot_",
                        0,
                        5,
                        "png",
                        240,
                        isAutoPlay: true,
                        fps: 30,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            //////////////////////////////////// Text
            AnimatedOpacity(
              opacity: textOpacity,
              duration: Duration(milliseconds: 300),
              //curve: Curves.elasticOut,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Spacer(),
                      //////////////////////////////// You found new stickers!
                      Container(
                        height: deviceHeight > 500
                            ? deviceHeight * (32 / 768)
                            : deviceHeight * (50 / 768),
                        child: FittedBox(
                          fit: BoxFit.fitHeight,
                          child: Text(
                            'You found new stickers!',
                            style: TextStyle(
                                fontFamily: 'NunitoBold',
                                fontSize: deviceHeight > 500 ? 30 : 15,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      ///////////////////////////////// You have earned stickers for your vocabulary book.
                      Container(
                        margin: EdgeInsets.only(
                            top: deviceHeight > 500
                                ? deviceHeight * (7 / 768)
                                : deviceHeight * (7 / 768),
                            bottom: deviceHeight > 500
                                ? deviceHeight * (50 / 768)
                                : deviceHeight * (50 / 768)),
                        height: deviceHeight > 500
                            ? deviceHeight * (45 / 768)
                            : deviceHeight * (74 / 768),
                        child: FittedBox(
                          fit: BoxFit.fitHeight,
                          child: Text(
                            'You have earned stickers for your vocabulary book.\nKeep reading to collect them all!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'NunitoRegular',
                                fontSize: deviceHeight > 500 ? 30 : 15,
                                color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            ///////////////////////////////////////////////////// exit stickerCollected page GestureDetector
            GestureDetector(
              onTap: _perventMultipleTab
                  ? () {
                      setState(() {
                        _perventMultipleTab = false;
                      });

                      Timer(Duration(seconds: 1),
                          () => setState(() => _perventMultipleTab = true));

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Home(),
                        ),
                      );
                      readDialog.showSlideDialog(
                        context: context,
                        child: Container(),
                      );
                    }
                  : null,
              child: Container(
                height: deviceHeight,
                width: deviceWidth,
              ),
            ),

            ///////////////////// Back Btn
            /* GestureDetector(
              onTap: () {
                Navigator.pop(
                  context,
                  /* MaterialPageRoute(
                    builder: (context) => EnterBook(),
                  ), */
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
            ), */
          ],
        ),
      ),
    );
  }
}
