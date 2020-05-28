import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:provider/provider.dart';
import '../provider/dataProvider.dart';
import './kidsInfo.dart';

class SelectAvatar extends StatefulWidget {
  @override
  _SelectAvatarState createState() => _SelectAvatarState();
}

class _SelectAvatarState extends State<SelectAvatar> {
  ///////// Device Info
  bool ipad = Device.get().isTablet;

  ///////// Character Scale Animation init
  double scaleBoyIpad = 40;
  double scaleBoyIphone = 20;
  double scaleGirlIpad = 40;
  double scaleGirlIphone = 20;
  double scaleCatIpad = 40;
  double scaleCatIphone = 20;

  ///////// Btn var
  bool buttonSwitch = false;
  String selectedAvatar = '';

  ////////// Function
  void selectChar(String pickChar) {
    setState(() {
      selectedAvatar = pickChar;
      if (pickChar == 'boy') {
        scaleBoyIpad = 0;
        scaleBoyIphone = 0;
        scaleGirlIpad = 40;
        scaleGirlIphone = 20;
        scaleCatIpad = 40;
        scaleCatIphone = 20;
        print('BoySelected');
      } else if (pickChar == 'girl') {
        scaleBoyIpad = 40;
        scaleBoyIphone = 20;
        scaleGirlIpad = 0;
        scaleGirlIphone = 0;
        scaleCatIpad = 40;
        scaleCatIphone = 20;
        print('GirlSelected');
      } else if (pickChar == 'cat') {
        scaleBoyIpad = 40;
        scaleBoyIphone = 20;
        scaleGirlIpad = 40;
        scaleGirlIphone = 20;
        scaleCatIpad = 0;
        scaleCatIphone = 0;
        print('CatSelected');
      }
      buttonSwitch = true;
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
        body: SingleChildScrollView(
          child: Container(
            width: deviceWidth,
            height: deviceHeight,
            child: Stack(
              children: <Widget>[
                //////////////////////////////////////////////////// Wall
                Container(
                  color: Color.fromRGBO(255, 249, 232, 1.00),
                ),
                /////////////////////////////////////////////////// Floor
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: deviceWidth,
                      height: deviceHeight * 0.36,
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Image.asset(
                            'assets/images/selectAvatarAssets/floor.png'),
                      ),
                    ),
                  ),
                ),
                //////////////////////////////////////////////////// Windows
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      margin: EdgeInsets.only(
                          top: deviceHeight * 0.12, right: deviceWidth * 0.043),
                      width: deviceHeight > 500
                          ? deviceWidth * 0.1
                          : deviceHeight * 0.14,
                      //height: deviceHeight * 0.17,
                      child: AspectRatio(
                        aspectRatio: 102 / 127,
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: Image.asset(
                              'assets/images/selectAvatarAssets/window.png'),
                        ),
                      ),
                    ),
                  ),
                ),

                //////////////////////////////////////////////////// Plant
                Positioned.fill(
                  child: Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                          margin: EdgeInsets.only(
                              bottom: deviceHeight > 500
                                  ? deviceHeight * 0.286
                                  : deviceHeight * 0.286),
                          width: deviceHeight > 500
                              ? deviceWidth * 0.107
                              : deviceWidth * 0.08,
                          /* height: deviceHeight > 500
                              ? deviceHeight * 0.42
                              : deviceHeight * 0.47, */
                          child: AspectRatio(
                            aspectRatio: 102 / 300,
                            child: FittedBox(
                                fit: BoxFit.fill,
                                child: Image.asset(
                                    'assets/images/selectAvatarAssets/plant.png')),
                          ))),
                ),

                ///////////////////////////////////////////////////// BookShelf
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      margin: EdgeInsets.only(bottom: deviceHeight * 0.29),
                      width: deviceHeight > 500
                          ? deviceWidth * 0.115
                          : deviceWidth * 0.07,
                      //height: deviceHeight * 0.516,
                      child: AspectRatio(
                        aspectRatio: 104 / 396,
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: Image.asset(
                              'assets/images/selectAvatarAssets/bookShelf.png'),
                        ),
                      ),
                    ),
                  ),
                ),

                //////////////////////////////////////////////////// BlackBoard
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: EdgeInsets.only(
                          top: deviceHeight > 500
                              ? deviceHeight * 0.051
                              : deviceHeight * 0.07),
                      child: Stack(
                        children: <Widget>[
                          Container(
                            width: deviceHeight > 500
                                ? deviceWidth * 0.38
                                : deviceWidth * 0.3,
                            /* height: deviceHeight > 500
                                ? deviceHeight * 0.239
                                : deviceHeight * 0.35, */
                            child: AspectRatio(
                              aspectRatio: 390 / 183,
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: Image.asset(
                                    'assets/images/selectAvatarAssets/blackBoard.png'),
                              ),
                            ),
                          ),
                          Positioned.fill(
                            child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  /*  margin: EdgeInsets.only(
                                      top: deviceHeight > 500
                                          ? 0
                                          : deviceHeight * 0.08), */
                                  width: deviceHeight > 500
                                      ? deviceWidth * 0.3
                                      : deviceWidth * 0.25,
                                  child: Image.asset(
                                      'assets/images/selectAvatarAssets/selectYourAvatar.png'),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                //////////////////////////////////////////////////////  Character

                Container(
                  margin: EdgeInsets.only(
                      bottom: deviceHeight > 500
                          ? deviceHeight * 0.2
                          : deviceHeight * 0.23),
                  child: Stack(
                    children: <Widget>[
                      ////////////////////// Boy
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: GestureDetector(
                            onTap: () {
                              selectChar('boy');
                            },
                            child:  Container(
                                width: deviceHeight > 500
                                    ? deviceWidth * 0.3
                                    : deviceWidth * 0.4,
                                height: deviceHeight > 500
                                    ? deviceHeight * 0.468
                                    : deviceHeight * 0.55,
                                margin: EdgeInsets.only(
                                    left: deviceHeight > 500
                                        ? deviceWidth * 0.07
                                        : deviceWidth * 0.04),
                                child: Hero(tag: 'avatarboy',
                                                          child:AnimatedContainer(
                                  duration: Duration(milliseconds: 100),
                                  curve: Curves.easeOut,
                                  margin: EdgeInsets.only(
                                      top: Device.get().isTablet
                                          ? scaleBoyIpad
                                          : scaleBoyIphone),
                                  child: Image.asset(
                                      'assets/images/selectAvatarAssets/boyWithShadow.png'),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      ////////////////////// Girl
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: GestureDetector(
                            onTap: () {
                              selectChar('girl');
                            },
                            child:  Container(
                                width: deviceHeight > 500
                                    ? deviceWidth * 0.3
                                    : deviceWidth * 0.4,
                                height: deviceHeight > 500
                                    ? deviceHeight * 0.468
                                    : deviceHeight * 0.55,
                                child: Hero(
                              tag: 'avatargirl',
                              child:AnimatedContainer(
                                  duration: Duration(milliseconds: 100),
                                  curve: Curves.easeOut,
                                  margin: EdgeInsets.only(
                                      top: Device.get().isTablet
                                          ? scaleGirlIpad
                                          : scaleGirlIphone),
                                  //margin: EdgeInsets.only(top:deviceHeight>500?ipad:iphone),
                                  child: Image.asset(
                                      'assets/images/selectAvatarAssets/girlWithShadow.png'),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      /////////////////////// Cat
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: GestureDetector(
                            onTap: () {
                              selectChar('cat');
                            },
                            child:  Container(
                                width: deviceHeight > 500
                                    ? deviceWidth * 0.3
                                    : deviceWidth * 0.4,
                                height: deviceHeight > 500
                                    ? deviceHeight * 0.468
                                    : deviceHeight * 0.55,
                                margin: EdgeInsets.only(
                                    right: deviceHeight > 500
                                        ? deviceWidth * 0.07
                                        : deviceWidth * 0.04),
                                child: Hero(tag: 'avatarcat',
                                                          child:AnimatedContainer(
                                  duration: Duration(milliseconds: 100),
                                  curve: Curves.easeOut,
                                  margin: EdgeInsets.only(
                                      top: Device.get().isTablet
                                          ? scaleCatIpad
                                          : scaleCatIphone),
                                  //margin: EdgeInsets.only(top:deviceHeight>500?ipad:iphone),
                                  child: Image.asset(
                                      'assets/images/selectAvatarAssets/catWithShadow.png'),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                /////////////////////////////////////////////////// Button
                IndexedStack(index: buttonSwitch ? 1 : 0, children: <Widget>[
                  ////////////////////////////  Disable
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: EdgeInsets.only(
                            bottom: deviceHeight > 500
                                ? deviceHeight * 0.047
                                : deviceHeight * 0.07),
                        child: Stack(
                          children: <Widget>[
                            Material(
                              color: Colors.transparent,
                              child: Ink(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(500),
                                  color: Color.fromRGBO(237, 237, 243, 1.00),
                                ),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(500),
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
                                    child: AspectRatio(aspectRatio: 216 / 93),
                                  ),
                                ),
                              ),
                            ),
                            Positioned.fill(
                                child: Align(
                              alignment: Alignment.center,
                              child: FractionallySizedBox(
                                widthFactor: 0.5,
                                child: FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Text(
                                    "SELECT",
                                    style: TextStyle(
                                        fontFamily: 'NunitoExtraBold',
                                        fontSize: deviceHeight > 500 ? 30 : 17,
                                        color: Color.fromRGBO(
                                            154, 154, 177, 1.00)),
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
                        margin: EdgeInsets.only(
                            bottom: deviceHeight > 500
                                ? deviceHeight * 0.047
                                : deviceHeight * 0.07),
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
                                    Provider.of<DataProvider>(context,
                                            listen: false)
                                        .selectAvatar(selectedAvatar);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => KidsInfo(),
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
                                  Provider.of<DataProvider>(context,
                                          listen: false)
                                      .selectAvatar(selectedAvatar);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => KidsInfo(),
                                    ),
                                  );
                                },
                                child: FractionallySizedBox(
                                  widthFactor: 0.5,
                                  child: FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Text(
                                      "SELECT",
                                      style: TextStyle(
                                          fontFamily: 'NunitoExtraBold',
                                          fontSize:
                                              deviceHeight > 500 ? 30 : 17,
                                          color: Color.fromRGBO(
                                              255, 255, 255, 1.00)),
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

                //////////////////////////////////////////////  screen size
                /*  Positioned.fill(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: EdgeInsets.only(top: 30),
                      child: Text(
                        'width:$deviceWidth height:$deviceHeight',
                        style: TextStyle(
                            fontSize: 20, color: Color.fromRGBO(0, 0, 0, 1.00)),
                      ),
                    ),
                  ),
                ), */
                //////////////////////////////////////////////
              ],
            ),
          ),
        ),
      ),
    );
  }
}
