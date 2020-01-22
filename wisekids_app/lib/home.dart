import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:slide_popup_dialog/slide_popup_dialog.dart' as slideDialog;
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:wisekids_app/main.dart';

class Home extends StatefulWidget {

  //recieve data from select avatar page
  final String avatar;
  Home(this.avatar);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _value;

  void _showDialog() {
    slideDialog.showSlideDialog(
      context: context,
      child: Text("Hello World"),
    );
  }

   checkAvatar() {
    if (widget.avatar == 'Boy') {
      
      return 'assets/images/avatar_boy.png';
    } else if (widget.avatar == 'Girl') {
      
      return 'assets/images/avatar_girl.png';
    } else if (widget.avatar == 'Cat') {
      
      return 'assets/images/avatar_cat.png';
    }
  }

  var bookShelf = [
    "assets/images/Book1.png",
    "assets/images/Book2.png",
    "assets/images/Book3.png",
    "assets/images/Book4.png",
    "assets/images/Book5.png",
    "assets/images/Book6.png",
    "assets/images/Book7.png",
    "assets/images/Book8.png",
  ];

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
                    child: SvgPicture.asset(
                      'assets/images/bgPattern.svg',
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
                  ///
                  ///////////////////////////////////////////////////////////////////////////////  Begin of Avatar, Vocab, Category, login dropdown
                  Container(
                    margin: EdgeInsets.only(top: 15, left: 15),
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
                          checkAvatar().toString(),
                        ),
                        height: 97,
                        width: 97,
                      ),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 18, left: 135),
                    height: 69,
                    child: SvgPicture.asset(
                      'assets/icon/Vocabuary.svg',
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 18, left: 220),
                    height: 69,
                    child: SvgPicture.asset(
                      'assets/icon/Category.svg',
                    ),
                  ),

                  Stack(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                          top: 32,
                          left: MediaQuery.of(context).size.width * 0.8025,
                        ),
                        child: SvgPicture.asset(
                          'assets/icon/Button_Yl.svg',
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 32,
                      left: MediaQuery.of(context).size.width * 0.8025,
                    ),
                    height: 45,
                    width: 148,
                    child: Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
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
                  ),
                  ///////////////////////////////////////////////////////////////////////////////  Begin of Avatar, Vocab, Category, login dropdown
                  Container(
                    margin: EdgeInsets.only(top: 155),
                    height: 230,
                    width: MediaQuery.of(context).size.width,
                    child: new Swiper(
                      
                      
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          
                            
                           decoration: new BoxDecoration(
                             borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromRGBO(69, 223, 224, 0.5),
                                    blurRadius:
                                        10.0, // has the effect of softening the shadow
                                    spreadRadius:
                                        -1, // has the effect of extending the shadow
                                    offset: Offset(
                                      0.0, // horizontal, move right 10
                                      2.0, // vertical, move down 10
                                    ),
                                  ),
                                ],
                              ),
                          margin: EdgeInsets.only(left: 12, right: 12,bottom: 10,top: 10),
                          //padding: EdgeInsets.only(bottom: 20),
                          child: 
                          
                          ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Container(
                             
                              child: new Image.asset(
                                bookShelf[index],
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: 8,
                      //itemHeight: 206,
                      //itemWidth: 147,

                      viewportFraction: 0.22,
                      scale: 1.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
