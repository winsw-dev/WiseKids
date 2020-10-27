import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'kidsInfo[old].dart';
//import 'package:flutter/services.dart';

class SelectAvatar extends StatefulWidget {
  @override
  _SelectAvatarState createState() => _SelectAvatarState();
}

class _SelectAvatarState extends State<SelectAvatar> {
  final String soundIcon = 'assets/icon/music-and-multimedia.svg';

  ////////////////////////// initial Var ////////////////////////////////////////////
  var boyCharCardProperties = [255, 255, 255, 1.00, 255, 255, 255, 1.00, -8.0]
      .cast<num>(); // R1,G1,B1,A1,R2,G2,B2,A2,spreadRadius
  var girlCharCardProperties =
      [255, 255, 255, 1.00, 255, 255, 255, 1.00, -8.0].cast<num>();
  var catCharCardProperties =
      [255, 255, 255, 1.00, 255, 255, 255, 1.00, -8.0].cast<num>();
  var buttonControl = 0; // 0 => inactive | 1 => active
  var pickedChar = '';

  ////////////////////////////////////////////////////////////////////////////////

  void onPressedCharBoy() {
    setState(() {
      pickedChar = 'Boy';
      buttonControl = 1;
      boyCharCardProperties =
          [69, 223, 224, 1.00, 69, 197, 224, 1.00, -100.0].cast<num>();
      girlCharCardProperties =
          [255, 255, 255, 1.00, 255, 255, 255, 1.00, -8.0].cast<num>();
      catCharCardProperties =
          [255, 255, 255, 1.00, 255, 255, 255, 1.00, -8.0].cast<num>();
    });
  }

  void onPressedCharGirl() {
    setState(() {
      pickedChar = 'Girl';
      buttonControl = 1;
      boyCharCardProperties =
          [255, 255, 255, 1.00, 255, 255, 255, 1.00, -8.0].cast<num>();
      girlCharCardProperties =
          [255, 132, 157, 1.00, 251, 71, 149, 1.00, -100.0].cast<num>();
      catCharCardProperties =
          [255, 255, 255, 1.00, 255, 255, 255, 1.00, -8.0].cast<num>();
    });
  }

  void onPressedCharCat() {
    setState(() {
      pickedChar = 'Cat';
      buttonControl = 1;
      boyCharCardProperties =
          [255, 255, 255, 1.00, 255, 255, 255, 1.00, -8.0].cast<num>();
      girlCharCardProperties =
          [255, 255, 255, 1.00, 255, 255, 255, 1.00, -8.0].cast<num>();
      catCharCardProperties =
          [248, 226, 55, 1.00, 248, 184, 55, 1.00, -100.0].cast<num>();
    });
  }

  @override
  Widget build(BuildContext context) {
    //double screenWidth = MediaQuery.of(context).size.width;
    //double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Row(
              children: <Widget>[
                Container(
                  height: 30,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  //margin: EdgeInsets.only(top: 30),
                  child: SvgPicture.asset(
                    soundIcon,
                    color: Color.fromRGBO(248, 226, 55, 1.00),
                    height: 20.0,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    "Select your avatar",
                    style: TextStyle(
                        fontFamily: 'NunitoBold',
                        fontSize: 19,
                        color: Color.fromRGBO(251, 71, 149, 1.00)),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  height: 21,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ////////////////////////////////////////////////////////////////////////////////////////// Boy card
                Stack(
                  children: <Widget>[
                    AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      curve: Curves.easeOut,
                      decoration: new BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(69, 223, 224, 0.25),
                            blurRadius:
                                15.0, // has the effect of softening the shadow
                            spreadRadius: boyCharCardProperties[
                                8], // has the effect of extending the shadow
                            offset: Offset(
                              0.0, // horizontal, move right 10
                              10.0, // vertical, move down 10
                            ),
                          )
                        ],
                      ),
                      child: Container(
                        child: AnimatedContainer(
                          width: 187,
                          height: 215,
                          duration: Duration(milliseconds: 150),
                          curve: Curves.easeOut,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  stops: [
                                    0.1,
                                    0.8,
                                  ],
                                  colors: [
                                    Color.fromRGBO(
                                        boyCharCardProperties[0],
                                        boyCharCardProperties[1],
                                        boyCharCardProperties[2],
                                        boyCharCardProperties[3]),
                                    Color.fromRGBO(
                                        boyCharCardProperties[4],
                                        boyCharCardProperties[5],
                                        boyCharCardProperties[6],
                                        boyCharCardProperties[7]),
                                  ])),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(24),
                            highlightColor: Color.fromRGBO(69, 223, 224, 0.05),
                            splashColor: Color.fromRGBO(69, 223, 224, 0.5),
                            onTap: onPressedCharBoy,
                            child: AnimatedContainer(
                              //margin: EdgeInsets.all(9),
                              duration: Duration(milliseconds: 100),
                              curve: Curves.easeOut,
                              child: Image.asset(
                                  'assets/images/187x215_boi_character.png'),
                              width: 187,
                              height: 215,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                //////////////////////////////////////////////////////////////////////////////////////////// Girl Card
                Stack(
                  children: <Widget>[
                    AnimatedContainer(
                      margin: EdgeInsets.only(left: 38),
                      duration: Duration(milliseconds: 200),
                      curve: Curves.easeOut,
                      decoration: new BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(254, 71, 149, 0.16),
                            blurRadius:
                                15.0, // has the effect of softening the shadow
                            spreadRadius: girlCharCardProperties[
                                8], // has the effect of extending the shadow
                            offset: Offset(
                              0.0, // horizontal, move right 10
                              10.0, // vertical, move down 10
                            ),
                          )
                        ],
                      ),
                      child: Container(
                        child: AnimatedContainer(
                          width: 187,
                          height: 215,
                          duration: Duration(milliseconds: 150),
                          curve: Curves.easeOut,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  stops: [
                                    0.1,
                                    0.8,
                                  ],
                                  colors: [
                                    Color.fromRGBO(
                                        girlCharCardProperties[0],
                                        girlCharCardProperties[1],
                                        girlCharCardProperties[2],
                                        girlCharCardProperties[3]),
                                    Color.fromRGBO(
                                        girlCharCardProperties[4],
                                        girlCharCardProperties[5],
                                        girlCharCardProperties[6],
                                        girlCharCardProperties[7]),
                                  ])),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 38),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(24),
                          highlightColor: Color.fromRGBO(254, 71, 149, 0.05),
                          splashColor: Color.fromRGBO(255, 135, 157, 0.5),
                          onTap: onPressedCharGirl,
                          child: AnimatedContainer(
                            //margin: EdgeInsets.only(left: 38),
                            duration: Duration(milliseconds: 100),
                            curve: Curves.easeOut,
                            child: Image.asset(
                                'assets/images/187x215_girl_character.png'),
                            width: 187,
                            height: 215,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                ////////////////////////////////////////////////////////////////////////////////////////// Cat card
                Stack(
                  children: <Widget>[
                    AnimatedContainer(
                      margin: EdgeInsets.only(left: 38),
                      duration: Duration(milliseconds: 200),
                      curve: Curves.easeOut,
                      decoration: new BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(248, 226, 55, 0.16),
                            blurRadius:
                                15.0, // has the effect of softening the shadow
                            spreadRadius: catCharCardProperties[
                                8], // has the effect of extending the shadow
                            offset: Offset(
                              0.0, // horizontal, move right 10
                              10.0, // vertical, move down 10
                            ),
                          )
                        ],
                      ),
                      child: Container(
                        child: AnimatedContainer(
                          width: 187,
                          height: 215,
                          duration: Duration(milliseconds: 150),
                          curve: Curves.easeOut,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  stops: [
                                    0.1,
                                    0.8,
                                  ],
                                  colors: [
                                    Color.fromRGBO(
                                        catCharCardProperties[0],
                                        catCharCardProperties[1],
                                        catCharCardProperties[2],
                                        catCharCardProperties[3]),
                                    Color.fromRGBO(
                                        catCharCardProperties[4],
                                        catCharCardProperties[5],
                                        catCharCardProperties[6],
                                        catCharCardProperties[7]),
                                  ])),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 38),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(24),
                          highlightColor: Color.fromRGBO(248, 226, 55, 0.05),
                          splashColor: Color.fromRGBO(248, 226, 55, 0.5),
                          onTap: onPressedCharCat,
                          child: AnimatedContainer(
                            //margin: EdgeInsets.only(left: 38),
                            duration: Duration(milliseconds: 100),
                            curve: Curves.easeOut,
                            child: Image.asset(
                                'assets/images/187x215_Cat_character.png'),
                            width: 187,
                            height: 215,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  height: 15,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IndexedStack(
                  index: buttonControl,
                  children: <Widget>[
                    ///////////////////////////////////////////////////////////////////////////// Disable Button
                    Stack(
                      children: <Widget>[
                        Material(
                          color: Colors.transparent,
                          child: Ink(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(28),
                              color: Color.fromRGBO(237, 237, 243, 1.00),
                            ),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(28),
                              onTap: () {
                                print('pressed');
                              },
                              child: Container(
                                height: 55,
                                width: 138,
                              ),
                            ),
                          ),
                        ),
                        Positioned.fill(
                            child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            child: Text(
                              "SELECT",
                              style: TextStyle(
                                  fontFamily: 'NunitoBold',
                                  fontSize: 14.5,
                                  color: Color.fromRGBO(154, 154, 177, 1.00)),
                            ),
                          ),
                        )),
                      ],
                    ),

                    ///////////////////////////////////////////////////////////////////////////////////// Active button
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => KidsInfo(pickedChar),
                          ),
                        );
                      },
                      child: Stack(
                        children: <Widget>[
                          Container(
                            child: SvgPicture.asset(
                              'assets/icon/Button_Or.svg',
                              height: 55.0,
                            ),
                          ),
                          Positioned.fill(
                              child: Align(
                            alignment: Alignment.center,
                            child: Container(
                              child: Text(
                                "SELECT",
                                style: TextStyle(
                                    fontFamily: 'NunitoBold',
                                    fontSize: 14.5,
                                    color: Color.fromRGBO(255, 255, 255, 1.00)),
                              ),
                            ),
                          )),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
