import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../widget/slide_popup_dialog_kidsStatistic.dart'as kidsStatistic;
import 'parentalKidsCenter.dart';

class KidsProfile extends StatefulWidget {
  @override
  _KidsProfileState createState() => _KidsProfileState();
}

class _KidsProfileState extends State<KidsProfile> {

 void _showKidsStatisticDialog() {
    kidsStatistic.showSlideDialog(
      context: context,
      child: Container(
        //color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          ///////////////////////////////// gradient Bg
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.1, 1.0],
                colors: [
                  Color.fromRGBO(69, 223, 224, 1.00),
                  Color.fromRGBO(133, 207, 76, 1.00)
                ],
              ),
            ),
          ),
          /////////////////////////////// White Card
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 710,
                width: 966,
              ),
            ),
          ),
          /////////////////////////////// back to Parent Area
          GestureDetector(
            onTap: (){
              Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ParentalKidsCenter(),
                    ),
                  );
            },
                      child: Container(
              margin: EdgeInsets.only(top:70,left: 75),
              child: SvgPicture.asset(
                  'assets/images/kidsProfile/backToParentArea.svg'),
            ),
          ),

          /////////////////////////////// listview
          GestureDetector(
            onTap: _showKidsStatisticDialog,
                      child: Container(
              margin: EdgeInsets.only(left: 88, top: 180),
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 12, top: 330),
                    child: Text(
                      '0 minutes today',
                      style: TextStyle(
                        fontFamily: 'NunitoRegular',
                        fontSize: deviceHeight > 500 ? 17 : 16,
                      ),
                    ),
                  ),
                  Row(
                    
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 20),
                        child: Image.asset(
                            'assets/images/parentalKidsCenter/Todd.png'),
                        width: 145,
                        height: 160,
                      ),
                      Container(
                        height: 500,
                        width: 750,
                        child: ListView(
                          children: <Widget>[
                            Wrap(
                              children: <Widget>[
                                ////////////////// book 1
                                Container(
                                  margin: EdgeInsets.only(left: 20, bottom: 20),
                                  height: 203,
                                  decoration: new BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color.fromRGBO(69, 223, 224, 0.5),
                                        blurRadius:
                                            10.0, // has the effect of softening the shadow
                                        spreadRadius:
                                            1, // has the effect of extending the shadow
                                        offset: Offset(
                                          0.0, // horizontal, move right 10
                                          2.0, // vertical, move down 10
                                        ),
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child:
                                          Image.asset('assets/images/Book7.png')),
                                ),
                                ////////////////// book 2
                                Container(
                                  margin: EdgeInsets.only(left: 20, bottom: 20),
                                  height: 203,
                                  decoration: new BoxDecoration(
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
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child:
                                          Image.asset('assets/images/Book2.png')),
                                ),
                                ////////////////// book 3
                                Container(
                                  margin: EdgeInsets.only(left: 20, bottom: 20),
                                  height: 203,
                                  decoration: new BoxDecoration(
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
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child:
                                          Image.asset('assets/images/Book3.png')),
                                ),
                                ////////////////// book 4
                                Container(
                                  margin: EdgeInsets.only(left: 20, bottom: 20),
                                  height: 203,
                                  decoration: new BoxDecoration(
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
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child:
                                          Image.asset('assets/images/Book4.png')),
                                ),
                                ////////////////// book 5
                                Container(
                                  margin: EdgeInsets.only(left: 20, bottom: 20),
                                  height: 203,
                                  decoration: new BoxDecoration(
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
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child:
                                          Image.asset('assets/images/Book8.png')),
                                ),
                                ////////////////// book 6
                                Container(
                                  margin: EdgeInsets.only(left: 20, bottom: 20),
                                  height: 203,
                                  decoration: new BoxDecoration(
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
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child:
                                          Image.asset('assets/images/Book6.png')),
                                ),
                                ////////////////////////
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
