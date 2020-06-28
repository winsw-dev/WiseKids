import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import './parentalKidsCenter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import 'package:firebase_auth/firebase_auth.dart';
import '../provider/dataProvider.dart';

import 'home.dart';

class ParentalConsent extends StatefulWidget {
  final String consentDetail;
  ParentalConsent({
    @required this.consentDetail,
  });
  @override
  _ParentalConsentState createState() => _ParentalConsentState();
}

class _ParentalConsentState extends State<ParentalConsent> {
  bool check1 = false;
  bool check2 = false;
  bool check3 = false;
  bool _ignorePointer = false;

  //var consentDetail = 'Google';
  var acceptBtn = false;

  ScrollController _controller;

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      print('########### scroll reach the bottom ##########');
      setState(() {
        acceptBtn = true;
      });
    }
  }

  _acceptBtn() async {
    final _userId = (await FirebaseAuth.instance.currentUser()).uid;
    print('uid = ' + _userId);
/*     await Firestore.instance
        .collection('WiseKidsUser')
        .document(_userId)
        .setData({"acceptedConsent": true}, merge: true); */
    setState(() {
      _ignorePointer = true;
    });
    await Firestore.instance
        .collection('WiseKidsUser')
        .document(_userId)
        .updateData({"acceptedConsent": true});

    Provider.of<DataProvider>(context, listen: false).consentAccepted(true);

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) {
          return ParentalKidsCenter();
        },
      ),
    );

    print('consent accepted');
  }

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    super.initState();
  }

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
          Container(
            height: deviceHeight,
            width: deviceWidth,
            child: Column(
              children: <Widget>[
                Spacer(),
                Container(
                  width: deviceWidth * 0.95,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      //////////////////////////////////// Parental Control Logo
                      Container(
                        margin: EdgeInsets.only(
                          right: deviceWidth * 0.03, /* top: 21 */
                        ),
                        width: deviceHeight > 500
                            ? deviceWidth * 0.4
                            : deviceWidth * 0.45,
                        child: Image.asset(
                            'assets/images/parentalConsent/logoParental.png'),
                      ),
                      Spacer(),
                      //////////////////////////////////// Back Btn
                      IgnorePointer(
                        ignoring: _ignorePointer,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(
                              context,
                              /* MaterialPageRoute(
                                builder: (context) => Home(),
                              ), */
                            );
                          },
                          child: Container(
                            child: SvgPicture.asset(
                                'assets/images/parentalConsent/close.svg'),
                          ),
                        ),
                      ),
                      //////////////////////////////////// spacer
                    ],
                  ),
                ),
                ///////////////////////////////////////// Consent detail white backgroud
                Spacer(),
                Container(
                  width: deviceWidth * 0.95,
                  height: deviceHeight > 500
                      ? deviceHeight * 0.74
                      : deviceHeight * 0.72,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  child: Stack(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          //////////////////////////////////// Consent details
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              margin: EdgeInsets.only(
                                  top: deviceHeight > 500
                                      ? (deviceHeight * 0.74) * 0.037
                                      : (deviceHeight * 0.72) * 0.037,
                                  bottom: deviceHeight > 500
                                      ? (deviceHeight * 0.74) * 0.037
                                      : (deviceHeight * 0.72) * 0.037,
                                  left: deviceHeight > 500
                                      ? (deviceWidth * 0.95) * 0.01
                                      : (deviceWidth * 0.95) * 0.01,
                                  right: deviceHeight > 500
                                      ? (deviceWidth * 0.95) * 0.01
                                      : (deviceWidth * 0.95) * 0.01),
                              child: Theme(
                                data: Theme.of(context).copyWith(
                                    accentColor: Colors.transparent,
                                    highlightColor:
                                        Color.fromRGBO(248, 226, 55, 1.0)),
                                child: NotificationListener<
                                    OverscrollIndicatorNotification>(
                                  onNotification:
                                      (OverscrollIndicatorNotification
                                          overscroll) {
                                    overscroll.disallowGlow();
                                  },
                                  child: Scrollbar(
                                    child: SingleChildScrollView(
                                      controller: _controller,
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            left: deviceHeight > 500
                                                ? (deviceWidth * 0.95) * 0.048
                                                : (deviceWidth * 0.95) * 0.048,
                                            right: deviceHeight > 500
                                                ? (deviceWidth * 0.95) * 0.048
                                                : (deviceWidth * 0.95) * 0.048),
                                        child: Column(
                                          children: <Widget>[
                                            RichText(
                                              text: TextSpan(
                                                  text: '\nParental Consent',
                                                  style: TextStyle(
                                                      fontFamily: 'NunitoBold',
                                                      fontSize:
                                                          deviceHeight > 500
                                                              ? 25
                                                              : 16,
                                                      color: Color.fromRGBO(
                                                          80, 85, 89, 1.00)),
                                                  children: <TextSpan>[
                                                    TextSpan(text: '\n\n'),
                                                    ///////////////////
                                                    TextSpan(
                                                      text: '   Hello Parents! In order to complete your registration and activate your ' +
                                                          widget.consentDetail +
                                                          ' account and enable additional parental controls and other features We invite you to read the words below, and approve them.\n In addition to the',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'NunitoRegular',
                                                          fontSize:
                                                              deviceHeight > 500
                                                                  ? 17
                                                                  : 16,
                                                          color: Color.fromRGBO(
                                                              80,
                                                              85,
                                                              89,
                                                              1.00)),
                                                    ),
                                                    /////////////////// Policy link
                                                    TextSpan(
                                                      text: ' ' +
                                                          widget.consentDetail +
                                                          ' Privacy Policy',
                                                      style: TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .underline,
                                                          fontFamily:
                                                              'NunitoRegular',
                                                          fontSize:
                                                              deviceHeight > 500
                                                                  ? 17
                                                                  : 16,
                                                          color: Colors
                                                              .blueAccent),
                                                      recognizer:
                                                          TapGestureRecognizer()
                                                            ..onTap = () {
                                                              launch(widget
                                                                          .consentDetail ==
                                                                      'Google'
                                                                  ? 'https://www.google.com/policies/privacy/archive/20160325-20160628/'
                                                                  : 'https://www.facebook.com/legal/FB_Work_Privacy');
                                                            },
                                                    ),
                                                    ////////////////////
                                                    TextSpan(
                                                      text:
                                                          ' these terms apply.',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'NunitoRegular',
                                                          fontSize:
                                                              deviceHeight > 500
                                                                  ? 17
                                                                  : 16,
                                                          color: Color.fromRGBO(
                                                              80,
                                                              85,
                                                              89,
                                                              1.00)),
                                                    ),
                                                    ////////////////////
                                                    TextSpan(
                                                      text:
                                                          '\n\nLogging into Wisekids will provide you with access to current and potential parental controls to improve your ability to see and track what your kids are reading in the app. It will also allow you to encourage you and your children to enjoy future customization and reading preferences. We need your permission to give you these present and future benefits, which can be given by clicking \' accept \' below',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'NunitoRegular',
                                                          fontSize:
                                                              deviceHeight > 500
                                                                  ? 17
                                                                  : 16,
                                                          color: Color.fromRGBO(
                                                              80,
                                                              85,
                                                              89,
                                                              1.00)),
                                                    ),
                                                    ////////////////////
                                                    TextSpan(
                                                      text:
                                                          '\n\nInformation we collect',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'NunitoBold',
                                                          fontSize:
                                                              deviceHeight > 500
                                                                  ? 17
                                                                  : 16,
                                                          color: Color.fromRGBO(
                                                              80,
                                                              85,
                                                              89,
                                                              1.00)),
                                                    ),
                                                    ////////////////////
                                                    TextSpan(
                                                      text:
                                                          '\nTo respect your privacy, Wisekids collects only minimal data :',
                                                      style: TextStyle(
                                                          height: 2.5,
                                                          fontFamily:
                                                              'NunitoRegular',
                                                          fontSize:
                                                              deviceHeight > 500
                                                                  ? 17
                                                                  : 16,
                                                          color: Color.fromRGBO(
                                                              80,
                                                              85,
                                                              89,
                                                              1.00)),
                                                    ),
                                                    ////////////////////
                                                    TextSpan(
                                                      text: '\n1.Your basic ' +
                                                          widget.consentDetail +
                                                          ' account information, such as full name and email address.\n2.App information and operation including the application version and crash logs.\n3.Children\'s online profile, which you can build with simple information like name and age.\n4.Children\'s activity and reading statistics.\n\nThe app will collect your basic ' +
                                                          widget.consentDetail +
                                                          ' account information, such as your email address and name, where appropriate, we will collect parental control related information as well as preferences for configuration and reading that you might have allowed in the app.\n\nWisekids gather knowledge based on the use of the app by your kids, as they do when reading a book.',
                                                      style: TextStyle(
                                                          height: 1.5,
                                                          fontFamily:
                                                              'NunitoRegular',
                                                          fontSize:
                                                              deviceHeight > 500
                                                                  ? 17
                                                                  : 16,
                                                          color: Color.fromRGBO(
                                                              80,
                                                              85,
                                                              89,
                                                              1.00)),
                                                    ),

                                                    ////////////////////
                                                    TextSpan(
                                                      text:
                                                          '\n\nThis detail includes :',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'NunitoBold',
                                                          fontSize:
                                                              deviceHeight > 500
                                                                  ? 17
                                                                  : 16,
                                                          color: Color.fromRGBO(
                                                              80,
                                                              85,
                                                              89,
                                                              1.00)),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          '\n\n1. Single feature numbers, such as feature version number and such as a history of reading, and other settings.\n2. Basic overview of how the app is used. time spent, books or pages read.',
                                                      style: TextStyle(
                                                          height: 1.5,
                                                          fontFamily:
                                                              'NunitoRegular',
                                                          fontSize:
                                                              deviceHeight > 500
                                                                  ? 17
                                                                  : 16,
                                                          color: Color.fromRGBO(
                                                              80,
                                                              85,
                                                              89,
                                                              1.00)),
                                                    ),
                                                    ////////////////////
                                                    TextSpan(
                                                      text:
                                                          '\n\nHow we use the information',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'NunitoBold',
                                                          fontSize:
                                                              deviceHeight > 500
                                                                  ? 17
                                                                  : 16,
                                                          color: Color.fromRGBO(
                                                              80,
                                                              85,
                                                              89,
                                                              1.00)),
                                                    ),
                                                    ////////////////////
                                                    TextSpan(
                                                      text: '\n\nWisekids gathers this information to provide your children with a customized reading experience, \nand to enhance our service over time:\n1. We authenticate which ' +
                                                          widget.consentDetail +
                                                          ' account uses the app\n2. We store preferences and provide suggestions\n3. We help your kids locate and read books they love\n4. We give you power over your kids \' profiles and activity.\n5. We defend our service from spam or other malicious actors.\n\nWisekids does not require your children to share or make publicly accessible, personal information with third parties.\n\nWisekids does not share any of the personal data it gathers with third parties.\n\nWisekids acts as a service which is signed in. This means you need to use your account with ' +
                                                          widget.consentDetail +
                                                          ' and we don\'t allow your child to sign in with their account. We use this information to authenticate you as the user of the app and to ensure that you are in charge of the profiles and activity of your children in compliance with your choices. Wisekids will not use the details gathered about your kids for marketing purposes.',
                                                      style: TextStyle(
                                                          height: 1.5,
                                                          fontFamily:
                                                              'NunitoRegular',
                                                          fontSize:
                                                              deviceHeight > 500
                                                                  ? 17
                                                                  : 16,
                                                          color: Color.fromRGBO(
                                                              80,
                                                              85,
                                                              89,
                                                              1.00)),
                                                    ),

                                                    ////////////////////
                                                    TextSpan(
                                                      text: '\n\nYour controls',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'NunitoBold',
                                                          fontSize:
                                                              deviceHeight > 500
                                                                  ? 17
                                                                  : 16,
                                                          color: Color.fromRGBO(
                                                              80,
                                                              85,
                                                              89,
                                                              1.00)),
                                                    ),
                                                    ////////////////////
                                                    TextSpan(
                                                      text: '\n\nWiseKids offers you clarity and control of the data that we collect. You can take any of the following measures:\n\n1. View your children\'s reading activities, unless previously removed.\n2. Delete every child profile and activity\n3. Delete your account and all relevant data like your children\'s profiles\n4. Change or disable parental controls and customizations\n\nIn the \' Activity \' section of the app, you can view the books your kids have recently read. In the app\'s parental settings portion. you can uninstall and reinstall the app on your device to reset the user-specific identifiers used to collect reading and search data, but if you\'ve built children\'s profiles, the data of reading and search will stay connected to each profile until you explicitly remove the history.\n\nYou can uninstall your Wisekids account by following the prompts in the section on parental settings. This will delete all relevant data including the profiles and activities of your children. The parental controls, configuration and browsing preferences associated with your ' +
                                                          widget.consentDetail +
                                                          ' Account can also be modified or removed at any time using the in-product resources we offer.',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'NunitoRegular',
                                                          fontSize:
                                                              deviceHeight > 500
                                                                  ? 17
                                                                  : 16,
                                                          color: Color.fromRGBO(
                                                              80,
                                                              85,
                                                              89,
                                                              1.00)),
                                                    ),
                                                    ////////////////////
                                                    TextSpan(
                                                      text: '\n\nConsent',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'NunitoBold',
                                                          fontSize:
                                                              deviceHeight > 500
                                                                  ? 17
                                                                  : 16,
                                                          color: Color.fromRGBO(
                                                              80,
                                                              85,
                                                              89,
                                                              1.00)),
                                                    ),
                                                    ////////////////////
                                                    TextSpan(
                                                      text: '\n\nBy clicking on the "Accept" button in the app, you accept that you received notification from ' +
                                                          widget.consentDetail +
                                                          ' about the information collection, usage, and disclosure practices related to the use of Wisekids by your children when you sign in. Besides, for the purposes set out above, and in all situations subject to the',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'NunitoRegular',
                                                          fontSize:
                                                              deviceHeight > 500
                                                                  ? 17
                                                                  : 16,
                                                          color: Color.fromRGBO(
                                                              80,
                                                              85,
                                                              89,
                                                              1.00)),
                                                    ),
                                                    /////////////////// Policy link
                                                    TextSpan(
                                                      text: ' ' +
                                                          widget.consentDetail +
                                                          ' Privacy Policy',
                                                      style: TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .underline,
                                                          fontFamily:
                                                              'NunitoRegular',
                                                          fontSize:
                                                              deviceHeight > 500
                                                                  ? 17
                                                                  : 16,
                                                          color: Colors
                                                              .blueAccent),
                                                      recognizer:
                                                          TapGestureRecognizer()
                                                            ..onTap = () {
                                                              launch(widget
                                                                          .consentDetail ==
                                                                      'Google'
                                                                  ? 'https://www.google.com/policies/privacy/archive/20160325-20160628/'
                                                                  : 'https://www.facebook.com/legal/FB_Work_Privacy');
                                                            },
                                                    ),
                                                    ////////////////////
                                                    TextSpan(
                                                      text: '\n\nyou agree to ' +
                                                          widget.consentDetail +
                                                          ' associating the data mentioned above with information from your ' +
                                                          widget.consentDetail +
                                                          ' Account. Finally, you agree to use your ' +
                                                          widget.consentDetail +
                                                          ' account to verify your identity to notify you and obtain any permission required for features and functionalities that we will add in the future. You can revoke your consent at any time by deleting your Wisekids account by following the prompts in the Wisekids app\'s Settings section.\n\nIf you have questions about these terms, you may contact us by email at : \n\nwisekid.psuic@gmail.com\n',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'NunitoRegular',
                                                          fontSize:
                                                              deviceHeight > 500
                                                                  ? 17
                                                                  : 16,
                                                          color: Color.fromRGBO(
                                                              80,
                                                              85,
                                                              89,
                                                              1.00)),
                                                    ),
                                                  ]),
                                            ),
                                            ////////////////////////////////////////// checkbox 1
                                            deviceHeight < 500
                                                ? Column(
                                                    children: <Widget>[
                                                      Row(
                                                        children: <Widget>[
                                                          Theme(
                                                            data: ThemeData(
                                                                unselectedWidgetColor:
                                                                    Color.fromRGBO(
                                                                        69,
                                                                        223,
                                                                        224,
                                                                        1.00)),
                                                            child: Checkbox(
                                                                activeColor: Color
                                                                    .fromRGBO(
                                                                        69,
                                                                        223,
                                                                        224,
                                                                        1.00),
                                                                value: check1,
                                                                onChanged:
                                                                    (bool val) {
                                                                  setState(() {
                                                                    check1 =
                                                                        val;
                                                                  });
                                                                }),
                                                          ),
                                                          Container(
                                                            child: Text(
                                                              'Receive updates about your child\'s reading activity',
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'NunitoRegular',
                                                                  fontSize:
                                                                      deviceHeight >
                                                                              500
                                                                          ? 17
                                                                          : 16,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          80,
                                                                          85,
                                                                          89,
                                                                          1.00)),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      ////////////////////////////////////////// checkbox 2
                                                      Row(
                                                        children: <Widget>[
                                                          Theme(
                                                            data: ThemeData(
                                                                unselectedWidgetColor:
                                                                    Color.fromRGBO(
                                                                        69,
                                                                        223,
                                                                        224,
                                                                        1.00)),
                                                            child: Checkbox(
                                                                activeColor: Color
                                                                    .fromRGBO(
                                                                        69,
                                                                        223,
                                                                        224,
                                                                        1.00),
                                                                value: check2,
                                                                onChanged:
                                                                    (bool val) {
                                                                  setState(() {
                                                                    check2 =
                                                                        val;
                                                                  });
                                                                }),
                                                          ),
                                                          Text(
                                                            'Help us improve Wisekids through feedback surveys and other studies',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'NunitoRegular',
                                                                fontSize:
                                                                    deviceHeight >
                                                                            500
                                                                        ? 17
                                                                        : 16,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        80,
                                                                        85,
                                                                        89,
                                                                        1.00)),
                                                          )
                                                        ],
                                                      ),
                                                      ////////////////////////////////////////// checkbox 3
                                                      Row(
                                                        children: <Widget>[
                                                          Theme(
                                                            data: ThemeData(
                                                                unselectedWidgetColor:
                                                                    Color.fromRGBO(
                                                                        69,
                                                                        223,
                                                                        224,
                                                                        1.00)),
                                                            child: Checkbox(
                                                                activeColor: Color
                                                                    .fromRGBO(
                                                                        69,
                                                                        223,
                                                                        224,
                                                                        1.00),
                                                                value: check3,
                                                                onChanged:
                                                                    (bool val) {
                                                                  setState(() {
                                                                    check3 =
                                                                        val;
                                                                  });
                                                                }),
                                                          ),
                                                          Text(
                                                            'Wisekids product updates, announcements, and newletters',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'NunitoRegular',
                                                                fontSize:
                                                                    deviceHeight >
                                                                            500
                                                                        ? 17
                                                                        : 16,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        80,
                                                                        85,
                                                                        89,
                                                                        1.00)),
                                                          )
                                                        ],
                                                      ),
                                                      //Text('\n'),
                                                      /////////////////////////////////////////
                                                      /////////////////////////////////// active acceptBtn Phone
                                                      deviceHeight < 500 &&
                                                              acceptBtn
                                                          ? Row(
                                                              children: <
                                                                  Widget>[
                                                                Spacer(),
                                                                IgnorePointer(
                                                                  ignoring:
                                                                      _ignorePointer,
                                                                  child:
                                                                      GestureDetector(
                                                                    /////////////////////////////////////// record user accepted consent to database
                                                                    onTap:
                                                                        _acceptBtn,
                                                                    child:
                                                                        Stack(
                                                                      children: <
                                                                          Widget>[
                                                                        Container(
                                                                          child:
                                                                              SvgPicture.asset('assets/images/parentalConsent/accept.svg'),
                                                                        ),
                                                                        Positioned.fill(
                                                                            child: Align(
                                                                                alignment: Alignment.center,
                                                                                child: FractionallySizedBox(
                                                                                  heightFactor: 0.62,
                                                                                  child: Container(
                                                                                    child: FittedBox(
                                                                                      fit: BoxFit.fitHeight,
                                                                                      child: Text(
                                                                                        'Accept',
                                                                                        style: TextStyle(
                                                                                          fontFamily: 'NunitoBlack',
                                                                                          color: Color.fromRGBO(255, 255, 255, 1.00),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ))),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          : Container(),
                                                    ],
                                                  )
                                                : Container(),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          ////////////////////////////////////////// checkbox 1
                          deviceHeight > 500
                              ? Container(
                                  margin: EdgeInsets.only(
                                    left: deviceHeight > 500
                                        ? (deviceWidth * 0.95) * 0.058
                                        : (deviceWidth * 0.95) * 0.058,
                                    right: deviceHeight > 500
                                        ? (deviceWidth * 0.95) * 0.058
                                        : (deviceWidth * 0.95) * 0.058,
                                    bottom: deviceHeight > 500
                                        ? (deviceHeight * 0.74) * 0.037
                                        : (deviceHeight * 0.72) * 0.037,
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Theme(
                                            data: ThemeData(
                                                unselectedWidgetColor:
                                                    Color.fromRGBO(
                                                        69, 223, 224, 1.00)),
                                            child: Checkbox(
                                                activeColor: Color.fromRGBO(
                                                    69, 223, 224, 1.00),
                                                value: check1,
                                                onChanged: (bool val) {
                                                  setState(() {
                                                    check1 = val;
                                                  });
                                                }),
                                          ),
                                          Container(
                                            child: Text(
                                              'Receive updates about your child\'s reading activity',
                                              style: TextStyle(
                                                  fontFamily: 'NunitoRegular',
                                                  fontSize: deviceHeight > 500
                                                      ? 17
                                                      : 16,
                                                  color: Color.fromRGBO(
                                                      80, 85, 89, 1.00)),
                                            ),
                                          )
                                        ],
                                      ),
                                      ////////////////////////////////////////// checkbox 2
                                      Row(
                                        children: <Widget>[
                                          Theme(
                                            data: ThemeData(
                                                unselectedWidgetColor:
                                                    Color.fromRGBO(
                                                        69, 223, 224, 1.00)),
                                            child: Checkbox(
                                                activeColor: Color.fromRGBO(
                                                    69, 223, 224, 1.00),
                                                value: check2,
                                                onChanged: (bool val) {
                                                  setState(() {
                                                    check2 = val;
                                                  });
                                                }),
                                          ),
                                          Text(
                                            'Help us improve Wisekids through feedback surveys and other studies',
                                            style: TextStyle(
                                                fontFamily: 'NunitoRegular',
                                                fontSize: deviceHeight > 500
                                                    ? 17
                                                    : 16,
                                                color: Color.fromRGBO(
                                                    80, 85, 89, 1.00)),
                                          )
                                        ],
                                      ),
                                      ////////////////////////////////////////// checkbox 3
                                      Row(
                                        children: <Widget>[
                                          Theme(
                                            data: ThemeData(
                                                unselectedWidgetColor:
                                                    Color.fromRGBO(
                                                        69, 223, 224, 1.00)),
                                            child: Checkbox(
                                                activeColor: Color.fromRGBO(
                                                    69, 223, 224, 1.00),
                                                value: check3,
                                                onChanged: (bool val) {
                                                  setState(() {
                                                    check3 = val;
                                                  });
                                                }),
                                          ),
                                          Text(
                                            'Wisekids product updates, announcements, and newletters',
                                            style: TextStyle(
                                                fontFamily: 'NunitoRegular',
                                                fontSize: deviceHeight > 500
                                                    ? 17
                                                    : 16,
                                                color: Color.fromRGBO(
                                                    80, 85, 89, 1.00)),
                                          )
                                        ],
                                      ),
                                      /////////////////////////////////////////
                                    ],
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ],
                  ),
                ),
                Spacer(),
                ///////////////////////////////////////// Accept Btn
                deviceHeight > 500
                    ? IndexedStack(
                        index: acceptBtn ? 1 : 0,
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(237, 237, 243, 1.00),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                height: 57.27,
                                width: 179,
                              ),
                              Positioned.fill(
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: FractionallySizedBox(
                                        heightFactor: 0.62,
                                        child: Container(
                                          child: FittedBox(
                                            fit: BoxFit.fitHeight,
                                            child: Text(
                                              'Accept',
                                              style: TextStyle(
                                                fontFamily: 'NunitoBlack',
                                                color: Color.fromRGBO(
                                                    154, 154, 177, 0.80),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ))),
                            ],
                          ),
                          /////////////////////////////////// active
                          IgnorePointer(
                            ignoring: _ignorePointer,
                            child: GestureDetector(
                              /////////////////////////////////////// record user accepted consent to database
                              onTap: _acceptBtn,
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    child: SvgPicture.asset(
                                        'assets/images/parentalConsent/accept.svg'),
                                  ),
                                  Positioned.fill(
                                      child: Align(
                                          alignment: Alignment.center,
                                          child: FractionallySizedBox(
                                            heightFactor: 0.62,
                                            child: Container(
                                              child: FittedBox(
                                                fit: BoxFit.fitHeight,
                                                child: Text(
                                                  'Accept',
                                                  style: TextStyle(
                                                    fontFamily: 'NunitoBlack',
                                                    color: Color.fromRGBO(
                                                        255, 255, 255, 1.00),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ))),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    : Container(),
                deviceHeight > 500 ? Spacer() : Container(),
              ],
            ),
          ),
        ],
      ),

      /* Stack(
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
                            : deviceWidth * 0.018,
                        left: deviceHeight > 500
                            ? deviceWidth * 0.014
                            : deviceWidth * 0.018),
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
      ), */
    );
  }
}
