import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:provider/provider.dart';
import '../provider/dataProvider.dart';
import '../widget/exerciseScoreBarWidget.dart';

/// Display slide dialog.
///
/// `barrierColor` Color of outside dialog. Defaults to Colors.black.withOpacity(0.7).
///
/// `barrierDismissible` Can be dismissed by tapping outside dialog. Defaults to true.
///
/// `transitionDuration` Duration of slide transition. Defaults to Duration(milliseconds: 300).
///
/// `pillColor` Color of pill inside dialog. Defaults to Colors.blueGrey[200].
///
/// `backgroundColor` Color of dialog background. Defaults to Theme.of(context).canvasColor.
Future<T> showSlideDialog<T>({
  @required BuildContext context,
  @required String book,
  @required int totalTimeRead,
  @required Map firstExerciseScore,
  @required Map secondExerciseScore,
  @required Map thirdExerciseScore,
  @required String kidsReview,
  //@required Widget child,
  Color barrierColor,
  bool barrierDismissible = true,
  Duration transitionDuration = const Duration(milliseconds: 300),
  Color pillColor,
  Color backgroundColor,
}) {
  assert(context != null);
  //assert(child != null);

  return showGeneralDialog(
    context: context,
    pageBuilder: (context, animation1, animation2) {
      return;
    },
    barrierColor: barrierColor ?? Colors.black.withOpacity(0.7),
    barrierDismissible: barrierDismissible,
    barrierLabel: "Dismiss",
    transitionDuration: transitionDuration,
    transitionBuilder: (context, animation1, animation2, widget) {
      final curvedValue = Curves.easeInOut.transform(animation1.value) - 1.0;
      return Transform(
        transform: Matrix4.translationValues(0.0, curvedValue * -300, 0.0),
        child: Opacity(
          opacity: animation1.value,
          child: SlideDialogKidsStatistic(
            book: book,
            firstExerciseScore: firstExerciseScore,
            kidsReview: kidsReview,
            secondExerciseScore: secondExerciseScore,
            thirdExerciseScore: thirdExerciseScore,
            totalTimeRead: totalTimeRead,
            //child: child,
          ),
        ),
      );
    },
  );
}

//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////

class SlideDialogKidsStatistic extends StatefulWidget {
  SlideDialogKidsStatistic(
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
  _SlideDialogKidsStatisticState createState() =>
      _SlideDialogKidsStatisticState();
}

class _SlideDialogKidsStatisticState extends State<SlideDialogKidsStatistic> {
  var avatarSwipeController = new SwiperController();

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

    return AnimatedPadding(
      padding: /* MediaQuery.of(context).viewInsets +  */ EdgeInsets.all(0),
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
        child: Center(
          child: Stack(
            children: <Widget>[
              MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.00),

                /// Lock text Scale Factor
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    //width: deviceWidth,
                    //height: 500,

                    child: Wrap(
                      children: <Widget>[
                        ///////////////////////////////////////// Statistic Content
                        Container(
                          ///////////////////////////////////// width of row content
                          width: deviceWidth * (904 / 1024),
                          //height: deviceHeight * (425 / 768),
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: deviceHeight * (38 / 768),
                                bottom: deviceHeight * (38 / 768),
                                left: deviceWidth * (40 / 1024),
                                right: deviceWidth * (40 / 1024)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Spacer(),
                                    Container(
                                      child: Wrap(
                                        direction: Axis.vertical,
                                        alignment: WrapAlignment.center,
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        children: <Widget>[
                                          /////////////////////// Book Pic
                                          Container(
                                            decoration: new BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Color.fromRGBO(
                                                      69, 223, 224, 0.5),
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
                                                ? deviceHeight * (224 / 768)
                                                : deviceHeight * (280 / 495),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Image.asset(
                                                  'assets/images/kidsProfile/Book/' +
                                                      widget.book.toString() +
                                                      '.png'),
                                            ),
                                          ),
                                          ///////////////////////////////// total time read
                                          Container(
                                              margin: EdgeInsets.only(top: 14),
                                              child: Text(
                                                  widget.totalTimeRead
                                                          .toString() +
                                                      ' minutes in total',
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontFamily:
                                                          'NunitoRegular',
                                                      //fontSize: 21,
                                                      color: Color.fromRGBO(
                                                          80, 85, 89, 1.0)))),
                                        ],
                                      ),
                                    ),
                                    /* Spacer(), */
                                    //////////////////////////////////////////////////////// Book's Name
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: deviceWidth * (50 / 1024),
                                      ),
                                      child: Wrap(
                                        direction: Axis.vertical,
                                        /* crossAxisAlignment:
                                                        CrossAxisAlignment.start, */
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
                                                      fontFamily:
                                                          'NunitoRegular',
                                                      //fontSize: 21,
                                                      color: Color.fromRGBO(
                                                          80, 85, 89, 1.0)))),
                                          //////////////////////////////////////////////////////// EF (Exclusive Functions)
                                          Container(
                                              //margin: EdgeInsets.only(top: 14),
                                              child: Text(
                                                  'EF (Exclusive Function)',
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
                                                      fontFamily:
                                                          'NunitoRegular',
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
                                                      BorderRadius.circular(
                                                          1000),
                                                  child: Container(
                                                    height: 18,
                                                    width: 18,
                                                    color: Color.fromRGBO(
                                                        255, 95, 74, 1.0),
                                                  )),
                                              Container(
                                                  margin:
                                                      EdgeInsets.only(left: 10),
                                                  child: Text(
                                                      'Incorrect Answers',
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontFamily:
                                                              'NunitoRegular',
                                                          //fontSize: 21,
                                                          color: Color.fromRGBO(
                                                              80,
                                                              85,
                                                              89,
                                                              1.0)))),
                                            ],
                                          ),
                                          /////////////// Correct
                                          Wrap(
                                            crossAxisAlignment:
                                                WrapCrossAlignment.center,
                                            children: <Widget>[
                                              ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          1000),
                                                  child: Container(
                                                    height: 18,
                                                    width: 18,
                                                    color: Color.fromRGBO(
                                                        69, 223, 224, 1.0),
                                                  )),
                                              Container(
                                                  margin:
                                                      EdgeInsets.only(left: 10),
                                                  child: Text('Correct Answers',
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontFamily:
                                                              'NunitoRegular',
                                                          //fontSize: 21,
                                                          color: Color.fromRGBO(
                                                              80,
                                                              85,
                                                              89,
                                                              1.0)))),
                                            ],
                                          ),
                                          /////////////// Total Score
                                          Wrap(
                                            crossAxisAlignment:
                                                WrapCrossAlignment.center,
                                            children: <Widget>[
                                              ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          1000),
                                                  child: Container(
                                                    height: 18,
                                                    width: 18,
                                                    color: Color.fromRGBO(
                                                        238, 239, 243, 1.0),
                                                  )),
                                              Container(
                                                  margin:
                                                      EdgeInsets.only(left: 10),
                                                  child: Text('Total Score',
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontFamily:
                                                              'NunitoRegular',
                                                          //fontSize: 21,
                                                          color: Color.fromRGBO(
                                                              80,
                                                              85,
                                                              89,
                                                              1.0)))),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                    /////////////////////////////////////////////////// Exercise Score Column

                                    Wrap(
                                      direction: Axis.vertical,
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
                                          padding: EdgeInsets.only(
                                              bottom: 20, top: 20),
                                          child: Wrap(
                                            children: <Widget>[
                                              //////////////////////// 1st Btn
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(right: 20),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      firstTimeScoreSelected =
                                                          true;
                                                      secondTimeScoreSelected =
                                                          false;
                                                      thirdTimeScoreSelected =
                                                          false;
                                                    });
                                                    exerciseScore();
                                                  },
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            1000),
                                                    child: AnimatedContainer(
                                                      curve:
                                                          Curves.easeInOutExpo,
                                                      duration: Duration(
                                                          milliseconds: 300),
                                                      alignment:
                                                          Alignment.center,
                                                      height: 40,
                                                      width: 40,
                                                      color:
                                                          firstTimeScoreSelected
                                                              ? Color.fromRGBO(
                                                                  69,
                                                                  223,
                                                                  224,
                                                                  1.0)
                                                              : Color.fromRGBO(
                                                                  238,
                                                                  239,
                                                                  243,
                                                                  1.0),
                                                      child:
                                                          FractionallySizedBox(
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
                                                padding:
                                                    EdgeInsets.only(right: 20),
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
                                                        BorderRadius.circular(
                                                            1000),
                                                    child: AnimatedContainer(
                                                      curve:
                                                          Curves.easeInOutExpo,
                                                      duration: Duration(
                                                          milliseconds: 300),
                                                      alignment:
                                                          Alignment.center,
                                                      height: 40,
                                                      width: 40,
                                                      color:
                                                          secondTimeScoreSelected
                                                              ? Color.fromRGBO(
                                                                  69,
                                                                  223,
                                                                  224,
                                                                  1.0)
                                                              : Color.fromRGBO(
                                                                  238,
                                                                  239,
                                                                  243,
                                                                  1.0),
                                                      child:
                                                          FractionallySizedBox(
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
                                                padding:
                                                    EdgeInsets.only(right: 20),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      firstTimeScoreSelected =
                                                          false;
                                                      secondTimeScoreSelected =
                                                          false;
                                                      thirdTimeScoreSelected =
                                                          true;
                                                    });
                                                    exerciseScore();
                                                  },
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            1000),
                                                    child: AnimatedContainer(
                                                      curve:
                                                          Curves.easeInOutExpo,
                                                      duration: Duration(
                                                          milliseconds: 300),
                                                      alignment:
                                                          Alignment.center,
                                                      height: 40,
                                                      width: 40,
                                                      color:
                                                          thirdTimeScoreSelected
                                                              ? Color.fromRGBO(
                                                                  69,
                                                                  223,
                                                                  224,
                                                                  1.0)
                                                              : Color.fromRGBO(
                                                                  238,
                                                                  239,
                                                                  243,
                                                                  1.0),
                                                      child:
                                                          FractionallySizedBox(
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
                                          margin: EdgeInsets.only(
                                              bottom: 15, top: 8),
                                          width: 250,
                                          child: FAProgressBar(
                                            currentValue:
                                                score['firstExercise'],
                                            displayText: '',
                                            maxValue: 10,
                                            borderRadius: 1000,
                                            backgroundColor: Color.fromRGBO(
                                                238, 239, 243, 1.0),
                                            progressColor: Color.fromRGBO(
                                                69, 223, 224, 1.0),
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
                                          margin: EdgeInsets.only(
                                              bottom: 20, top: 8),
                                          width: 250,
                                          child: FAProgressBar(
                                            currentValue:
                                                score['secondExercise'],
                                            displayText: '',
                                            maxValue: 10,
                                            borderRadius: 1000,
                                            backgroundColor: Color.fromRGBO(
                                                238, 239, 243, 1.0),
                                            progressColor: Color.fromRGBO(
                                                69, 223, 224, 1.0),
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
                                                              69,
                                                              223,
                                                              224,
                                                              1.0)))),
                                              /////////////////////////////// Emoji
                                              widget.kidsReview != ''
                                                  ? Container(
                                                      height: 20,
                                                      child: FittedBox(
                                                          fit: BoxFit.fitHeight,
                                                          child: Text(widget
                                                              .kidsReview)))
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
                                    Spacer(),
                                  ],
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
            ],
          ),
        ),
      ),
    );
  }
}

/* class SelectThemeWidget extends StatefulWidget {
  String themePath;
  double deviceHeight;
  bool visible;

  SelectThemeWidget({
    @required this.themePath,
    Key key,
    @required this.deviceHeight,
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
          height: widget.deviceHeight > 500
              ? widget.deviceHeight * 0.08
              : widget.deviceHeight * 0.08,
          child: Image.asset(widget.themePath),
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
} */
