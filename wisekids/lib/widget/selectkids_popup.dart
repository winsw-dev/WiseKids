import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/dataProvider.dart';
import '../screen/parentalKidsCenter.dart';
import '../screen/parentalConsent.dart';
import 'package:flutter_device_type/flutter_device_type.dart';

class FunkyOverlay extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FunkyOverlayState();
}

class FunkyOverlayState extends State<FunkyOverlay>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    //////////////////////// initialize list of kids profile widgets before it get build by BuildContext
    Provider.of<DataProvider>(context, listen: false)
        .selectKidsPopupWidgetBuilder(context);

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.easeOutExpo);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

  
    
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: Align(
            alignment: Alignment.topRight,
            child: Material(
              color: Colors.transparent,
              child: Container(
                margin: EdgeInsets.only(
                  right: deviceHeight > 500
                      ? deviceWidth * 0.03
                      : deviceWidth * 0.03,
                  top: deviceHeight > 500
                      ? deviceHeight * 0.026 +
                          ((deviceHeight * 0.134) * 0.27) +
                          (deviceWidth * 0.09)
                      : deviceHeight * 0.036 +
                          ((deviceHeight * 0.134) * 0.27) +
                          (deviceWidth * 0.08),
                ),
                child: ScaleTransition(
                  scale: scaleAnimation,
                  child: Container(
                    width: deviceHeight > 500
                        ? (deviceWidth * 0.075) * (178 / 58)
                        : (deviceWidth * 0.065) * (178 / 58),
                    decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0))),
                    child:
                        /* Padding(
                      padding: const EdgeInsets.only(top: 50.0,bottom: 50),
                      child: Text("Well hello there!"),
                    ), */
                        Padding(
                      padding: EdgeInsets.only(
                        top: deviceHeight > 500
                            ? (deviceWidth * 0.075) * (178 / 58) * 0.1
                            : (deviceWidth * 0.065) * (178 / 58) * 0.1,
                        bottom: deviceHeight > 500
                            ? (deviceWidth * 0.075) * (178 / 58) * 0.067
                            : (deviceWidth * 0.065) * (178 / 58) * 0.067,
                        right: deviceHeight > 500
                            ? (deviceWidth * 0.075) * (178 / 58) * 0.067
                            : (deviceWidth * 0.065) * (178 / 58) * 0.067,
                        left: deviceHeight > 500
                            ? (deviceWidth * 0.075) * (178 / 58) * 0.067
                            : (deviceWidth * 0.065) * (178 / 58) * 0.067,
                      ),
                      child: Wrap(
                          children:
                              Provider.of<DataProvider>(context, listen: false)
                                  .selectKidsPopupWidget
                          /* <Widget>[
                          /////////////////////////////////////////// kid1 name
                          Padding(
                            padding: EdgeInsets.only(
                                left: deviceHeight > 500
                                    ? (deviceWidth * 0.075) * (178 / 58) * 0.07
                                    : (deviceWidth * 0.065) *
                                        (178 / 58) *
                                        0.07),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  height: deviceHeight > 500
                                      ? (deviceWidth * 0.075) * 0.45
                                      : (deviceWidth * 0.065) * 0.50,
                                  child: FittedBox(
                                    fit: BoxFit.fitHeight,
                                    child: Text(
                                      Provider.of<DataProvider>(context,
                                                  listen: false)
                                              .displayName[
                                          Provider.of<DataProvider>(context,
                                                  listen: false)
                                              .currentKids],
                                      style: TextStyle(
                                        fontFamily: 'NunitoBold',
                                        //fontSize: deviceHeight > 500 ? 20 : 16,
                                        color:
                                            Color.fromRGBO(69, 223, 224, 1.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //////////////////////////////////////////////////////////////
                          Divider(
                            height: deviceHeight > 500
                                ? (deviceWidth * 0.075) * (178 / 58) * 0.07 * 2
                                : (deviceWidth * 0.065) * (178 / 58) * 0.07 * 2,
                            color: Color.fromRGBO(238, 239, 243, 1.0),
                          ),
                          ////////////////////////////////////////////////////////////// Paretal Area
                          GestureDetector(
                            onTap: () {
                              /////////////////////////////// if consented skip to parentCenter
                              if (Provider.of<DataProvider>(context,
                                      listen: false)
                                  .userAcceptConsent) {
                                Navigator.pop(context);
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return ParentalKidsCenter();
                                    },
                                  ),
                                );
                              } else {
                                ////////////////////// if not consented goto parentConsent
                                Navigator.pop(context);
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return ParentalConsent(
                                        consentDetail:
                                            Provider.of<DataProvider>(context,
                                                    listen: false)
                                                .signinMethod,
                                      );
                                    },
                                  ),
                                );
                              }
                            },
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: deviceHeight > 500
                                          ? (deviceWidth * 0.075) *
                                              (178 / 58) *
                                              0.07
                                          : (deviceWidth * 0.065) *
                                              (178 / 58) *
                                              0.07),
                                  child: Container(
                                    height: deviceHeight > 500
                                        ? (deviceWidth * 0.075) * 0.45
                                        : (deviceWidth * 0.065) * 0.50,
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      height: deviceHeight > 500
                                          ? (deviceWidth * 0.075) * 0.35
                                          : (deviceWidth * 0.065) * 0.40,
                                      child: FittedBox(
                                        fit: BoxFit.fitWidth,
                                        child: Text(
                                          'Parental Area',
                                          style: TextStyle(
                                            fontFamily: 'NunitoRegular',
                                            //fontSize: deviceHeight > 500 ? 20 : 16,
                                            color: Color.fromRGBO(
                                                160, 163, 168, 1.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ], */
                          ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
