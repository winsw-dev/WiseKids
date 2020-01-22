import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _value;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  ////////////////////////////////////////////////////////////////  BG
                  Container(
                    child: Image.asset(
                      'assets/icon/bgPattern.png',
                    ),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      // Box decoration takes a gradient
                      gradient: LinearGradient(
                        // Where the linear gradient begins and ends
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        // Add one stop for each color. Stops should increase from 0 to 1
                        stops: [0.1, 0.32, 1.0],
                        colors: [
                          Color.fromRGBO(
                            69,
                            223,
                            224,
                            1.00,
                          ),
                          Color.fromRGBO(
                            105,
                            214,
                            142,
                            1.00,
                          ),
                          Color.fromRGBO(135, 207, 74, 1.00),
                        ],
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        color: Colors.white,
                        height: MediaQuery.of(context).size.height / 2,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        child: SvgPicture.asset(
                          'assets/images/whiteCloudBG.svg',
                        ),
                      ),
                    ),
                  ),
                  /////////////////////////////////////////////////////////////////////////////// end of BG

                  Container(
                    margin: EdgeInsets.only(top: 20, left: 15),
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.25),
                          blurRadius:
                              15.0, // has the effect of softening the shadow
                          spreadRadius:
                              -5, // has the effect of extending the shadow
                          offset: Offset(
                            0.0, // horizontal, move right 10
                            10.0, // vertical, move down 10
                          ),
                        )
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                        child: Image.asset(
                          'assets/images/avatar_boy.png',
                        ),
                        height: 97,
                        width: 97,
                      ),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 29, left: 148),
                    height: 69,
                    child: SvgPicture.asset(
                      'assets/icon/Vocabuary.svg',
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 29, left: 233),
                    height: 69,
                    child: SvgPicture.asset(
                      'assets/icon/Category.svg',
                    ),
                  ),

                  Container(
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.25),
                          blurRadius:
                              15.0, // has the effect of softening the shadow
                          spreadRadius:
                              -3, // has the effect of extending the shadow
                          offset: Offset(
                            0.0, // horizontal, move right 10
                            0.0, // vertical, move down 10
                          ),
                        )
                      ],
                      color: Color.fromRGBO(248, 226, 55, 1.00),
                    ),
                    margin: EdgeInsets.only(
                      top: 32,
                      left: MediaQuery.of(context).size.width * 0.8025,
                    ),
                    height: 45,
                    width: 148,
                    child: Container(
                      margin: EdgeInsets.only(left: 20,right: 20),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          
                          icon: SvgPicture.asset(
                      'assets/icon/arrowDown.svg',
                    ),
                          onChanged: (String value) {
                            setState(() {
                              _value = value;
                            });
                          },
                          hint: Text(
                            'Login',
                            style: TextStyle(
                                fontFamily: 'NunitoBlack',
                                fontSize: 15,
                                color: Color.fromRGBO(255, 255, 255, 1.00)),
                          ),
                          items: [
                            DropdownMenuItem<String>(
                              child: Text('Item 1'),
                              value: 'one',
                            ),
                            DropdownMenuItem<String>(
                              child: Text('Item 2'),
                              value: 'two',
                            ),
                            DropdownMenuItem<String>(
                              child: Text('Item 3'),
                              value: 'three',
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
