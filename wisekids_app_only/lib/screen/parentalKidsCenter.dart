import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import './kidsProfile.dart';
import 'package:dotted_border/dotted_border.dart';

import 'home.dart';

class ParentalKidsCenter extends StatefulWidget {
  @override
  _ParentalKidsCenterState createState() => _ParentalKidsCenterState();
}

class _ParentalKidsCenterState extends State<ParentalKidsCenter> {
  var rating = 0.0;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          ///////////////////////////////// gradient Bg
          Container(
            width: deviceWidth,
            height: deviceHeight,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.1, 1.0],
                colors: [
                  Color.fromRGBO(69, 223, 224, 1.00),
                  Color.fromRGBO(133, 207, 76, 1.00)
                ],
              ),
            ),
          ),
          /////////////////////////////// White Card
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Container(
                height: double.infinity,
                width: double.infinity,
                margin: EdgeInsets.all(
                    deviceHeight > 500 ? deviceHeight * 0.04 : 0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        //////////////////////////////// Back Home Btn
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
                            height: deviceHeight > 500
                                ? deviceHeight * 0.93 * 0.04
                                : 30,
                            margin: EdgeInsets.all(deviceHeight > 500
                                ? deviceWidth * 0.015
                                : deviceWidth * 0.025),
                            child: AspectRatio(
                              aspectRatio: 82 / 29,
                              child: SvgPicture.asset(
                                'assets/images/parentalKidsCenter/homeBtn.svg',
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                        ),
                        //////////////////////////////// SignOut
                        Spacer(),
                        Container(
                          height: deviceHeight > 500
                              ? deviceHeight * 0.93 * 0.08
                              : 54,
                          margin: EdgeInsets.only(
                              top: deviceHeight > 500
                                  ? deviceWidth * 0.030
                                  : deviceWidth * 0.025,
                              right: deviceHeight > 500
                                  ? deviceWidth * 0.030
                                  : deviceWidth * 0.025),
                          child: AspectRatio(
                            aspectRatio: 153 / 54,
                            child: SvgPicture.asset(
                              'assets/images/parentalKidsCenter/Signout.svg',
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                      ],
                    ),
                    /////////////////////////////////////////////// Content

                    Container(
                      width: deviceWidth * 0.7,
                      height: deviceHeight > 500
                          ? double.infinity
                          : deviceHeight - (54 + deviceWidth * 0.025),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ///////////////// Account
                          Container(
                            height: deviceHeight > 500
                                ? (deviceHeight * 0.93 * 0.08 +
                                        deviceWidth * 0.030) *
                                    0.4
                                : (deviceHeight - (54 + deviceWidth * 0.025)) *
                                    0.11,
                            child: FittedBox(
                              fit: BoxFit.fitHeight,
                              child: Text(
                                'Account',
                                style: TextStyle(
                                    fontFamily: 'NunitoBold',
                                    //fontSize: 21,
                                    color: Color.fromRGBO(69, 223, 224, 1.00)),
                              ),
                            ),
                          ),

                          /////////////// Account Email
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            height: deviceHeight > 500
                                ? (deviceHeight * 0.93 * 0.08 +
                                        deviceWidth * 0.030) *
                                    0.3
                                : (54 + deviceWidth * 0.025) * 0.35,
                            child: FittedBox(
                              fit: BoxFit.fitHeight,
                              child: Text(
                                'wisekids.psuic@gmail.com',
                                style: TextStyle(
                                  fontFamily: 'NunitoRegular',
                                  //fontSize: 16,
                                ),
                              ),
                            ),
                          ),

                          /////////////// Text My Kids
                          Container(
                            height: deviceHeight > 500
                                ? (deviceHeight * 0.93 * 0.08 +
                                        deviceWidth * 0.030) *
                                    0.4
                                : (deviceHeight - (54 + deviceWidth * 0.025)) *
                                    0.11,
                            margin: EdgeInsets.only(top: 25),
                            child: FittedBox(
                              fit: BoxFit.fitHeight,
                              child: Text(
                                'My Kids',
                                style: TextStyle(
                                    fontFamily: 'NunitoBold',
                                    //fontSize: 19,
                                    color: Color.fromRGBO(69, 223, 224, 1.00)),
                              ),
                            ),
                          ),
                          ////////////////// Kids Profile

                          Expanded(
                            child: NotificationListener<
                                OverscrollIndicatorNotification>(
                              onNotification:
                                  (OverscrollIndicatorNotification overscroll) {
                                overscroll.disallowGlow();
                              },
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: <Widget>[
                                    //////////////////////////////////// Kids Profile frame
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: 10, bottom: 16, right: 25),
                                      child: AspectRatio(
                                        aspectRatio: 113 / 129,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Color.fromRGBO(
                                                      69, 223, 224, 1.00),
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
                                              color: Color.fromRGBO(
                                                  69, 223, 224, 1.00),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              Container(
                                                margin: EdgeInsets.only(
                                                    right: 15, left: 15),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          1000),
                                                  child: Image.asset(
                                                      'assets/images/avatar_boy.png'),
                                                ),
                                              ),
                                              Container(
                                                height: deviceHeight > 500
                                                    ? (deviceHeight *
                                                                0.93 *
                                                                0.08 +
                                                            deviceWidth *
                                                                0.030) *
                                                        0.4
                                                    : (deviceHeight -
                                                            (54 +
                                                                deviceWidth *
                                                                    0.025)) *
                                                        0.09,
                                                child: FittedBox(
                                                  fit: BoxFit.fitHeight,
                                                  child: Text(
                                                    'Todd',
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'NunitoBold',
                                                        //fontSize: 21,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    ///////////////////////////////////// Add more kids
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: 10, bottom: 16, right: 16),
                                      child: AspectRatio(
                                        aspectRatio: 113 / 129,
                                        child: DottedBorder(
                                          color: Color.fromRGBO(
                                              69, 223, 224, 1.00),
                                          strokeWidth: 2,
                                          borderType: BorderType.RRect,
                                          radius: Radius.circular(10),
                                          dashPattern: [10, 4],
                                          child: Container(
                                            width: double.infinity,
                                            height: double.infinity,
                                            alignment: Alignment.center,
                                            child: SvgPicture.asset(
                                                'assets/images/parentalKidsCenter/addMore.svg'),
                                          ),
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
                  ],
                ),
              ),
            ),
          ),
          
        ],
      ),
    );
  }
}
