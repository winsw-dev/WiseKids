import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

import 'selectAvatar.dart';
import './finishSelectAvatar.dart';

import 'package:provider/provider.dart';
import '../provider/dataProvider.dart';

class KidsInfo extends StatefulWidget {
  @override
  _KidsInfoState createState() => _KidsInfoState();
}

class _KidsInfoState extends State<KidsInfo> {
  bool _buttonSwitch = false;

  final focus = FocusNode();
  final textControllerName = TextEditingController();
  final textControllerAge = TextEditingController();

  void checkTextField() {
    String inputName, inputAge;

    setState(() {
      // Getting Value From Text Field and Store into String Variable
      inputName = textControllerName.text;
      inputAge = textControllerAge.text;

      // Checking all TextFields.
      if (inputName == '' || inputAge == '') {
        // Text Field is Empty.
        _buttonSwitch = false;
      } else {
        // Text Field is NOT Empty.
        _buttonSwitch = true;
      }
    });
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
            SingleChildScrollView(
              child: Container(
                width: deviceWidth,
                height: deviceHeight,
                child: Stack(
                  children: <Widget>[
                    Container(
                      color: Color.fromRGBO(255, 249, 232, 1.00),
                      height: deviceHeight,
                      width: deviceWidth,
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
                              top: deviceHeight > 500
                                  ? deviceHeight * 0.22
                                  : deviceHeight * 0.12,
                            ),
                            height: deviceHeight > 500
                                ? deviceHeight * 0.17
                                : deviceHeight * 0.25,
                            child: Image.asset(
                                'assets/images/kidsInfo/windowCutted.png'),
                          )),
                    ),

                    ///////////////////////////////////////////////  Character

                    Container(
                      margin: EdgeInsets.only(
                          left: deviceHeight > 500
                              ? deviceWidth * 0.09
                              : deviceWidth * 0.098),
                      height: deviceHeight > 500
                          ? deviceHeight * 0.849
                          : deviceHeight * 0.92,
                      child: deviceHeight > 500
                          ? Image.asset('assets/images/kidsInfo/' +
                              Provider.of<DataProvider>(context, listen: false)
                                  .avatar +
                              'Spotlight.png')
                          : Image.asset('assets/images/kidsInfo/' +
                              Provider.of<DataProvider>(context, listen: false)
                                  .avatar +
                              'SpotlightSmall.png'),
                    ),

                    ////////////////////////////////////////////////////// decoration Shelf
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.topRight,
                        child: deviceHeight > 500
                            ? Container(
                                margin: EdgeInsets.only(
                                    top: deviceHeight * 0.117,
                                    right: deviceWidth * 0.136),
                                width: deviceHeight > 500
                                    ? deviceWidth * 0.38
                                    : deviceWidth * 0.14,
                                child: Image.asset(
                                    'assets/images/kidsInfo/decorationShelf.png'),
                              )
                            : null,
                      ),
                    ),

                    ////////////////////////////////////////////////////////// Bubble Speech Overall
                    Container(
                      margin: EdgeInsets.only(
                        top: deviceHeight > 500
                            ? deviceHeight * 0.277
                            : deviceHeight * 0.12,
                        left: deviceHeight > 500
                            ? deviceWidth * 0.357
                            : deviceWidth * 0.3,
                        right: deviceHeight > 500
                            ? deviceWidth * 0.03
                            : deviceWidth * 0.1,
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
                                Container(
                                  height: deviceHeight > 500
                                      ? deviceHeight * 0.446
                                      : deviceHeight * 0.646,
                                  width: deviceHeight > 500
                                      ? deviceWidth * 0.578
                                      : deviceWidth * 0.578,
                                  child: SvgPicture.asset(
                                      'assets/images/kidsInfo/bubbleSpeech.svg'),
                                ),
                                /////////////////////////////////// Bubble Speech Text
                                Positioned.fill(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: deviceHeight > 500
                                              ? deviceWidth * 0.025
                                              : deviceWidth * 0.04),
                                      width: deviceHeight > 500
                                          ? deviceWidth * 0.4
                                          : deviceWidth * 0.38,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Row(children: <Widget>[
                                            Container(
                                              child: Text(
                                                "Hello!",
                                                style: TextStyle(
                                                    fontFamily: 'NunitoBlack',
                                                    fontSize: deviceHeight > 500
                                                        ? 70
                                                        : 45,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ]),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 5),
                                            child: Row(
                                              children: <Widget>[
                                                Container(
                                                  child: Text(
                                                    "My name is",
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'NunitoBold',
                                                        fontSize:
                                                            deviceHeight > 500
                                                                ? 50
                                                                : 35,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                ///////////////////////////////////////////////////////////////////// Name input text feild
                                                Stack(
                                                  children: <Widget>[
                                                    //////////////////////// decoration line
                                                    Positioned.fill(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .bottomCenter,
                                                        child: Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                            bottom: deviceHeight >
                                                                    500
                                                                ? deviceHeight *
                                                                    0.007
                                                                : deviceHeight *
                                                                    0.015,
                                                            left: deviceHeight > 500
                                                                ? deviceWidth *
                                                                    0.01
                                                                : deviceWidth *
                                                                    0.01,
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        24),
                                                            color:
                                                                Color.fromRGBO(
                                                                    248,
                                                                    226,
                                                                    55,
                                                                    1.00),
                                                          ),
                                                          height: deviceHeight > 500
                                                              ? deviceHeight *
                                                                  0.006
                                                              : deviceHeight *
                                                                  0.008,
                                                          width: deviceHeight >
                                                                  500
                                                              ? deviceWidth *
                                                                  0.2
                                                              : deviceWidth *
                                                                  0.2,
                                                        ),
                                                      ),
                                                    ),

                                                    //////////////////////////// Name input
                                                    Container(
                                                      width: deviceHeight > 500
                                                          ? deviceWidth * 0.12
                                                          : deviceWidth * 0.15,
                                                      margin: EdgeInsets.only(
                                                        left: deviceHeight > 500
                                                            ? deviceHeight *
                                                                0.013
                                                            : deviceHeight *
                                                                0.02,
                                                      ),
                                                      child: TextFormField(
                                                        controller:
                                                            textControllerName,
                                                        inputFormatters: [
                                                          BlacklistingTextInputFormatter(
                                                              new RegExp(
                                                                  '[.,0123456789@":;?><()_=/!-*-+#%^&]')),
                                                        ], //blacklist character
                                                        textInputAction:
                                                            TextInputAction
                                                                .next,
                                                        onFieldSubmitted: (v) {
                                                          FocusScope.of(context)
                                                              .requestFocus(
                                                                  focus);
                                                        },
                                                        maxLines: 1,
                                                        //autofocus: true,
                                                        cursorColor:
                                                            Color.fromRGBO(248,
                                                                226, 55, 1.00),
                                                        cursorRadius:
                                                            Radius.circular(
                                                                20.0),
                                                        cursorWidth: 4,
                                                        decoration: InputDecoration
                                                            .collapsed(
                                                                hintText:
                                                                    ""), //delete underline
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'NunitoBold',
                                                            fontSize:
                                                                deviceHeight >
                                                                        500
                                                                    ? 50
                                                                    : 35,
                                                            color:
                                                                Color.fromRGBO(
                                                                    248,
                                                                    226,
                                                                    55,
                                                                    1.00)),
                                                      ),
                                                    ),
                                                  ],
                                                )
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
                                                      fontSize:
                                                          deviceHeight > 500
                                                              ? 50
                                                              : 35,
                                                      color: Colors.white),
                                                ),
                                              ),
                                              ///////////////////////////////////////////////////////////////////// Age input textfeild
                                              Stack(
                                                children: <Widget>[
                                                  //////////////////////// decoration line
                                                  Positioned.fill(
                                                    child: Align(
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      child: Container(
                                                        height:
                                                            deviceHeight > 500
                                                                ? deviceHeight *
                                                                    0.006
                                                                : deviceHeight *
                                                                    0.008,
                                                        width: deviceHeight >
                                                                500
                                                            ? deviceWidth * 0.07
                                                            : deviceWidth *
                                                                0.07,
                                                        margin: EdgeInsets.only(
                                                          bottom: deviceHeight > 500
                                                              ? deviceHeight *
                                                                  0.015
                                                              : deviceHeight *
                                                                  0.04,
                                                          left: deviceHeight >
                                                                  500
                                                              ? deviceWidth *
                                                                  0.001
                                                              : deviceWidth *
                                                                  0.001,
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(24),
                                                          color: Color.fromRGBO(
                                                              248,
                                                              226,
                                                              55,
                                                              1.00),
                                                        ),
                                                      ),
                                                    ),
                                                  ),

                                                  //////////////////////////// Age input
                                                  Container(
                                                    width: deviceHeight > 500
                                                        ? deviceWidth * 0.07
                                                        : deviceWidth * 0.07,
                                                    margin: EdgeInsets.only(
                                                      left: deviceHeight > 500
                                                          ? deviceHeight * 0.013
                                                          : deviceHeight * 0.02,
                                                      right: deviceHeight > 500
                                                          ? deviceHeight * 0.013
                                                          : deviceHeight * 0.02,
                                                    ),
                                                    child: TextFormField(
                                                      controller:
                                                          textControllerAge,
                                                      onFieldSubmitted: (v) {
                                                        checkTextField();
                                                        FocusScope.of(context)
                                                            .requestFocus(
                                                                FocusNode());
                                                      },
                                                      focusNode: focus,
                                                      inputFormatters: [
                                                        WhitelistingTextInputFormatter
                                                            .digitsOnly,
                                                        BlacklistingTextInputFormatter(
                                                            new RegExp('[0]')),
                                                      ], //blacklist & whitelist char
                                                      keyboardType:
                                                          TextInputType.text,
                                                      textInputAction:
                                                          TextInputAction.done,

                                                      maxLines: 1,
                                                      maxLength: 2,
                                                      buildCounter: (BuildContext
                                                                  context,
                                                              {int
                                                                  currentLength,
                                                              int maxLength,
                                                              bool
                                                                  isFocused}) =>
                                                          null,

                                                      //autofocus: true,
                                                      cursorColor:
                                                          Color.fromRGBO(248,
                                                              226, 55, 1.00),
                                                      cursorRadius:
                                                          Radius.circular(20.0),
                                                      cursorWidth: 4,
                                                      decoration: InputDecoration
                                                          .collapsed(
                                                              hintText:
                                                                  ""), //delete underline
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'NunitoBold',
                                                          fontSize:
                                                              deviceHeight > 500
                                                                  ? 50
                                                                  : 35,
                                                          color: Color.fromRGBO(
                                                              248,
                                                              226,
                                                              55,
                                                              1.00)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                child: Text(
                                                  "years old",
                                                  style: TextStyle(
                                                      fontFamily: 'NunitoBold',
                                                      fontSize:
                                                          deviceHeight > 500
                                                              ? 50
                                                              : 35,
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
                            child: IndexedStack(
                                index: _buttonSwitch ? 1 : 0,
                                children: <Widget>[
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
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          500),
                                                  color: Color.fromRGBO(
                                                      237, 237, 243, 1.00),
                                                ),
                                                child: InkWell(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          500),
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
                                                      fontFamily:
                                                          'NunitoExtraBold',
                                                      fontSize:
                                                          deviceHeight > 500
                                                              ? 30
                                                              : 17,
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
                                      child: Container(
                                        child: Stack(
                                          children: <Widget>[
                                            Material(
                                              color: Colors.transparent,
                                              child: Ink(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  //color: Color.fromRGBO(237, 237, 243, 1.00),
                                                ),
                                                child: InkWell(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  onTap: () {
                                                    Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            FinishSelectAvatar(),
                                                      ),
                                                    );
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
                                                onTap: () {
                                                  Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          FinishSelectAvatar(),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  child: Text(
                                                    "FINISH",
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'NunitoExtraBold',
                                                        fontSize:
                                                            deviceHeight > 500
                                                                ? 30
                                                                : 17,
                                                        color: Color.fromRGBO(
                                                            255,
                                                            255,
                                                            255,
                                                            1.00)),
                                                  ),
                                                ),
                                              ),
                                            )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                        ],
                      ),
                    ),

                    ///////////////////////////////////////////////////// BubbleSpeech

                    //////////////////////////////////////////////  screen size Debug
                    /* Positioned.fill(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          margin: EdgeInsets.only(top: 30),
                          child: Text(
                            'width:$deviceWidth height:$deviceHeight',
                            style: TextStyle(
                                fontSize: 20,
                                color: Color.fromRGBO(0, 0, 0, 1.00)),
                          ),
                        ),
                      ),
                    ), */
                    //////////////////////////////////////////////
                    ///
                    //////////////////////////////////////////////////////////
                  ],
                ),
              ),
            ),
            //////////////////////////////////////////////  Back Button
            Positioned.fill(
              child: Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SelectAvatar(),
                      ),
                    );
                  },
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
            ),
          ],
        ),
      ),
    );
  }
}