import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flare_flutter/flare_actor.dart';
import '../selectAvatar.dart';
import '../home.dart';

class KidsInfo extends StatefulWidget {
  //recieve data from select avatar page
  final String pickedCharacter;
  KidsInfo(this.pickedCharacter);

  @override
  _KidsInfoState createState() => _KidsInfoState();
}

class _KidsInfoState extends State<KidsInfo>
    with SingleTickerProviderStateMixin {
  ///////////////////// initial var //////////////////////////////////////
  var finishButtonControl = 0;
  var backButtonControl = 0;
  var bgGradientColor = [
    69,
    223,
    224,
    1.00,
    51,
    178,
    219,
    1.00,
    25,
    112,
    212,
    1.00
  ]; //RBGA1,2,3
  final focus = FocusNode();

  final textControllerName = TextEditingController();
  final textControllerAge = TextEditingController();

  double bubbleSpeechOpacity = 1.0;
  double congratOpacity = 0.0;
  var backBttnVisibility = true;
  var bubbleSpeechVisibility = true;
  var congratVisibility = false;
  var goToHomeVisibility = false;
  var cogratMargin = [51.0, 353.0];
  var boyPicPath = '';
  var congratAnimation = 'idle';
  var avatar = '';

  checkPickedChar() {
    if (widget.pickedCharacter == 'Boy') {
      setState(() {
        avatar = 'Boy';
      });
      return 'assets/images/kidsInfoBoy.png';
    } else if (widget.pickedCharacter == 'Girl') {
      setState(() {
        avatar = 'Girl';
      });
      return 'assets/images/kidsInfoGirl.png';
    } else if (widget.pickedCharacter == 'Cat') {
      setState(() {
        avatar = 'Cat';
      });
      return 'assets/images/kidsInfoCat.png';
    }
  }

  void checkTextField() {
    String inputName, inputAge;

    setState(() {
      // Getting Value From Text Field and Store into String Variable
      inputName = textControllerName.text;
      inputAge = textControllerAge.text;

      // Checking all TextFields.
      if (inputName == '' || inputAge == '') {
        // Text Field is Empty.
        finishButtonControl = 0;
      } else {
        // Text Field is NOT Empty.
        finishButtonControl = 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    curve: Curves.easeIn,
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      // Box decoration takes a gradient
                      gradient: LinearGradient(
                        // Where the linear gradient begins and ends
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        // Add one stop for each color. Stops should increase from 0 to 1
                        stops: [0.1, 0.5, 1.0],
                        colors: [
                          // Colors are easy thanks to Flutter's Colors class.
                          Color.fromRGBO(bgGradientColor[0], bgGradientColor[1],
                              bgGradientColor[2], bgGradientColor[3]),
                          Color.fromRGBO(bgGradientColor[4], bgGradientColor[5],
                              bgGradientColor[6], bgGradientColor[7]),
                          Color.fromRGBO(bgGradientColor[8], bgGradientColor[9],
                              bgGradientColor[10], bgGradientColor[11]),
                        ],
                      ),
                    ),
                    child: Image.asset(
                      'assets/icon/bgPattern.png',
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SelectAvatar(),
                        ),
                      );
                    },
                    child: Visibility(
                      visible: backBttnVisibility,
                      maintainState: false,
                      maintainInteractivity: false,
                      child: Container(
                        margin: EdgeInsets.only(top: 12, left: 12),
                        height: 46,
                        child: SvgPicture.asset(
                          'assets/icon/back_button_OR_cir.svg',
                          height: 46,
                        ),
                      ),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(left: 143),
                    height: 362,
                    width: 229,
                    child: FlareActor("assets/animation/Firework.flr",
                        animation: congratAnimation),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 143),
                    child: Image.asset(
                      checkPickedChar().toString(),
                      height: 362,
                      width: 229,
                    ),
                  ),

                  //////////////////////////////////////////////////////// speechBubble
                  Visibility(
                    visible: true,
                    maintainAnimation: true,
                    maintainInteractivity: false,
                    maintainState: true,
                    child: AnimatedOpacity(
                      duration: Duration(milliseconds: 200),
                      curve: Curves.easeOut,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 71, left: 353),
                            height: 182,
                            child: SvgPicture.asset(
                              'assets/images/speechBubble.svg',
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 89, left: 404),
                            child: Text(
                              "Hello",
                              style: TextStyle(
                                  fontFamily: 'NunitoBlack',
                                  fontSize: 30,
                                  color: Color.fromRGBO(255, 95, 74, 1.00)),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 143, left: 404),
                            child: Text(
                              "My name is",
                              style: TextStyle(
                                  fontFamily: 'NunitoBold',
                                  fontSize: 22.5,
                                  color: Color.fromRGBO(255, 95, 74, 1.00)),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 188, left: 404),
                            child: Text(
                              "I'm",
                              style: TextStyle(
                                  fontFamily: 'NunitoBold',
                                  fontSize: 22.5,
                                  color: Color.fromRGBO(255, 95, 74, 1.00)),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 188, left: 498),
                            child: Text(
                              "years old",
                              style: TextStyle(
                                  fontFamily: 'NunitoBold',
                                  fontSize: 22.5,
                                  color: Color.fromRGBO(255, 95, 74, 1.00)),
                            ),
                          ),
                          ///////////////////////////////////////////////////////////////////// Name input text feild
                          Container(
                            margin: EdgeInsets.only(top: 138, left: 560),
                            width: 125,
                            child: TextFormField(
                              controller: textControllerName,
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
                            margin: EdgeInsets.only(top: 177, left: 560),
                            height: 4,
                            width: 125,
                          ),
                          /////////////////////////////////////////////////////////////////// Age input text feild
                          Container(
                            margin: EdgeInsets.only(top: 185, left: 452),
                            width: 43,
                            child: TextFormField(
                              controller: textControllerAge,
                              onFieldSubmitted: (v) {
                                checkTextField();
                              },
                              focusNode: focus,
                              inputFormatters: [
                                WhitelistingTextInputFormatter.digitsOnly,
                                BlacklistingTextInputFormatter(
                                    new RegExp('[0]')),
                              ], //blacklist & whitelist char
                              keyboardType: TextInputType.number,
                              maxLines: 1,
                              maxLength: 1,
                              buildCounter: (BuildContext context,
                                      {int currentLength,
                                      int maxLength,
                                      bool isFocused}) =>
                                  null,
                              //autofocus: true,
                              cursorColor: Color.fromRGBO(69, 223, 224, 1.00),
                              cursorRadius: Radius.circular(20.0),
                              cursorWidth: 4,
                              decoration: InputDecoration.collapsed(
                                hintText: "",
                              ),
                              //delete underline
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
                            margin: EdgeInsets.only(top: 223, left: 448),
                            height: 4,
                            width: 45,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 279, left: 466),
                            child: IndexedStack(
                              index: finishButtonControl,
                              children: <Widget>[
                                ///////////////////////////////////////////////////////////////////////////// Disable Button
                                Stack(
                                  children: <Widget>[
                                    Material(
                                      color: Colors.transparent,
                                      child: Ink(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(28),
                                          color: Color.fromRGBO(
                                              237, 237, 243, 1.00),
                                        ),
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(28),
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
                                          "FINISH",
                                          style: TextStyle(
                                              fontFamily: 'NunitoBold',
                                              fontSize: 15,
                                              color: Color.fromRGBO(
                                                  154, 154, 177, 1.00)),
                                        ),
                                      ),
                                    )),
                                  ],
                                ),

                                ///////////////////////////////////////////////////////////////////////////////////// Active button
                                GestureDetector(
                                  onTap: () {
                                    print("taped");
                                    setState(() {
                                      bubbleSpeechOpacity = 0.0;
                                      congratOpacity = 1.0;
                                      backBttnVisibility = false;
                                      bubbleSpeechVisibility = false;
                                      congratVisibility = true;
                                      goToHomeVisibility = true;
                                      cogratMargin = [71.0, 353.0];
                                      congratAnimation = 'Firework';
                                      bgGradientColor = [
                                        188,
                                        53,
                                        235,
                                        1.00,
                                        220,
                                        62,
                                        191,
                                        1.00,
                                        251,
                                        71,
                                        149,
                                        1.00
                                      ];
                                    });
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
                                            "FINISH",
                                            style: TextStyle(
                                                fontFamily: 'NunitoBold',
                                                fontSize: 15,
                                                color: Color.fromRGBO(
                                                    255, 255, 255, 1.00)),
                                          ),
                                        ),
                                      )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      opacity: bubbleSpeechOpacity, //bubble speech opacity
                    ),
                  ),
                  /////////////////////////////////////////////////////////////////////////////// Congrats
                  Visibility(
                    visible: congratVisibility,
                    maintainAnimation: true,
                    maintainState: true,
                    child: AnimatedOpacity(
                      opacity: 1.0,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeOut,
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 250),
                        curve: Curves.easeOut,
                        margin: EdgeInsets.only(top: 71, left: cogratMargin[1]),
                        child: Stack(
                          children: <Widget>[
                            Material(
                              color: Colors.transparent,
                              child: Container(
                                height: 182,
                                width: 321,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 70, top: 76),
                              child: Text(
                                'Congrats !',
                                style: TextStyle(
                                    fontFamily: 'NunitoBold',
                                    fontSize: 30,
                                    color: Color.fromRGBO(255, 255, 255, 1.00)),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 70, top: 127),
                              child: Text(
                                'This is your avatar. Let\'s read and play !',
                                style: TextStyle(
                                    fontFamily: 'NunitoRegular',
                                    fontSize: 11,
                                    color: Color.fromRGBO(255, 255, 255, 1.00)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  /////////////////////////////////////////////////// go to home Inkwell
                  Visibility(
                    visible: goToHomeVisibility,
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                            highlightColor: Color.fromRGBO(255, 255, 255, 0.05),
                            splashColor: Color.fromRGBO(255, 255, 255, 0.2),
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Home(),
                                ),
                              );
                              print('go to home');
                            }),
                      ),
                    ),
                  )

                  ///////////////////////////////////////////////////////////////////////////////
                ],
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
