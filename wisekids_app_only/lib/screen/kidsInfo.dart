import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

class KidsInfo extends StatefulWidget {
  @override
  _KidsInfoState createState() => _KidsInfoState();
}

class _KidsInfoState extends State<KidsInfo> {
  bool _buttonSwitch = false;

  final focus = FocusNode();

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
            Container(
              color: Color.fromRGBO(255, 249, 232, 1.00),
            ),

            ////////////////////////////////////////////// Floor
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: deviceHeight * 0.358,
                  width: deviceWidth,
                  child: FittedBox(
                      fit: BoxFit.fill,
                      child: Image.asset(
                          'assets/images/selectAvatarAssets/floor.png')),
                ),
              ),
            ),

            //////////////////////////////////////////////  Back Button
            Positioned.fill(
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: EdgeInsets.only(
                    top: deviceHeight > 500
                        ? deviceWidth * 0.02
                        : deviceWidth * 0.02,
                    left: deviceHeight > 500
                        ? deviceWidth * 0.02
                        : deviceWidth * 0.02,
                  ),
                  height: deviceHeight > 500
                      ? deviceHeight * 0.104
                      : deviceHeight * 0.15,
                  child: Image.asset('assets/images/kidsInfo/backButton.png'),
                ),
              ),
            ),

            ///////////////////////////////////////////////  Plant
            Positioned.fill(
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: EdgeInsets.only(
                        top: deviceHeight > 500
                            ? deviceHeight * 0.3034
                            : deviceHeight * 0.26),
                    width: deviceHeight > 500
                        ? deviceWidth * 0.107
                        : deviceWidth * 0.08,
                    height: deviceHeight > 500
                        ? deviceHeight * 0.42
                        : deviceHeight * 0.47,
                    child: FittedBox(
                        fit: BoxFit.fill,
                        child: Image.asset(
                            'assets/images/kidsInfo/plantFlipped.png')),
                  )),
            ),

            ///////////////////////////////////////////////  Windows
            Positioned.fill(
              child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    margin: EdgeInsets.only(
                      top: deviceHeight * 0.22,
                    ),
                    height: deviceHeight * 0.17,
                    child:
                        Image.asset('assets/images/kidsInfo/windowCutted.png'),
                  )),
            ),

            ///////////////////////////////////////////////  Character

            Container(
              margin: EdgeInsets.only(
                  left: deviceHeight > 500
                      ? deviceWidth * 0.098
                      : deviceWidth * 0.098),
              height: deviceHeight > 500
                  ? deviceHeight * 0.849
                  : deviceHeight * 0.92,
              child: Image.asset('assets/images/kidsInfo/boySpotlight.png'),
            ),

            //////////////////////////////////////////////////////////
            Container(
              margin: EdgeInsets.only(
                top: deviceHeight > 500
                    ? deviceHeight * 0.277
                    : deviceHeight * 0.12,
                left: deviceHeight > 500
                    ? deviceWidth * 0.357
                    : deviceWidth * 0.3,
                right:
                    deviceHeight > 500 ? deviceWidth * 0.03 : deviceWidth * 0.1,
              ),
              child: Stack(
                children: <Widget>[
                  /////////////////////////////////// Bubble Speech
                  Container(
                    height: deviceHeight > 500
                        ? deviceHeight * 0.446
                        : deviceHeight * 0.646,
                    width: deviceHeight > 500
                        ? deviceWidth * 0.578
                        : deviceWidth * 0.578,
                    child: Stack(
                      children: <Widget>[
                        Image.asset('assets/images/kidsInfo/bubbleSpeech.png'),
                        /////////////////////////////////// Bubble Speech Text
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: deviceHeight>500?deviceWidth*0.38:deviceWidth*0.38,
                              
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  
                                    Row(children: <Widget>[
                                      Container(
                                        
                                        child: Text(
                                          "Hello!",
                                          style: TextStyle(
                                              fontFamily: 'NunitoBlack',
                                              fontSize: deviceHeight>500?60:40,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ]),
                                  
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          child: Text(
                                            "My name is",
                                            style: TextStyle(
                                                fontFamily: 'NunitoBold',
                                                fontSize: deviceHeight>500?46:30,
                                                color: Colors.white),
                                          ),
                                        ),
                                        ///////////////////////////////////////////////////////////////////// Name input text feild
                          Container(
                            
                            width: 125,
                            child: TextFormField(
                              //controller: textControllerName,
                              inputFormatters: [
                                BlacklistingTextInputFormatter(new RegExp(
                                    '[.,0123456789@":;?><()_=/!-*-+#%^&]')),
                              ], //blacklist character
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (v) {
                                FocusScope.of(context).requestFocus(focus);
                              },
                              maxLines: 1,
                              //autofocus: true,
                              cursorColor: Color.fromRGBO(69, 223, 224, 1.00),
                              cursorRadius: Radius.circular(20.0),
                              cursorWidth: 4,
                              decoration: InputDecoration.collapsed(
                                  hintText: ""), //delete underline
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'NunitoBold',
                                  fontSize: 22.5,
                                  color: Color.fromRGBO(69, 223, 224, 1.00)),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              color: Color.fromRGBO(69, 223, 224, 1.00),
                            ),
                            
                            height: 4,
                            width: 125,
                          ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        child: Text(
                                          "I'm",
                                          style: TextStyle(
                                              fontFamily: 'NunitoBold',
                                              fontSize: deviceHeight>500?46:30,
                                              color: Colors.white),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          "years old",
                                          style: TextStyle(
                                              fontFamily: 'NunitoBold',
                                              fontSize: deviceHeight>500?46:30,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  /////////////////////////////////// Button
                  Container(
                    margin: EdgeInsets.only(
                        bottom: deviceHeight > 500
                            ? deviceHeight * 0.14
                            : deviceHeight * 0.09),
                    child:
                        IndexedStack(index: _buttonSwitch ? 1 : 0, children: <
                            Widget>[
                      ////////////////////////////  Disable
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            child: Stack(
                              children: <Widget>[
                                Material(
                                  color: Colors.transparent,
                                  child: Ink(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color:
                                          Color.fromRGBO(237, 237, 243, 1.00),
                                    ),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(50),
                                      onTap: () {
                                        print('pressed');
                                      },
                                      child: Container(
                                        height: deviceHeight > 500
                                            ? deviceHeight * 0.121
                                            : deviceHeight * 0.145,
                                        width: deviceHeight > 500
                                            ? deviceWidth * 0.211
                                            : deviceWidth * 0.17,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned.fill(
                                    child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    child: Text(
                                      "FINISH",
                                      style: TextStyle(
                                          fontFamily: 'NunitoExtraBold',
                                          fontSize:
                                              deviceHeight > 500 ? 24.5 : 17,
                                          color: Color.fromRGBO(
                                              154, 154, 177, 1.00)),
                                    ),
                                  ),
                                )),
                              ],
                            ),
                          ),
                        ),
                      ),

                      ///////////////////////// Enable
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              child: Stack(
                                children: <Widget>[
                                  Material(
                                    color: Colors.transparent,
                                    child: Ink(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        //color: Color.fromRGBO(237, 237, 243, 1.00),
                                      ),
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(50),
                                        onTap: () {
                                          print('pressed');
                                        },
                                        child: Container(
                                          height: deviceHeight > 500
                                              ? deviceHeight * 0.121
                                              : deviceHeight * 0.145,
                                          width: deviceHeight > 500
                                              ? deviceWidth * 0.211
                                              : deviceWidth * 0.17,
                                          child: FittedBox(
                                              fit: BoxFit.fill,
                                              child: SvgPicture.asset(
                                                  'assets/icon/selectActiveBTN.svg')),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned.fill(
                                      child: Align(
                                    alignment: Alignment.center,
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        child: Text(
                                          "FINISH",
                                          style: TextStyle(
                                              fontFamily: 'NunitoExtraBold',
                                              fontSize: deviceHeight > 500
                                                  ? 24.5
                                                  : 17,
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 1.00)),
                                        ),
                                      ),
                                    ),
                                  )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                ],
              ),
            )

            ///////////////////////////////////////////////////// BubbleSpeech

            //////////////////////////////////////////////////////////
          ],
        ),
      ),
    );
  }
}
