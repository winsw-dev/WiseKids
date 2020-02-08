import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';

class SelectAvatar extends StatefulWidget {
  @override
  _SelectAvatarState createState() => _SelectAvatarState();
}

class _SelectAvatarState extends State<SelectAvatar> {

  bool ipad = Device.get().isTablet;


  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    final charNormal =
        deviceHeight > 500 ? deviceHeight * 0.39 : deviceHeight * 0.26;
    final charSelected = deviceHeight * 0.327;
    var charSizeBoy = charNormal;
    var charSizeGirl = charNormal;
    var charSizeCat = charNormal;

    print(ipad);

    void selectChar(String pickChar) {
      setState(() {
        if (pickChar == 'Boy') {
          charSizeBoy = charSelected;
          charSizeGirl = charNormal;
          charSizeCat = charNormal;

          print(charSizeBoy);
        } else if (pickChar == 'Girl') {
          charSizeBoy = charNormal;
          charSizeGirl = charSelected;
          charSizeCat = charNormal;
          print('GirlSelected');
        } else if (pickChar == 'Cat') {
          charSizeBoy = charNormal;
          charSizeGirl = charNormal;
          charSizeCat = charSelected;
          print('CatSelected');
        }
      });
    }

    return SafeArea(
      top: deviceHeight > 500 ? false : true,
      bottom: false,
      right: false,
      child: Scaffold(
        body: Stack(
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
                  height: deviceHeight * 0.17,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: Image.asset(
                        'assets/images/selectAvatarAssets/window.png'),
                  ),
                ),
              ),
            ),

            //////////////////////////////////////////////////// Plant
            Positioned.fill(
              child: Align(
                  alignment: Alignment.topRight,
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
                              'assets/images/selectAvatarAssets/plant.png')))),
            ),

            ///////////////////////////////////////////////////// BookShelf
            Positioned.fill(
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: EdgeInsets.only(top: deviceHeight * 0.19),
                  width: deviceHeight > 500
                      ? deviceWidth * 0.115
                      : deviceHeight * 0.13,
                  height: deviceHeight * 0.516,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: Image.asset(
                        'assets/images/selectAvatarAssets/bookShelf.png'),
                  ),
                ),
              ),
            ),

            //////////////////////////////////////////////////////  Character

            Container(
              margin: EdgeInsets.only(bottom: deviceHeight * 0.2),
              child: Stack(
                children: <Widget>[
                  ////////////////////// Boy
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: GestureDetector(
                        onTap: () {
                          selectChar('Boy');
                        },
                        child: AnimatedContainer(
                          width: deviceWidth*0.3,
                          height: deviceHeight*0.468,
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeOut,
                          margin: EdgeInsets.only(
                               left: deviceWidth * 0.088),
                          child: Container(
                            margin: EdgeInsets.only(top:Device.get().isTablet?0:0),
                            //margin: EdgeInsets.only(top:deviceHeight>500?ipad:iphone),
                            child: Image.asset(
                                'assets/images/selectAvatarAssets/boyWithShadow.png'),
                          ),
                        ),
                      ),
                    ),
                  ),

                  ////////////////////// Girl
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: deviceWidth*0.3,
                          height: deviceHeight*0.468,
                        margin: EdgeInsets.only(),
                        child: Image.asset(
                            'assets/images/selectAvatarAssets/girlWithShadow.png'),
                      ),
                    ),
                  ),

                  /////////////////////// Cat
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        width: deviceWidth*0.3,
                          height: deviceHeight*0.468,
                        margin: EdgeInsets.only(
                             right: deviceWidth * 0.088),
                        child: Image.asset(
                            'assets/images/selectAvatarAssets/catWithShadow.png'),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /////////////////////////////////////////////////// Button

            ////////////////////////////  Disable
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(
                      bottom: deviceHeight > 500
                          ? deviceHeight * 0.047
                          : deviceHeight * 0.08),
                  child: Stack(
                    children: <Widget>[
                      Material(
                        color: Colors.transparent,
                        child: Ink(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Color.fromRGBO(237, 237, 243, 1.00),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(50),
                            onTap: () {
                              print('pressed');
                            },
                            child: Container(
                              height: deviceHeight > 500
                                  ? deviceHeight * 0.121
                                  : deviceHeight * 0.18,
                              width: deviceWidth * 0.211,
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
                                fontFamily: 'NunitoExtraBold',
                                fontSize: deviceHeight > 500 ? 22.5 : 17,
                                color: Color.fromRGBO(154, 154, 177, 1.00)),
                          ),
                        ),
                      )),
                    ],
                  ),
                ),
              ),
            ),

            ///////////////////////// Enable

            //////////////////////////////////////////////  screen size
            Positioned.fill(
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
            ),
          ],
        ),
      ),
    );
  }
}
