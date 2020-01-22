import 'package:flutter/material.dart';
import 'package:wisekids_app/main.dart';

class ColorThemeWidget extends StatefulWidget {
  var gradientColor =[];
  List<double> gradientOffset= [];
  ColorThemeWidget({this.gradientColor, this.gradientOffset,});

  @override
  _ColorThemeWidgetState createState() => _ColorThemeWidgetState();
}

class _ColorThemeWidgetState extends State<ColorThemeWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10,right: 10),
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        gradient: LinearGradient(
          // Where the linear gradient begins and ends
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          // Add one stop for each color. Stops should increase from 0 to 1
          stops: widget.gradientOffset ?? [0.1,1.0],
          colors: widget.gradientColor?? [MyColor.aqua, MyColor.limeGreen],
        ),
      ),
      width: 45,
      height: 45,
    );
  }
}
