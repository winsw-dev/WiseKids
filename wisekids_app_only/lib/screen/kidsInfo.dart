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

  final scrollController = ScrollController();
  final focus = FocusNode();
  final textControllerName = TextEditingController();
  final textControllerAge = TextEditingController();
  String inputName, inputAge;
  void checkTextField() {
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
        // scroll to bottom
        /* scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: new Duration(milliseconds: 200),
          curve: Curves.easeOut,
        ); */
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    final textInsideBubbleScaleFactorTablet =
        0.72; // [Tablet size] adjust this value to scale how much % u want text inside bubble to match its parent container size
    final textInsideBubbleScaleFactorPhone =
        0.65; // [Phone size] adjust this value to scale how much % u want text inside bubble to match its parent container size

    final bubbleTextLine1HeightConstrainst = deviceHeight > 500
        ? (((deviceWidth - (deviceWidth * 0.357) - deviceWidth * (66 / 1024)) *
                    textInsideBubbleScaleFactorTablet) *
                (217 / 430)) *
            0.4 // *217/430 is try to convert width to height by calculated by textInside bubble aspectRatio 430:217
        : (((deviceWidth - (deviceWidth * 0.3) - deviceWidth * (66 / 1024)) *
                    textInsideBubbleScaleFactorPhone) *
                (217 / 430)) *
            0.4; // 0.4 mean 40% of overall height of text inside bubble container
    final bubbleTextLine2HeightConstrainst = deviceHeight > 500
        ? (((deviceWidth - (deviceWidth * 0.357) - deviceWidth * (66 / 1024)) *
                    textInsideBubbleScaleFactorTablet) *
                (217 / 430)) *
            0.3
        : (((deviceWidth - (deviceWidth * 0.3) - deviceWidth * (66 / 1024)) *
                    textInsideBubbleScaleFactorPhone) *
                (217 / 430)) *
            0.3;
    final bubbleTextLine3HeightConstrainst = deviceHeight > 500
        ? (((deviceWidth - (deviceWidth * 0.357) - deviceWidth * (66 / 1024)) *
                    textInsideBubbleScaleFactorTablet) *
                (217 / 430)) *
            0.3
        : (((deviceWidth - (deviceWidth * 0.3) - deviceWidth * (66 / 1024)) *
                    textInsideBubbleScaleFactorPhone) *
                (217 / 430)) *
            0.3; // so 0.4 + 0.3 + 0.3 = 100% of total height

    return SafeArea(
      top: deviceHeight > 500 ? false : true,
      bottom: false,
      right: false,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            SingleChildScrollView(
              controller: scrollController,
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
                            /* width: deviceHeight > 500
                                ? deviceWidth * 0.107
                                : deviceWidth * 0.08, */
                            height: deviceHeight > 500
                                ? deviceHeight * 0.42
                                : deviceHeight * 0.47,
                            child: AspectRatio(
                              aspectRatio: 118 / 306,
                              child: FittedBox(
                                  fit: BoxFit.fill,
                                  child: Image.asset(
                                      'assets/images/kidsInfo/plantFlipped.png')),
                            ),
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
                            child: AspectRatio(
                              aspectRatio: 58 / 127,
                              child: Image.asset(
                                  'assets/images/kidsInfo/windowCutted.png'),
                            ),
                          )),
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

                    ///////////////////////////////////////////////  Character

                    Container(
                      margin: EdgeInsets.only(
                        left: deviceHeight > 500
                            ? deviceWidth * (100 / 1024)
                            : deviceWidth * (40 / 1024),
                        bottom: deviceHeight > 500
                            ? deviceHeight * (116 / 768)
                            : deviceHeight * (80 / 768),
                      ),
                      width: deviceHeight > 500
                          ? deviceWidth * (358 / 1024)
                          : deviceWidth * (358 / 1024),
                      child: deviceHeight > 500
                          ? Image.asset('assets/images/kidsInfo/' +
                              Provider.of<DataProvider>(context, listen: false)
                                  .avatar[Provider.of<DataProvider>(context, listen: false)
                                  .currentKids] +
                              'Spotlight.png')
                          : Image.asset('assets/images/kidsInfo/' +
                              Provider.of<DataProvider>(context, listen: false)
                                  .avatar[Provider.of<DataProvider>(context, listen: false)
                                  .currentKids] +
                              'SpotlightSmall.png'),
                    ),

                    //////////////////////////// Bubble Speech Frame
                    Container(
                      margin: EdgeInsets.only(
                        top:
                            deviceHeight > 500 ? deviceHeight * (216 / 768) : 0,
                        left: deviceHeight > 500
                            ? deviceWidth * (364 / 1024)
                            : deviceWidth * (320 / 1024),
                        right: deviceWidth * (66 / 1024),
                      ),
                      width: deviceHeight > 500
                          ? deviceWidth -
                              (deviceWidth * 0.357) -
                              deviceWidth * (66 / 1024)
                          : deviceWidth -
                              (deviceWidth * 0.3) -
                              deviceWidth * (66 / 1024),
                      /* height: deviceHeight > 500
                          ? deviceHeight - (deviceHeight * (216 / 768))
                          : deviceHeight - (deviceHeight * 0.2), */
                      child: Column(
                        mainAxisAlignment: deviceHeight > 500
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.center,
                        children: <Widget>[
                         /*  Spacer(), */
                          Container(
                            child: Stack(
                              children: <Widget>[
                                Image.asset(
                                    'assets/images/kidsInfo/bubbleSpeech.png'),

                                ////////////////////////////////////////////// Text Inside Bubble
                                Positioned.fill(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                        left: deviceWidth * (34 / 1024),
                                      ),
                                      /* height: deviceHeight > 500
                                          ? deviceHeight * (217 / 768)
                                          : deviceHeight * (320 / 768), */
                                      width: deviceHeight > 500
                                          ? (deviceWidth -
                                                  (deviceWidth * 0.357) -
                                                  deviceWidth * (66 / 1024)) *
                                              textInsideBubbleScaleFactorTablet
                                          : (deviceWidth -
                                                  (deviceWidth * 0.3) -
                                                  deviceWidth * (66 / 1024)) *
                                              textInsideBubbleScaleFactorPhone,
                                      child: AspectRatio(
                                        aspectRatio: 430 / 217,
                                        child: Container(
                                          //color: Colors.red, //////////////////////// debug text inside bubble frame
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              ////////////////////////////////////////  Hello! Text
                                              Row(
                                                children: <Widget>[
                                                  Container(
                                                    height:
                                                        bubbleTextLine1HeightConstrainst,
                                                    child: FittedBox(
                                                      fit: BoxFit.fitHeight,
                                                      child: Text(
                                                        "Hello!",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'NunitoBlack',
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              ///////////////////////////////////////// My name is
                                              Row(
                                                children: <Widget>[
                                                  Container(
                                                    height:
                                                        bubbleTextLine2HeightConstrainst,
                                                    child: FittedBox(
                                                      fit: BoxFit.fitHeight,
                                                      child: Text(
                                                        "My name is",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'NunitoBold',
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                  //////////////////////////////// Name Textfield Container
                                                  Expanded(
                                                      child: Container(
                                                    height:
                                                        bubbleTextLine2HeightConstrainst,
                                                    //color: Colors.tealAccent, // debug
                                                    child: Stack(
                                                      children: <Widget>[
                                                        //////////////////////// decoration line
                                                        Positioned.fill(
                                                          child: Align(
                                                            alignment: Alignment
                                                                .bottomCenter,
                                                            child: Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                bottom: deviceHeight >
                                                                        500
                                                                    ? ((((deviceWidth - (deviceWidth * 0.357) - deviceWidth * (66 / 1024)) * textInsideBubbleScaleFactorTablet) * (217 / 430)) *
                                                                            0.3) *
                                                                        0.05
                                                                    : ((((deviceWidth - (deviceWidth * 0.3) - deviceWidth * (66 / 1024)) * textInsideBubbleScaleFactorPhone) *
                                                                                (217 / 430)) *
                                                                            0.3) *
                                                                        0.03,
                                                                left: deviceHeight >
                                                                        500
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
                                                                color: Color
                                                                    .fromRGBO(
                                                                        248,
                                                                        226,
                                                                        55,
                                                                        1.00),
                                                              ),
                                                              height: deviceHeight >
                                                                      500
                                                                  ? deviceHeight *
                                                                      0.006
                                                                  : deviceHeight *
                                                                      0.008,
                                                            ),
                                                          ),
                                                        ),
                                                        //////////////////////////// Name input
                                                        Positioned.fill(
                                                          child: Align(
                                                            alignment: Alignment
                                                                .center,
                                                            child: Container(
                                                              //color: Colors.white,
                                                              /* height: deviceHeight >
                                                                      500
                                                                  ? ((((deviceWidth - (deviceWidth * 0.357) - deviceWidth * (66 / 1024)) * textInsideBubbleScaleFactorTablet) *
                                                                              (217 /
                                                                                  430)) *
                                                                          0.3) *
                                                                      0.38
                                                                  : ((((deviceWidth - (deviceWidth * 0.3) - deviceWidth * (66 / 1024)) * textInsideBubbleScaleFactorPhone) *
                                                                              (217 / 430)) *
                                                                          0.3) *
                                                                      0.25, */
                                                              margin: EdgeInsets
                                                                  .only(
                                                                left: deviceHeight >
                                                                        500
                                                                    ? deviceHeight *
                                                                        0.013
                                                                    : deviceHeight *
                                                                        0.02,
                                                              ),
                                                              child:
                                                                  TextFormField(
                                                                onChanged:
                                                                    (text) {
                                                                  checkTextField();
                                                                },
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
                                                                onFieldSubmitted:
                                                                    (v) {
                                                                  FocusScope.of(
                                                                          context)
                                                                      .requestFocus(
                                                                          focus);
                                                                },

                                                                maxLines: 1,

                                                                //autofocus: true,
                                                                cursorColor: Color
                                                                    .fromRGBO(
                                                                        248,
                                                                        226,
                                                                        55,
                                                                        1.00),
                                                                cursorRadius:
                                                                    Radius.circular(
                                                                        20.0),
                                                                cursorWidth: 4,
                                                                decoration: InputDecoration/* .collapsed */(
                                                                  
                                                                    contentPadding: EdgeInsets.symmetric(vertical: -10),
                                                                    isDense: true,
                                                                    border: InputBorder.none,

                                                                    hintText: "",),
                                                                     //delete underline
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'NunitoBold',
                                                                    fontSize:
                                                                        deviceHeight >
                                                                                500
                                                                            ? 50
                                                                            : 35,
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            248,
                                                                            226,
                                                                            55,
                                                                            1.00)),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ))
                                                ],
                                              ),

                                              /////////////////////////////// I'm Text
                                              Row(
                                                children: <Widget>[
                                                  Container(
                                                    height:
                                                        bubbleTextLine3HeightConstrainst,
                                                    child: FittedBox(
                                                      fit: BoxFit.fitHeight,
                                                      child: Container(
                                                        child: Text(
                                                          "I'm",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'NunitoBold',
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  ///////////////////////////////////////////////////////////////////// Age input textfeild
                                                  Container(
                                                    height:
                                                        bubbleTextLine3HeightConstrainst,
                                                    child: Stack(
                                                      children: <Widget>[
                                                        //////////////////////// decoration line
                                                        Positioned.fill(
                                                          child: Align(
                                                            alignment: Alignment
                                                                .bottomCenter,
                                                            child: Container(
                                                              height: deviceHeight >
                                                                      500
                                                                  ? deviceHeight *
                                                                      0.006
                                                                  : deviceHeight *
                                                                      0.008,
                                                              width: deviceHeight >
                                                                      500
                                                                  ? deviceWidth *
                                                                      0.07
                                                                  : deviceWidth *
                                                                      0.07,
                                                              margin: EdgeInsets
                                                                  .only(
                                                                bottom: deviceHeight >
                                                                        500
                                                                    ? ((((deviceWidth - (deviceWidth * 0.357) - deviceWidth * (66 / 1024)) * textInsideBubbleScaleFactorTablet) * (217 / 430)) *
                                                                            0.3) *
                                                                        0.17
                                                                    : ((((deviceWidth - (deviceWidth * 0.3) - deviceWidth * (66 / 1024)) * textInsideBubbleScaleFactorPhone) *
                                                                                (217 / 430)) *
                                                                            0.3) *
                                                                        0.15,
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
                                                                        .circular(
                                                                            24),
                                                                color: Color
                                                                    .fromRGBO(
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
                                                          //color: Colors.white,
                                                          width: deviceHeight >
                                                                  500
                                                              ? deviceWidth *
                                                                  0.07
                                                              : deviceWidth *
                                                                  0.07,
                                                          margin:
                                                              EdgeInsets.only(
                                                            top: deviceHeight >
                                                                    500
                                                                ? ((((deviceWidth - (deviceWidth * 0.357) - deviceWidth * (66 / 1024)) *
                                                                                textInsideBubbleScaleFactorTablet) *
                                                                            (217 /
                                                                                430)) *
                                                                        0.3) *
                                                                    0.38
                                                                : ((((deviceWidth - (deviceWidth * 0.3) - deviceWidth * (66 / 1024)) *
                                                                                textInsideBubbleScaleFactorPhone) *
                                                                            (217 /
                                                                                430)) *
                                                                        0.3) *
                                                                    0.3,
                                                            left: deviceHeight >
                                                                    500
                                                                ? deviceHeight *
                                                                    0.02
                                                                : deviceHeight *
                                                                    0.02,
                                                            right: deviceHeight >
                                                                    500
                                                                ? deviceHeight *
                                                                    0.013
                                                                : deviceHeight *
                                                                    0.02,
                                                            bottom: deviceHeight > 500
                                                                ? ((((deviceWidth - (deviceWidth * 0.357) - deviceWidth * (66 / 1024)) *
                                                                                textInsideBubbleScaleFactorTablet) *
                                                                            (217 /
                                                                                430)) *
                                                                        0.3) *
                                                                    0.2
                                                                : ((((deviceWidth - (deviceWidth * 0.3) - deviceWidth * (66 / 1024)) *
                                                                                textInsideBubbleScaleFactorPhone) *
                                                                            (217 /
                                                                                430)) *
                                                                        0.3) *
                                                                    0.25,
                                                          ),
                                                          child: TextFormField(
                                                            controller:
                                                                textControllerAge,
                                                            onChanged: (text) {
                                                              checkTextField();

                                                              if (text != '') {
                                                                FocusScope.of(
                                                                        context)
                                                                    .requestFocus(
                                                                        FocusNode());
                                                              }
                                                            },
                                                            focusNode: focus,
                                                            inputFormatters: [
                                                              WhitelistingTextInputFormatter
                                                                  .digitsOnly,
                                                              BlacklistingTextInputFormatter(
                                                                  new RegExp(
                                                                      '[0]')),
                                                            ], //blacklist & whitelist char
                                                            keyboardType:
                                                                TextInputType
                                                                    .text,
                                                            textInputAction:
                                                                TextInputAction
                                                                    .done,

                                                            maxLines: 1,
                                                            maxLength: 1,
                                                            buildCounter: (BuildContext
                                                                        context,
                                                                    {int
                                                                        currentLength,
                                                                    int
                                                                        maxLength,
                                                                    bool
                                                                        isFocused}) =>
                                                                null,

                                                            //autofocus: true,
                                                            cursorColor:
                                                                Color.fromRGBO(
                                                                    248,
                                                                    226,
                                                                    55,
                                                                    1.00),
                                                            cursorRadius:
                                                                Radius.circular(
                                                                    20.0),
                                                            cursorWidth: 4,

                                                            decoration:
                                                                InputDecoration
                                                                    /* .collapsed */(contentPadding: EdgeInsets.symmetric(vertical: -20),
                                                                    isDense: true,
                                                                    border: InputBorder.none,
                                                                        hintText:
                                                                            ""), //delete underline
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'NunitoBold',
                                                                fontSize:
                                                                    deviceHeight >
                                                                            500
                                                                        ? 50
                                                                        : 35,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        248,
                                                                        226,
                                                                        55,
                                                                        1.00)),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  ////////////////////////// years old Text
                                                  Container(
                                                    height:
                                                        bubbleTextLine3HeightConstrainst,
                                                    child: FittedBox(
                                                      fit: BoxFit.fitHeight,
                                                      child: Text(
                                                        "years old",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'NunitoBold',
                                                            fontSize:
                                                                deviceHeight >
                                                                        500
                                                                    ? 50
                                                                    : 35,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
//Spacer(),
                          ///////////////////////////////// Button
                          Container(
                            margin: EdgeInsets.only(
                              left: deviceWidth * (36 / 1024),
                            ),
                            height: deviceHeight > 500
                                ? deviceHeight * 0.121
                                : deviceHeight * 0.145,
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
                                                    /* width: deviceHeight > 500
                                                          ? deviceWidth * 0.211
                                                          : deviceWidth * 0.17, */
                                                    child: AspectRatio(
                                                        aspectRatio: 216 / 93),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned.fill(
                                                child: Align(
                                              alignment: Alignment.center,
                                              child: Container(
                                                child: FractionallySizedBox(
                                                  widthFactor: 0.5,
                                                  child: FittedBox(
                                                    fit: BoxFit.fitWidth,
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
                                                              154,
                                                              154,
                                                              177,
                                                              1.00)),
                                                    ),
                                                  ),
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
                                                    Provider.of<DataProvider>(
                                                            context,
                                                            listen: false)
                                                        .setKisdNameAndAge(
                                                            inputName,
                                                            inputAge);

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
                                                    /* width: deviceHeight > 500
                                                          ? deviceWidth * 0.211
                                                          : deviceWidth * 0.17, */
                                                    child: AspectRatio(
                                                      aspectRatio: 216 / 93,
                                                      child: FittedBox(
                                                          fit: BoxFit.fill,
                                                          child: SvgPicture.asset(
                                                              'assets/icon/selectActiveBTN.svg')),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned.fill(
                                                child: Align(
                                              alignment: Alignment.center,
                                              child: GestureDetector(
                                                onTap: () {
                                                  Provider.of<DataProvider>(
                                                            context,
                                                            listen: false)
                                                        .setKisdNameAndAge(
                                                            inputName,
                                                            inputAge);
                                                  Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          FinishSelectAvatar(),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  child: FractionallySizedBox(
                                                    widthFactor: 0.5,
                                                    child: FittedBox(
                                                      fit: BoxFit.fitWidth,
                                                      child: Text(
                                                        "FINISH",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'NunitoExtraBold',
                                                            fontSize:
                                                                deviceHeight >
                                                                        500
                                                                    ? 30
                                                                    : 17,
                                                            color:
                                                                Color.fromRGBO(
                                                                    255,
                                                                    255,
                                                                    255,
                                                                    1.00)),
                                                      ),
                                                    ),
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
                          ),/* Spacer(), */
                        ],
                      ),
                    ),
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
