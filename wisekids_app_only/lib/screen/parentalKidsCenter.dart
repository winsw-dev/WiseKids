import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import './kidsProfile.dart';

import 'home.dart';

class ParentalKidsCenter extends StatefulWidget {
  @override
  _ParentalKidsCenterState createState() => _ParentalKidsCenterState();
}

class _ParentalKidsCenterState extends State<ParentalKidsCenter> {
  var rating = 0.0;

  @override
  Widget build(BuildContext context) {
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
          //////////////////////////////// Back Home Btn
          Positioned.fill(
            child: Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Home(),
                    ),
                  );
                },
                child: Container(
                  height: 28,
                  margin: EdgeInsets.only(top: 65, left: 70),
                  child: SvgPicture.asset(
                      'assets/images/parentalKidsCenter/homeBtn.svg'),
                ),
              ),
            ),
          ),
          //////////////////////////////// SignOut
          Positioned.fill(
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                height: 54,
                margin: EdgeInsets.only(top: 70, right: 75),
                child: SvgPicture.asset(
                    'assets/images/parentalKidsCenter/Signout.svg'),
              ),
            ),
          ),
          ///////////////////////////////// Content
          Positioned.fill(
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: 650,
                margin: EdgeInsets.only(left: 190, top: 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    /////////////// Text Wise Kids
                    Container(
                      child: Text(
                        'Wise Kids',
                        style: TextStyle(
                            fontFamily: 'NunitoBold',
                            fontSize: 21,
                            color: Color.fromRGBO(69, 223, 224, 1.00)),
                      ),
                    ),
                    /////////////// Text Email
                    Container(
                      child: Text(
                        'wisekids.psuic@gmail.com',
                        style: TextStyle(
                          fontFamily: 'NunitoRegular',
                          fontSize: 16,
                        ),
                      ),
                    ),
                    /////////////// Text My Kids
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      child: Text(
                        'My Kids',
                        style: TextStyle(
                            fontFamily: 'NunitoBold',
                            fontSize: 19,
                            color: Color.fromRGBO(69, 223, 224, 1.00)),
                      ),
                    ),
                    ///////////////// Row of Kids
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      child: Row(
                        children: <Widget>[
                          ////////////// Todd
                          GestureDetector(onTap: (){
                            Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => KidsProfile(),
                      ),
                    );
                          },
                                                      child: Container(
                              margin: EdgeInsets.only(right: 20),
                              width: 129,
                              child: Image.asset(
                                  'assets/images/parentalKidsCenter/Todd.png'),
                            ),
                          ),
                          ////////////// Gusjung
                          Container(
                            margin: EdgeInsets.only(right: 20),
                            width: 129,
                            child: Image.asset(
                                'assets/images/parentalKidsCenter/Gusjung.png'),
                          ),
                          ////////////// Mimi
                          Container(
                            margin: EdgeInsets.only(right: 20),
                            width: 129,
                            child: Image.asset(
                                'assets/images/parentalKidsCenter/Mimi.png'),
                          ),
                          ////////////// Add More
                          Container(
                            margin: EdgeInsets.only(right: 20),
                            width: 113,
                            child: Image.asset(
                                'assets/images/parentalKidsCenter/addMore.png'),
                          ),
                        ],
                      ),
                    ),
                    /////////////// Text Let us know
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Text(
                        'Let us know what you think about Wisekids!',
                        style: TextStyle(
                            fontFamily: 'NunitoBold',
                            fontSize: 19,
                            color: Color.fromRGBO(69, 223, 224, 1.00)),
                      ),
                    ),
                    /////////////// Review
                    Container(
                      margin: EdgeInsets.only(top: 25),
                      child: Row(
                        children: <Widget>[
                          SmoothStarRating(
                            rating: rating,
                            size: 40,
                            color: Colors.yellow,
                            borderColor: Color.fromRGBO(219, 222, 227, 1.00),
                            filledIconData: Icons.star,
                            halfFilledIconData: Icons.star_half,
                            defaultIconData: Icons.star_border,
                            starCount: 5,
                            allowHalfRating: false,
                            spacing: 2.0,
                            onRatingChanged: (value) {
                              setState(() {
                                rating = value;
                              });
                            },
                          ),
                          ////////////////////// review Btn
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            height: 54,
                            child: SvgPicture.asset(
                                'assets/images/parentalKidsCenter/leaveReview.svg'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
