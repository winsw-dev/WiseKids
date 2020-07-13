import 'package:flutter/material.dart';
import '../screen/kidsProfile.dart';
import '../widget/exerciseScoreBarWidget.dart';
import 'package:flutter_emoji/flutter_emoji.dart';

class KidsStatisticPhoneSize extends StatefulWidget {
  KidsStatisticPhoneSize(
      {Key key,
      @required this.book,
      @required this.totalTimeRead,
      @required this.firstExerciseScore,
      @required this.secondExerciseScore,
      @required this.thirdExerciseScore,
      @required this.kidsReview})
      : super(key: key);
  final String book;
  final int totalTimeRead;
  final Map firstExerciseScore;
  final Map secondExerciseScore;
  final Map thirdExerciseScore;
  final String kidsReview;

  @override
  _KidsStatisticPhoneSizeState createState() => _KidsStatisticPhoneSizeState();
}

class _KidsStatisticPhoneSizeState extends State<KidsStatisticPhoneSize> {
  bool firstTimeScoreSelected = true;
  bool secondTimeScoreSelected = false;
  bool thirdTimeScoreSelected = false;

  Map score;
  exerciseScore() {
    setState(() {
      if (firstTimeScoreSelected) {
        score = widget.firstExerciseScore;
      } else if (secondTimeScoreSelected) {
        score = widget.secondExerciseScore;
      } else if (thirdTimeScoreSelected) {
        score = widget.thirdExerciseScore;
      }
    });
  }

  @override
  void initState() {
    // initialize 1st time score
    exerciseScore();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.00),

      /// Lock text Scale Factor
      child: Scaffold(
        ////////////////////// avoid bottom notch pading
        resizeToAvoidBottomPadding: false,
        body: Container(
          width: deviceWidth,
          height: deviceHeight,
          color: Colors.white,
          child: Column(
            children: <Widget>[
              /////////////////////////////////////// Close Btn
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(
                        context,
                      );
                    },
                    child: Container(
                        margin: EdgeInsets.only(
                            top: deviceHeight > 500
                                ? (deviceHeight * 0.5) * 0.04
                                : (deviceHeight * 0.85) * 0.04,
                            right: deviceHeight > 500
                                ? (deviceHeight * 0.5) * 0.04
                                : (deviceHeight * 0.85) * 0.04),
                        height: (deviceHeight * 0.85) * 0.16,
                        child: Image.asset(
                            'assets/images/parentalKidsCenter/addMoreKidsPopup_closeBtn.png')),
                  )
                ],
              ),
              ///////////////////////////////////////// Statistic Content
              Container(
                ///////////////////////////////////// width of row content
                width: deviceWidth * (900 / 1024),
                height: deviceHeight -
                    (((deviceHeight * 0.85) * 0.04) +
                        ((deviceHeight * 0.85) * 0.16)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        /////////////////////// Book Pic
                        Hero(
                          tag: 'book',
                          child: Container(
                            decoration: new BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(69, 223, 224, 0.5),
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
                            ),
                            height: deviceHeight > 500
                                ? deviceHeight * (203 / 768)
                                : deviceHeight * (280 / 495),
                            width: (deviceHeight * (280 / 495)) * (1258 / 1638),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                  'assets/images/kidsProfile/Book/' +
                                      widget.book.toString() +
                                      '.png'),
                            ),
                          ),
                        ),
                        ///////////////////////////////// total time read
                        Container(
                            margin: EdgeInsets.only(top: 14),
                            child: Text(
                                widget.totalTimeRead.toString() +
                                    ' minutes in total',
                                style: TextStyle(
                                    fontSize: 17,
                                    fontFamily: 'NunitoRegular',
                                    //fontSize: 21,
                                    color: Color.fromRGBO(80, 85, 89, 1.0)))),
                      ],
                    ),
                    /* Spacer(), */
                    Container(
                      width: deviceWidth * (900 / 1024) -
                          (deviceHeight * (280 / 495) * (1258 / 1638)),
                      child:
                          NotificationListener<OverscrollIndicatorNotification>(
                        onNotification:
                            (OverscrollIndicatorNotification overscroll) {
                          overscroll.disallowGlow();
                        },
                        child: SingleChildScrollView(
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.start,
                            children: <Widget>[
                              //////////////////////////////////////////////////////// Book's Name
                              Padding(
                                padding: EdgeInsets.only(
                                    left: deviceWidth * (45 / 1024),
                                    bottom: 40),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                        //margin: EdgeInsets.only(top: 14),
                                        child: Text('Candy Monster',
                                            style: TextStyle(
                                                fontSize: 24,
                                                fontFamily: 'NunitoBold',
                                                //fontSize: 21,
                                                color: Color.fromRGBO(
                                                    69, 223, 224, 1.0)))),
                                    //////////////////////////////////////////////////////// Book's Lesson
                                    Container(
                                        margin: EdgeInsets.only(top: 5),
                                        child: Text('Lessons',
                                            style: TextStyle(
                                                fontSize: 21,
                                                fontFamily: 'NunitoBold',
                                                //fontSize: 21,
                                                color: Color.fromRGBO(
                                                    69, 223, 224, 1.0)))),

                                    //////////////////////////////////////////////////////// Lesson Details
                                    Container(
                                        margin: EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        child: Text(
                                            'Counting Number\nNew Vocabularies',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: 'NunitoRegular',
                                                //fontSize: 21,
                                                color: Color.fromRGBO(
                                                    80, 85, 89, 1.0)))),
                                    //////////////////////////////////////////////////////// EF (Exclusive Functions)
                                    Container(
                                        //margin: EdgeInsets.only(top: 14),
                                        child: Text('Exclusive Function',
                                            style: TextStyle(
                                                fontSize: 21,
                                                fontFamily: 'NunitoBold',
                                                //fontSize: 21,
                                                color: Color.fromRGBO(
                                                    69, 223, 224, 1.0)))),
                                    //////////////////////////////////////////////////////// EF Details
                                    Container(
                                        margin: EdgeInsets.only(
                                            top: 10, bottom: 20),
                                        child: Text(
                                            'Working Memory\nInhibition\nSelf-Monitoring',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: 'NunitoRegular',
                                                //fontSize: 21,
                                                color: Color.fromRGBO(
                                                    80, 85, 89, 1.0)))),
                                    //////////////////////////////////////////////////////// Answer Conditions
                                    /////////////// Incorrect
                                    Wrap(
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      children: <Widget>[
                                        ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(1000),
                                            child: Container(
                                              height: 18,
                                              width: 18,
                                              color: Color.fromRGBO(
                                                  255, 95, 74, 1.0),
                                            )),
                                        Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Text('Incorrect Answers',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontFamily: 'NunitoRegular',
                                                    //fontSize: 21,
                                                    color: Color.fromRGBO(
                                                        80, 85, 89, 1.0)))),
                                      ],
                                    ),
                                    /////////////// Correct
                                    Wrap(
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      children: <Widget>[
                                        ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(1000),
                                            child: Container(
                                              height: 18,
                                              width: 18,
                                              color: Color.fromRGBO(
                                                  69, 223, 224, 1.0),
                                            )),
                                        Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Text('Correct Answers',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontFamily: 'NunitoRegular',
                                                    //fontSize: 21,
                                                    color: Color.fromRGBO(
                                                        80, 85, 89, 1.0)))),
                                      ],
                                    ),
                                    /////////////// Total Score
                                    Wrap(
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      children: <Widget>[
                                        ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(1000),
                                            child: Container(
                                              height: 18,
                                              width: 18,
                                              color: Color.fromRGBO(
                                                  238, 239, 243, 1.0),
                                            )),
                                        Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Text('Total Score',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontFamily: 'NunitoRegular',
                                                    //fontSize: 21,
                                                    color: Color.fromRGBO(
                                                        80, 85, 89, 1.0)))),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              /* Spacer(), */
                              /////////////////////////////////////////////////// Exercise Score Column
                              Padding(
                                padding: EdgeInsets.only(
                                    left: deviceWidth * (60 / 1024)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    //////////////////////////////////////////////////////// The last three time exercise score
                                    Container(
                                        child: Text(
                                            'Last 3 times exercise score',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: 'NunitoBold',
                                                //fontSize: 21,
                                                color: Color.fromRGBO(
                                                    69, 223, 224, 1.0)))),
                                    ////////////////////////////////////// last 3 times Btn

                                    Padding(
                                      padding:
                                          EdgeInsets.only(bottom: 20, top: 20),
                                      child: Wrap(
                                        children: <Widget>[
                                          //////////////////////// 1st Btn
                                          Padding(
                                            padding: EdgeInsets.only(right: 20),
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  firstTimeScoreSelected = true;
                                                  secondTimeScoreSelected =
                                                      false;
                                                  thirdTimeScoreSelected =
                                                      false;
                                                });
                                                exerciseScore();
                                              },
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(1000),
                                                child: AnimatedContainer(
                                                  curve: Curves.easeInOutExpo,
                                                  duration: Duration(
                                                      milliseconds: 300),
                                                  alignment: Alignment.center,
                                                  height: 40,
                                                  width: 40,
                                                  color: firstTimeScoreSelected
                                                      ? Color.fromRGBO(
                                                          69, 223, 224, 1.0)
                                                      : Color.fromRGBO(
                                                          238, 239, 243, 1.0),
                                                  child: FractionallySizedBox(
                                                    heightFactor: 26 / 40,
                                                    child: FittedBox(
                                                      fit: BoxFit.fitHeight,
                                                      child: Text('1',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'NunitoExtraBold',
                                                              //fontSize: 21,
                                                              color: Colors
                                                                  .white)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          //////////////////////// 2nd Btn
                                          Padding(
                                            padding: EdgeInsets.only(right: 20),
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  firstTimeScoreSelected =
                                                      false;
                                                  secondTimeScoreSelected =
                                                      true;
                                                  thirdTimeScoreSelected =
                                                      false;
                                                });
                                                exerciseScore();
                                              },
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(1000),
                                                child: AnimatedContainer(
                                                  curve: Curves.easeInOutExpo,
                                                  duration: Duration(
                                                      milliseconds: 300),
                                                  alignment: Alignment.center,
                                                  height: 40,
                                                  width: 40,
                                                  color: secondTimeScoreSelected
                                                      ? Color.fromRGBO(
                                                          69, 223, 224, 1.0)
                                                      : Color.fromRGBO(
                                                          238, 239, 243, 1.0),
                                                  child: FractionallySizedBox(
                                                    heightFactor: 26 / 40,
                                                    child: FittedBox(
                                                      fit: BoxFit.fitHeight,
                                                      child: Text('2',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'NunitoExtraBold',
                                                              //fontSize: 21,
                                                              color: Colors
                                                                  .white)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          //////////////////////// 3rd Btn
                                          Padding(
                                            padding: EdgeInsets.only(right: 20),
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  firstTimeScoreSelected =
                                                      false;
                                                  secondTimeScoreSelected =
                                                      false;
                                                  thirdTimeScoreSelected = true;
                                                });
                                                exerciseScore();
                                              },
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(1000),
                                                child: AnimatedContainer(
                                                  curve: Curves.easeInOutExpo,
                                                  duration: Duration(
                                                      milliseconds: 300),
                                                  alignment: Alignment.center,
                                                  height: 40,
                                                  width: 40,
                                                  color: thirdTimeScoreSelected
                                                      ? Color.fromRGBO(
                                                          69, 223, 224, 1.0)
                                                      : Color.fromRGBO(
                                                          238, 239, 243, 1.0),
                                                  child: FractionallySizedBox(
                                                    heightFactor: 26 / 40,
                                                    child: FittedBox(
                                                      fit: BoxFit.fitHeight,
                                                      child: Text('3',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'NunitoExtraBold',
                                                              //fontSize: 21,
                                                              color: Colors
                                                                  .white)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          ////////////////////////
                                        ],
                                      ),
                                    ),
                                    ////////////////////////////////// 1st Exercise text
                                    Container(
                                        //margin: EdgeInsets.only(left: 10),
                                        child: Text('Counting Number',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: 'NunitoRegular',
                                                //fontSize: 21,
                                                color: Color.fromRGBO(
                                                    80, 85, 89, 1.0)))),
                                    ///////////////////////////////// 1st Exercise score bar
                                    Container(
                                      margin:
                                          EdgeInsets.only(bottom: 15, top: 8),
                                      width: 200,
                                      child: FAProgressBar(
                                        currentValue: score['firstExercise'],
                                        displayText: '',
                                        maxValue: 10,
                                        borderRadius: 1000,
                                        backgroundColor:
                                            Color.fromRGBO(238, 239, 243, 1.0),
                                        progressColor:
                                            Color.fromRGBO(69, 223, 224, 1.0),
                                      ),
                                    ),
                                    ////////////////////////////////// 2nd Exercise text
                                    Container(
                                        //margin: EdgeInsets.only(left: 10),
                                        child: Text('Counting Number',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: 'NunitoRegular',
                                                //fontSize: 21,
                                                color: Color.fromRGBO(
                                                    80, 85, 89, 1.0)))),
                                    ///////////////////////////////// 2nd Exercise score bar
                                    Container(
                                      margin:
                                          EdgeInsets.only(bottom: 20, top: 8),
                                      width: 200,
                                      child: FAProgressBar(
                                        currentValue: score['secondExercise'],
                                        displayText: '',
                                        maxValue: 10,
                                        borderRadius: 1000,
                                        backgroundColor:
                                            Color.fromRGBO(238, 239, 243, 1.0),
                                        progressColor:
                                            Color.fromRGBO(69, 223, 224, 1.0),
                                      ),
                                    ),
                                    ////////////////////////////////// Kids Book review
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 20),
                                      child: Wrap(
                                        children: <Widget>[
                                          Container(
                                              //margin: EdgeInsets.only(left: 10),
                                              child: Text('Kid\'s review: ',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontFamily:
                                                          'NunitoRegular',
                                                      //fontSize: 21,
                                                      color: Color.fromRGBO(
                                                          69, 223, 224, 1.0)))),
                                          /////////////////////////////// Emoji
                                          widget.kidsReview != ''
                                              ? Container(
                                                  height: 20,
                                                  child: FittedBox(
                                                      fit: BoxFit.fitHeight,
                                                      child: Text(
                                                          widget.kidsReview)))
                                              : Container(
                                                  height: 20,
                                                  child: FittedBox(
                                                      fit: BoxFit.fitHeight,
                                                      child: Text('-'))),
                                        ],
                                      ),
                                    ),
                                  ],
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
            ],
          ),
        ),
      ),
    );
  }
}
