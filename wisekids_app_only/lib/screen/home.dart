import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flare_flutter/flare_actor.dart';
import '../widget/slide_popup_dialog.dart' as slideDialog;
import 'package:flutter_swiper/flutter_swiper.dart';





import 'package:provider/provider.dart';
import '../provider/dataProvider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> bookShelf = [
    'assets/animation/book2.flr',
    'assets/animation/book3.flr',
    'assets/animation/book4.flr',
    'assets/animation/book5.flr',
    'assets/animation/book6.flr',
    'assets/animation/book7.flr',
    'assets/animation/book1.flr',
  ];

  void _showLoginDialog() {
    slideDialog.showSlideDialog(
      context: context,
      child: Container(
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      top: deviceHeight > 500 ? false : true,
      bottom: false,
      right: false,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            ///////////////////////////////// Theme Mockup
            Consumer<DataProvider>(
              builder: (context, themeProvider, child) =>
                           Container(
                width: deviceWidth,
                height: deviceHeight,
                child: Image.asset(themeProvider.themeData()),
              ),
            ),

            ///////////////////////////////////////////////////////////// Theme1
            //////////////////////// BG
            /* Container(
              width: deviceWidth,
              height: deviceWidth,
              color: Color.fromRGBO(255, 249, 232, 1.00),
            ),
            //////////////////////// BlackBoard
            Positioned.fill(
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.only(
                      top: deviceHeight > 500
                          ? deviceHeight * 0.235
                          : deviceHeight * 0.26),
                  width: deviceHeight > 500 ? deviceWidth : deviceWidth * 0.87,
                  height: deviceHeight > 500
                      ? deviceHeight * 0.6
                      : deviceHeight * 0.7,
                  child: Image.asset(
                    'assets/images/theme1/blackBoard.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),

            //////////////////////// Plant
            Positioned.fill(
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
                  child: Image.asset('assets/images/theme1/plant.png'),
                ),
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
                  child: Image.asset(
                    'assets/images/theme1/desk.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ), */
            ///////////////////////////////////////////////////////////// End of theme 1

            /////////////////////////////////////////////////////////////
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                      top: deviceHeight > 500
                          ? deviceHeight * 0.026
                          : deviceHeight * 0.036,
                      left: deviceHeight > 500
                          ? deviceHeight * 0.03
                          : deviceHeight * 0.04),
                  child: Stack(
                    children: <Widget>[
                      /////////////////////////////////////////////////// Profile overall
                      GestureDetector(
                        onTap: _showLoginDialog,
                        child: Container(
                          width: deviceWidth * 0.13,
                          height: deviceWidth * 0.13,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(1000),
                            border: Border.all(
                                width: deviceHeight > 500 ? 6 : 3,
                                color: Color.fromRGBO(255, 96, 83,
                                    1.00) //                   <--- border width here
                                ),
                          ),
                          child: Consumer<DataProvider>(
                              builder: (context, avatar, child) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(1000),
                              child: Image.asset('assets/images/avatar_' +
                                  avatar.avatar +
                                  '.png'),
                            );
                          }),
                        ),
                      ),

                      ////////////////////////////////////////////////// Star Score overall
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Stack(
                            children: <Widget>[
                              /////////////////////////// Star Score bg
                              Container(
                                width: deviceHeight > 500
                                    ? deviceWidth * 0.093
                                    : deviceWidth * 0.1,
                                height: deviceHeight > 500
                                    ? deviceHeight * 0.04
                                    : deviceHeight * 0.07,
                                child: SvgPicture.asset(
                                    'assets/images/theme1/profileStarSign.svg'),
                              ),
                              /////////////////////////// Star icon
                              Positioned.fill(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        left: deviceHeight > 500
                                            ? deviceWidth * 0.009
                                            : deviceWidth * 0.01),
                                    height: deviceHeight > 500
                                        ? deviceHeight * 0.027
                                        : deviceHeight * 0.047,
                                    child: Image.asset(
                                        'assets/images/theme1/starScore.png'),
                                  ),
                                ),
                              ),
                              ///////////////////////////// Star Amount
                              Positioned.fill(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        right: deviceHeight > 500
                                            ? deviceWidth * 0.011
                                            : deviceWidth * 0.012),
                                    child: Text(
                                      '0',
                                      style: TextStyle(
                                          fontFamily: 'NunitoBold',
                                          fontSize:
                                              deviceHeight > 500 ? 22 : 15,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              ///////////////////////////////
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //////////////////////////////////////// Vocabbulary
                Container(
                  margin: EdgeInsets.only(
                      top: deviceHeight > 500
                          ? deviceHeight * 0.052
                          : deviceHeight * 0.082,
                      left: deviceHeight > 500
                          ? deviceHeight * 0.035
                          : deviceHeight * 0.035),
                  height: deviceHeight > 500
                      ? deviceHeight * 0.123
                      : deviceHeight * 0.193,
                  width: deviceHeight > 500
                      ? deviceHeight * 0.123
                      : deviceHeight * 0.193,
                  child: SvgPicture.asset('assets/icon/vocabulary.svg'),
                ),
                //////////////////////////////////////// Login Btn
                Spacer(),
                Container(
                  width: deviceHeight > 500
                      ? deviceWidth * 0.173
                      : deviceWidth * 0.173,
                  margin: EdgeInsets.only(
                      right: deviceHeight > 500
                          ? deviceWidth * 0.03
                          : deviceWidth * 0.03,
                      top: deviceHeight > 500
                          ? deviceWidth * 0.059
                          : deviceWidth * 0.059),
                  child: Stack(
                    children: <Widget>[
                      SvgPicture.asset('assets/images/theme1/login_button.svg'),
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            margin: EdgeInsets.only(
                                left: deviceHeight > 500
                                    ? deviceWidth * 0.023
                                    : deviceWidth * 0.023,
                                right: deviceHeight > 500
                                    ? deviceWidth * 0.023
                                    : deviceWidth * 0.023),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  'Login',
                                  style: TextStyle(
                                      fontFamily: 'NunitoBlack',
                                      fontSize: deviceHeight > 500 ? 20 : 16,
                                      color: Colors.white),
                                ),
                                Spacer(),
                                Container(
                                  child: SvgPicture.asset(
                                      'assets/icon/arrowRight.svg'),
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
            //////////////////////////////////////////////////////////// BookShelf Swiper
            Container(
              margin: EdgeInsets.only(
                  top: deviceHeight > 500 ? deviceHeight * 0.31 : 155),
              height: deviceHeight > 500 ? deviceHeight * 0.45 : 230,
              width: MediaQuery.of(context).size.width,
              child: new Swiper(
                onTap: (index) {},
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    /* decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black,
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
                          ), */
                    /* margin: EdgeInsets.only(
                        left: 12, right: 12, bottom: 10, top: 10), */
                    //padding: EdgeInsets.only(bottom: 20),
                    child: Container(
                      child: FlareActor(bookShelf[index],
                          animation: 'bookAnimation'),
                    ),
                  );
                },
                itemCount: 7,
                //itemHeight: 206,
                //itemWidth: 147,

                viewportFraction: 0.3,
                scale: 1.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
