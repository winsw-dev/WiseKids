import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import './kidsProfile.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:provider/provider.dart';
import '../provider/dataProvider.dart';
import 'home.dart';
import '../widget/addKidsProfile_dialog.dart' as addMoreKidsDialog;

class ParentalKidsCenter extends StatefulWidget {
  @override
  _ParentalKidsCenterState createState() => _ParentalKidsCenterState();
}

class _ParentalKidsCenterState extends State<ParentalKidsCenter> {
  var rating = 0.0;

  void signOut() {
    Provider.of<DataProvider>(context, listen: false).signinMethod == 'Google'
        ? Provider.of<DataProvider>(context, listen: false).signOutGoogle()
        : Provider.of<DataProvider>(context, listen: false).signOutFacebook();
    Navigator.pop(
      context,
      /* MaterialPageRoute(
        builder: (context) => Home(),
      ), */
    );
    Provider.of<DataProvider>(context, listen: false).resetProvider();
    Phoenix.rebirth(context);
  }

  /* void _showAddMoreKisDialog() {
    addMoreKidsDialog.showSlideDialog(
      context: context,
    );
  } */

  @override
  void initState() {
    //////////////////////// Send Build Context of this page to use in provider
    Provider.of<DataProvider>(context, listen: false)
        .getParentalKidsCenterBuildContext(context);
    //////////////////////// initialize list of kids profile widgets before it get build by BuildContext
    Provider.of<DataProvider>(context, listen: false)
        .kidsProfileWidgetBuilder();
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
                  borderRadius:
                      deviceHeight > 500 ? BorderRadius.circular(10) : null,
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        //////////////////////////////// Back Home Btn
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(
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
                        //////////////////////////////// SignOut Btn Tablet size
                        Spacer(),
                        deviceHeight > 500
                            ? GestureDetector(
                                onTap: signOut,
                                child: Container(
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
                              )
                            : Container(
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
                              ),
                      ],
                    ),
                    /////////////////////////////////////////////// All Content

                    Container(
                      height: deviceHeight > 500
                          ? (deviceHeight - (deviceHeight * 0.08)) -
                              ((deviceHeight * 0.93 * 0.08) +
                                  deviceWidth * 0.030)
                          : deviceHeight - (54 + deviceWidth * 0.025),
                      child:
                          NotificationListener<OverscrollIndicatorNotification>(
                        onNotification:
                            (OverscrollIndicatorNotification overscroll) {
                          overscroll.disallowGlow();
                        },
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              /////////////////////////////////// account + kids profile
                              Container(
                                width: deviceHeight > 500
                                    ? deviceWidth * 0.7
                                    : deviceWidth * 0.9,
                                height: deviceHeight > 500
                                    ? (deviceHeight - (deviceHeight * 0.08)) *
                                        0.45
                                    : deviceHeight - (54 + deviceWidth * 0.025),
                                margin: EdgeInsets.only(
                                    left: deviceHeight > 500
                                        ? 0
                                        : deviceWidth * 0.025),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            ///////////////// Account
                                            Container(
                                              height: deviceHeight > 500
                                                  ? (deviceHeight *
                                                              0.93 *
                                                              0.08 +
                                                          deviceWidth * 0.030) *
                                                      0.4
                                                  : (deviceHeight -
                                                          (54 +
                                                              deviceWidth *
                                                                  0.025)) *
                                                      0.11,
                                              child: FittedBox(
                                                fit: BoxFit.fitHeight,
                                                child: Text(
                                                  Provider.of<DataProvider>(
                                                          context,
                                                          listen: false)
                                                      .userName,
                                                  style: TextStyle(
                                                      fontFamily: 'NunitoBold',
                                                      //fontSize: 21,
                                                      color: Color.fromRGBO(
                                                          69, 223, 224, 1.00)),
                                                ),
                                              ),
                                            ),
                                            /////////////// Account Email
                                            Container(
                                              margin: EdgeInsets.only(top: 5),
                                              height: deviceHeight > 500
                                                  ? (deviceHeight *
                                                              0.93 *
                                                              0.08 +
                                                          deviceWidth * 0.030) *
                                                      0.3
                                                  : (54 + deviceWidth * 0.025) *
                                                      0.35,
                                              child: FittedBox(
                                                fit: BoxFit.fitHeight,
                                                child: Text(
                                                  Provider.of<DataProvider>(
                                                          context,
                                                          listen: false)
                                                      .userEmail,
                                                  style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        80, 85, 89, 1.0),
                                                    fontFamily: 'NunitoRegular',
                                                    //fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Spacer(),
                                        ////////////////////////////////////////// Sign Out Btn Phone size
                                        deviceHeight < 500
                                            ? GestureDetector(
                                                onTap: signOut,
                                                child: Container(
                                                  height: deviceHeight > 500
                                                      ? deviceHeight *
                                                          0.93 *
                                                          0.08
                                                      : 54,
                                                  child: AspectRatio(
                                                    aspectRatio: 153 / 54,
                                                    child: SvgPicture.asset(
                                                      'assets/images/parentalKidsCenter/Signout.svg',
                                                      fit: BoxFit.fitHeight,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container()
                                      ],
                                    ),

                                    /////////////// My Kids
                                    Container(
                                      height: deviceHeight > 500
                                          ? (deviceHeight * 0.93 * 0.08 +
                                                  deviceWidth * 0.030) *
                                              0.4
                                          : (deviceHeight -
                                                  (54 + deviceWidth * 0.025)) *
                                              0.11,
                                      margin: EdgeInsets.only(
                                          bottom: 6,
                                          top: deviceHeight > 500
                                              ? (deviceHeight -
                                                      (deviceHeight * 0.08)) *
                                                  0.04
                                              : 25),
                                      child: FittedBox(
                                        fit: BoxFit.fitHeight,
                                        child: Text(
                                          'My Kids',
                                          style: TextStyle(
                                              fontFamily: 'NunitoBold',
                                              //fontSize: 19,
                                              color: Color.fromRGBO(
                                                  69, 223, 224, 1.00)),
                                        ),
                                      ),
                                    ),
                                    ////////////////// Kids Profile

                                    Expanded(
                                      child: NotificationListener<
                                          OverscrollIndicatorNotification>(
                                        onNotification:
                                            (OverscrollIndicatorNotification
                                                overscroll) {
                                          overscroll.disallowGlow();
                                        },
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Container(
                                            child: Consumer<DataProvider>(
                                              builder: (context, provider,
                                                      child) =>
                                                  Row(
                                                      children: provider
                                                          .kidsProfileWidget
                                                      //<Widget>[
                                                      /*  //////////////////////////////////// Kids1 Profile
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: 10,
                                                      bottom: 16,
                                                      right: deviceHeight > 500
                                                          ? 36
                                                          : 25),
                                                  child: AspectRatio(
                                                    aspectRatio: 113 / 129,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      69,
                                                                      223,
                                                                      224,
                                                                      1.00),
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
                                                              69,
                                                              223,
                                                              224,
                                                              1.00),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10))),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: <Widget>[
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    right: 15,
                                                                    left: 15),
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          1000),
                                                              child: Image.asset('assets/images/avatar_' +
                                                                  Provider.of<DataProvider>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .avatar[Provider.of<DataProvider>(
                                                                          context,
                                                                          listen:
                                                                              false).currentKids] +
                                                                  '.png'),
                                                            ),
                                                          ),
                                                          Container(
                                                            height: deviceHeight > 500
                                                                ? (deviceHeight *
                                                                            0.93 *
                                                                            0.08 +
                                                                        deviceWidth *
                                                                            0.030) *
                                                                    0.3
                                                                : (deviceHeight -
                                                                        (54 +
                                                                            deviceWidth *
                                                                                0.025)) *
                                                                    0.09,
                                                            child: FittedBox(
                                                              fit: BoxFit
                                                                  .fitHeight,
                                                              child: Text(
                                                                Provider.of<DataProvider>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .displayName[0],
                                                                style: TextStyle(
                                                                    fontFamily: 'NunitoBold',
                                                                    //fontSize: 21,
                                                                    color: Colors.white),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ), */

                                                      /* ///////////////////////////////////// Add more kids
                                                Provider.of<DataProvider>(context,
                                              listen: false)
                                          .avatar.length < 5 ? GestureDetector(
                                                  onTap: _showAddMoreKisDialog,
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        top: 10,
                                                        bottom: 16,
                                                        right: 16),
                                                    child: AspectRatio(
                                                      aspectRatio: 113 / 129,
                                                      child: DottedBorder(
                                                        color: Color.fromRGBO(
                                                            69, 223, 224, 1.00),
                                                        strokeWidth: 2,
                                                        borderType:
                                                            BorderType.RRect,
                                                        radius:
                                                            Radius.circular(10),
                                                        dashPattern: [10, 4],
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          height:
                                                              double.infinity,
                                                          alignment:
                                                              Alignment.center,
                                                          child: SvgPicture.asset(
                                                              'assets/images/parentalKidsCenter/addMore.svg'),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ):Container(), */
                                                      //],
                                                      ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              /////////////// Let us know what you think about Wisekids!
                              Container(
                                width: deviceHeight > 500
                                    ? deviceWidth * 0.7
                                    : deviceWidth * 0.9,
                                margin: EdgeInsets.only(top: 15),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      height: deviceHeight > 500
                                          ? (deviceHeight * 0.93 * 0.07 +
                                                  deviceWidth * 0.030) *
                                              0.4
                                          : (deviceHeight -
                                                  (54 + deviceWidth * 0.025)) *
                                              0.11,
                                      child: FittedBox(
                                        fit: BoxFit.fitHeight,
                                        child: Text(
                                          'Let us know what you think about Wisekids!',
                                          style: TextStyle(
                                              fontFamily: 'NunitoBold',
                                              //fontSize: 19,
                                              color: Color.fromRGBO(
                                                  69, 223, 224, 1.00)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //////////////////////////////////////////// Review

                              Container(
                                width: deviceHeight > 500
                                    ? deviceWidth * 0.7
                                    : deviceWidth * 0.9,
                                margin: EdgeInsets.only(top: 15),
                                child: Row(
                                  children: <Widget>[
                                    SmoothStarRating(
                                      rating: rating,
                                      size: 40,
                                      color: Colors.yellow,
                                      borderColor:
                                          Color.fromRGBO(219, 222, 227, 1.00),
                                      filledIconData: Icons.star,
                                      halfFilledIconData: Icons.star_half,
                                      defaultIconData: Icons.star,
                                      starCount: 5,
                                      allowHalfRating: false,
                                      spacing: 2.0,
                                      onRatingChanged: (value) {
                                        setState(() {
                                          rating = value;
                                        });
                                      },
                                    ),
                                    ////////////////////// review Btn
                                    Container(
                                      margin: EdgeInsets.only(left: 20),
                                      height: 54,
                                      width: 178,
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromRGBO(69, 223, 224, 1.0),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Stack(
                                        children: <Widget>[
                                          Positioned.fill(
                                              child: Align(
                                            alignment: Alignment.center,
                                            child: FractionallySizedBox(
                                              heightFactor: 0.5,
                                              child: FittedBox(
                                                fit: BoxFit.fitHeight,
                                                child: Text(
                                                  'Leave a Review',
                                                  style: TextStyle(
                                                      fontFamily: 'NunitoBold',
                                                      //fontSize: 19,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 25,
                              )
                            ],
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
    );
  }
}
