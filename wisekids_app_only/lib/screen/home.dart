import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:provider/provider.dart';
import '../provider/dataProvider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: <Widget>[
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
                    Container(
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
                      child: new ClipRRect(
                        borderRadius: BorderRadius.circular(1000),
                        child: Image.asset('assets/images/avatar_' +
                            Provider.of<DataProvider>(context, listen: true)
                                .avatar +
                            '.png'),
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
                                        fontSize: deviceHeight > 500 ? 25 : 15,
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
                        ? deviceHeight * 0.02
                        : deviceHeight * 0.03),
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
                child:
                    SvgPicture.asset('assets/images/theme1/login_button.svg'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
