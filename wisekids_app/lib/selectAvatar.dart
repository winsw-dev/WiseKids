import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
//import 'package:flutter/services.dart';

class SelectAvatar extends StatelessWidget {
  final String backButton = 'assets/icon/music-and-multimedia.svg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                  backButton,
                  height: 20.0,
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  "Select your avatar",
                  style: TextStyle(
                      fontFamily: 'NunitoBold',
                      fontSize: 25,
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
            children: [
              Card(
                elevation: 5,
                child: Container(width: 187, height: 215, child: Text('data')),
              ),
            ],
          )
        ],
      ),
    );
  }
}
