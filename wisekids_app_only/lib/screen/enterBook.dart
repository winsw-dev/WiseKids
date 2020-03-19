import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flare_flutter/flare_actor.dart';

import '../widget/slide_popup_dialog_read.dart' as readDialog;
import './play.dart';

import 'package:provider/provider.dart';
import '../provider/dataProvider.dart';
import 'home.dart';
import 'with_arkit_screen.dart';

class EnterBook extends StatefulWidget {
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

  void _showVocabDialog() {
    readDialog.showSlideDialog(
      context: context,
      child: Container(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          //////////////////////////////////////  Enter Book Theme Bg
          Consumer<DataProvider>(
            builder: (context, theme, child) => Container(
              width: deviceWidth,
              height: deviceHeight,
              child: Image.asset(
                enterBookThemeBg[theme.starScoreBgAndloginBtn],
                fit: BoxFit.fill,
              ),
            ),
          ),

          ///////////////////////////////////////////  Row of Book and Btn
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
                        onTap: (){
                          ////////////////////////////////////////////////// Navigate to AR
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WithARkitScreen(),
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
                                  ? deviceHeight * 0.12
                                  : deviceHeight * 0.12,
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
          ),
          ////////////////////////////////////// Go Home Btn
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Home(),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.only(
                  left: deviceHeight > 500
                      ? deviceHeight * 0.026
                      : deviceHeight * 0.026,
                  top: deviceHeight > 500
                      ? deviceHeight * 0.026
                      : deviceHeight * 0.026),
              height: deviceHeight > 500
                  ? deviceHeight * 0.097
                  : deviceHeight * 0.097,
              child: Image.asset('assets/images/enterBook/homeBtn.png'),
            ),
          ),
        ],
      ),
    );
  }
}
