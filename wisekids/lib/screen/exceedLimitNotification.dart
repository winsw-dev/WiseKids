import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flare_flutter/flare.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:image_sequence_animator/image_sequence_animator.dart';
import 'dart:math';

class ExceedLimitNotification extends StatefulWidget {
  @override
  _ExceedLimitNotificationState createState() =>
      _ExceedLimitNotificationState();
}

class _ExceedLimitNotificationState extends State<ExceedLimitNotification> {
  final _textControllerAnswer = TextEditingController();

  int a = 11 + Random().nextInt(99 - 11);
  int b = 11 + Random().nextInt(99 - 11);
  bool alert = false;

  checkAnswer(int answer) {
    if (answer == (a + b)) {
      Navigator.pop(
        context,
      );
    } else {
      setState(() {
        alert = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              height: deviceHeight,
              width: deviceWidth,
              child: Stack(
                children: <Widget>[
                  ///////////////////////////////////// Gradiant Bg
                  Container(
                    width: deviceWidth,
                    height: deviceHeight,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [
                          0.1,
                          1.0
                        ],
                            colors: [
                          Color.fromRGBO(71, 220, 214, 1.0),
                          Color.fromRGBO(132, 207, 78, 1.0),
                        ])),
                  ),
                  /////////////////////// Pattern
                  Container(
                    width: deviceWidth,
                    child: Image.asset(
                      'assets/images/splashScreen/pattern.png',
                      fit: BoxFit.fitWidth,
                    ),
                  ),

                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        children: <Widget>[
                          ////////////////////////////////////////////////////////////////////// Awesome Sign Animation
                          Spacer(),
                          Container(
                              /*  margin: EdgeInsets.only(
                                  top: deviceHeight > 500
                                      ? (deviceHeight * (82 / 768)) -
                                          (deviceHeight * (22 / 768))
                                      : (deviceHeight * (30 / 768)) -
                                          (deviceHeight * (22 / 768))), */
                              height: deviceHeight > 500
                                  ? deviceHeight * (161 / 768)
                                  : deviceHeight * (250 / 768),
                              child: FlareActor(
                                "assets/images/exceedLimtiNotification/awesome.flr",
                                animation: 'animation',
                              )),

                          ///////////////////////////////////////////// You have read for 1 hour. Text
                          Container(
                            height: deviceHeight > 500
                                ? deviceHeight * (161 / 768) * (94 / 161)
                                : deviceHeight * (250 / 768) * (84 / 161),
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                'You have read for 1 hour.\nPlease go take a rest and come back later.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'NunitoRegular',
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          /////////////////////////////////////////////// Parent only Text
                          Spacer(),
                          Container(
                            height: deviceHeight > 500
                                ? deviceHeight * (161 / 768) * (41 / 161)
                                : deviceHeight * (250 / 768) * (41 / 161),
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                'Parent only',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'NunitoExtraBold',
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          ///////////////////////////////////////////// Enter the answer to allow your child to play: Text
                          Container(
                            height: deviceHeight > 500
                                ? deviceHeight * (161 / 768) * (24 / 161)
                                : deviceHeight * (250 / 768) * (24 / 161),
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                'Enter the answer to allow your child to play:',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'NunitoRegular',
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          ///////////////////////////////////////////// Question Text
                          Container(
                            margin: EdgeInsets.only(
                              bottom: deviceHeight > 500
                                  ? deviceHeight * (161 / 768) * (12 / 161)
                                  : deviceHeight * (250 / 768) * (12 / 161),
                            ),
                            height: deviceHeight > 500
                                ? deviceHeight * (161 / 768) * (28 / 161)
                                : deviceHeight * (250 / 768) * (28 / 161),
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                '$a+$b',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'NunitoBold',
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          ////////////////////////////////////////////// Answer TextField
                          ////////////////////////////
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              /////////////////////////////////////////////// alert sign transperant
                              Container(
                                margin: EdgeInsets.only(
                                    right: deviceHeight > 500
                                        ? (deviceHeight * 0.5) * (10 / 381)
                                        : (deviceHeight * 0.85) * (10 / 381)),
                                height: deviceHeight > 500
                                    ? (deviceHeight * 0.5) * (25 / 381)
                                    : (deviceHeight * 0.85) * (25 / 381),
                                width: deviceHeight > 500
                                    ? (deviceHeight * 0.5) * (25 / 381)
                                    : (deviceHeight * 0.85) * (25 / 381),
                              ),
                              //////////////////////////////////////////////// Kids name textfield
                              Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromRGBO(0, 0, 0, 0.16),
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
                                margin: EdgeInsets.only(
                                    top: deviceHeight > 500
                                        ? (deviceHeight * 0.5) * (4 / 381)
                                        : (deviceHeight * 0.85) * (4 / 381)),
                                height: deviceHeight > 500
                                    ? (deviceHeight * 0.5) * (45 / 381)
                                    : (deviceHeight * 0.85) * (45 / 381),
                                child: AspectRatio(
                                  aspectRatio: 222 / 45,
                                  child: TextFormField(
                                    onEditingComplete: () {
                                      checkAnswer(int.parse(
                                          _textControllerAnswer.text));
                                    },
                                    controller: _textControllerAnswer,
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      WhitelistingTextInputFormatter.digitsOnly,
                                      /* 15 */
                                    ],
                                    cursorColor:
                                        Color.fromRGBO(132, 134, 148, 0.50),
                                    decoration:
                                        new InputDecoration /* .collapsed */ (
                                      hintText: /* null */ 'Type your answer...',
                                      hintStyle: TextStyle(
                                          fontSize:
                                              deviceHeight > 500 ? 14 : 12,
                                          color: Color.fromRGBO(
                                              132, 134, 148, 0.5)),
                                      contentPadding:
                                          EdgeInsets.only(left: 15, right: 15),
                                      filled: true,
                                      fillColor:
                                          Color.fromRGBO(255, 255, 255, 1.0),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          borderSide: BorderSide(
                                              width: 2.0,
                                              color: alert
                                                  ? Color.fromRGBO(
                                                      230, 45, 45, 1.0)
                                                  : Colors
                                                      .transparent /* Color.fromRGBO(
                                                              170, 170, 170, 0.14) */
                                              )),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide: BorderSide(
                                            color: alert
                                                ? Color.fromRGBO(
                                                    230, 45, 45, 1.0)
                                                : Colors
                                                    .transparent /* Color.fromRGBO(
                                                            170, 170, 170, 0.14) */
                                            ,
                                            width: 2.0),
                                      ),
                                      /* border: new OutlineInputBorder(

                                          //InputBorder.none,
                                          borderRadius:
                                              new BorderRadius.circular(10),
                                          borderSide: new BorderSide(
                                            color: Colors.teal,
                                          )), */
                                    ),
                                    //textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: deviceHeight > 500 ? 15 : 13,
                                      fontFamily: 'NunitoRegular',
                                      //fontSize: deviceHeight > 500 ? 20 : 16,
                                      color: Color.fromRGBO(80, 85, 89, 1.00),
                                    ),
                                  ),
                                ),
                              ),
                              /////////////////////////////////////////////// alert sign
                              alert
                                  ? Container(
                                      margin: EdgeInsets.only(
                                          left: deviceHeight > 500
                                              ? (deviceHeight * 0.5) *
                                                  (10 / 381)
                                              : (deviceHeight * 0.85) *
                                                  (10 / 381)),
                                      height: deviceHeight > 500
                                          ? (deviceHeight * 0.5) * (25 / 381)
                                          : (deviceHeight * 0.85) * (25 / 381),
                                      child:
                                          /* FittedBox(
                                  fit: BoxFit.contain,
                                  child: */
                                          SvgPicture.asset(
                                        'assets/images/exceedLimtiNotification/alert.svg',
                                      ),
                                      /* ), */
                                    )
                                  : /////////////////////////////////////////////// alert sign transperant
                                  Container(
                                      margin: EdgeInsets.only(
                                          right: deviceHeight > 500
                                              ? (deviceHeight * 0.5) *
                                                  (10 / 381)
                                              : (deviceHeight * 0.85) *
                                                  (10 / 381)),
                                      height: deviceHeight > 500
                                          ? (deviceHeight * 0.5) * (25 / 381)
                                          : (deviceHeight * 0.85) * (25 / 381),
                                      width: deviceHeight > 500
                                          ? (deviceHeight * 0.5) * (25 / 381)
                                          : (deviceHeight * 0.85) * (25 / 381),
                                    ),
                            ],
                          ),
                          //////////////////////////////////////////////// alert text
                          alert
                              ? Container(
                                  margin: EdgeInsets.only(
                                      top: (deviceHeight * 0.5) * (5 / 381)),
                                  height: deviceHeight > 500
                                      ? (deviceHeight * 0.5) * (20 / 381)
                                      : (deviceHeight * 0.85) * (20 / 381),
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Text(
                                      'Wrong answer, please try again',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'NunitoRegular',
                                          color:
                                              Color.fromRGBO(230, 45, 45, 1.0)),
                                    ),
                                  ),
                                )
                              : Container(),
                          Spacer(),
                          Spacer(),
                        ],
                      ),
                    ),
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
                              "assets/images/exceedLimtiNotification/paperShootViolet",
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
