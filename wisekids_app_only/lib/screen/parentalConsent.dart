import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import './parentalKidsCenter.dart';

import 'home.dart';

class ParentalConsent extends StatefulWidget {
  @override
  _ParentalConsentState createState() => _ParentalConsentState();
}

class _ParentalConsentState extends State<ParentalConsent> {
  bool check1 = false;
  bool check2 = false;
  bool check3 = false;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          ///////////////////////////////// gradient Bg
          Container(
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
          ////////////////////////////////// Detail Area
          Positioned.fill(
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.only(top: 95),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                width:
                    deviceHeight > 500 ? deviceWidth * 0.9 : deviceWidth * 0.9,
                height: deviceHeight > 500
                    ? deviceHeight * 0.73
                    : deviceHeight * 0.73,
                child:
                    /* SingleChildScrollView(
                  child: Container(
                    height: 334,
                    child: Container(
                      width: 856,
                      child: Image.asset(
                          'assets/images/parentalConsent/consentDetail.png',fit: BoxFit.fitHeight,),
                    ),
                  ),
                ), */
                    Stack(
                  children: <Widget>[
                    /////////////////////////////// Consent Detail
                    Container(
                      height: 334,
                      child: ListView(
                        children: <Widget>[
                          Container(
                            margin:
                                EdgeInsets.only(top: 50, left: 33, right: 33),
                            width: 856,
                            child: Image.asset(
                              'assets/images/parentalConsent/consentDetail.png',
                            ),
                          ),
                        ],
                      ),
                    ),
                    /////////////////////////////// Check Box

                    Container(
                      margin: EdgeInsets.only(top: 377, left: 32),
                      child: Wrap(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Checkbox(
                                  activeColor:
                                      Color.fromRGBO(69, 223, 224, 1.00),
                                  value: check1,
                                  onChanged: (bool val) {
                                    setState(() {
                                      check1 = val;
                                    });
                                  }),
                              Text(
                                'Receive updates about your child\'s reading activity',
                                style: TextStyle(
                                  fontFamily: 'NunitoRegular',
                                  fontSize: deviceHeight > 500 ? 16 : 16,
                                ),
                              )
                            ],
                          ),
                          /////////////////////////////////
                          Row(
                            children: <Widget>[
                              Checkbox(
                                  activeColor:
                                      Color.fromRGBO(69, 223, 224, 1.00),
                                  value: check2,
                                  onChanged: (bool val) {
                                    setState(() {
                                      check2 = val;
                                    });
                                  }),
                              Text(
                                'Help us improve Wisekids through feedback surveys and other studies',
                                style: TextStyle(
                                  fontFamily: 'NunitoRegular',
                                  fontSize: deviceHeight > 500 ? 16 : 16,
                                ),
                              )
                            ],
                          ),
                          ///////////////////////////////
                          Row(
                            children: <Widget>[
                              Checkbox(
                                  activeColor:
                                      Color.fromRGBO(69, 223, 224, 1.00),
                                  value: check3,
                                  onChanged: (bool val) {
                                    setState(() {
                                      check3 = val;
                                    });
                                  }),
                              Text(
                                'Wisekids product updates, announcements, and newletters',
                                style: TextStyle(
                                  fontFamily: 'NunitoRegular',
                                  fontSize: deviceHeight > 500 ? 16 : 16,
                                ),
                              )
                            ],
                          ),
                          ////////////////////////////////////
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          //////////////////////////////////// Back Btn
          Positioned.fill(
            child: Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
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
                        top: deviceHeight > 500
                            ? deviceWidth * 0.014
                            : deviceWidth * 0.014,
                        left: deviceHeight > 500
                            ? deviceWidth * 0.014
                            : deviceWidth * 0.014),
                    child: SvgPicture.asset(
                        'assets/images/parentalConsent/backBtn.svg'),
                  ),
                )),
          ),
          //////////////////////////////////// Parental Control Logo
          Positioned.fill(
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: EdgeInsets.only(right: 52, top: 21),
                width:
                    deviceHeight > 500 ? deviceWidth * 0.4 : deviceWidth * 0.4,
                child: Image.asset(
                    'assets/images/parentalConsent/logoParental.png'),
              ),
            ),
          ),
          //////////////////////////////////// Accept Btn
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ParentalKidsCenter(),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 25),
                  width: 178,
                  height: 57,
                  child: Stack(
                    children: <Widget>[
                      SvgPicture.asset(
                          'assets/images/parentalConsent/accept.svg'),
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Accept',
                            style: TextStyle(
                                fontFamily: 'NunitoBlack',
                                fontSize: deviceHeight > 500 ? 25 : 16,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
