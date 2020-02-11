import 'package:flutter/material.dart';
import 'package:wisekids_app/screen/enterBook.dart';
import '../widget/slide_popup_dialog_play.dart' as playDialog;
import 'home.dart';

class Play extends StatefulWidget {
  @override
  _PlayState createState() => _PlayState();
}

class _PlayState extends State<Play> {
  void _showPlayDialog() {
    print('object');
    playDialog.showSlideDialog(
      context: context,
      child: Container(),
    );
  }

  Offset positionCupCake;
  Offset positionCandy;
  Offset toothBrush;
  Offset mirror;
  double width = 100.0, height = 100.0;

  @override
  void initState() {
    super.initState();
    positionCupCake = Offset(60, 175);
    positionCandy = Offset(843, 175);
    toothBrush = Offset(60, 483);
    mirror = Offset(843, 483);
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          ///////////////////// Bg
          Container(
            width: deviceWidth,
            height: deviceHeight,
            child: Image.asset('assets/images/play/playBg.png'),
          ),
          ///////////////////// Back Btn
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => EnterBook(),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.only(top: 15, left: 15),
              height: 74,
              child: Image.asset('assets/images/play/backBtn.png'),
            ),
          ),
          /////////////////////// Prop Dragable
          ////////////// cupcake
          Positioned(
            left: positionCupCake.dx,
            top: positionCupCake.dy - height + 100,
            child: Draggable(
              feedback: Container(
                height: 128,
                child: Image.asset('assets/images/play/cupCake.png'),
              ),
              child: Container(
                height: 128,
                child: Image.asset('assets/images/play/cupCake.png'),
              ),
              childWhenDragging: Container(),
              onDraggableCanceled: (Velocity velocity, Offset offset) {
                setState(() => positionCupCake = offset);
              },
            ),
          ),
          ////////////// Candy
          Positioned(
            left: positionCandy.dx,
            top: positionCandy.dy - height + 100,
            child: Draggable(
              feedback: Container(
                height: 157,
                child: Image.asset('assets/images/play/Toffy.png'),
              ),
              child: Container(
                height: 157,
                child: Image.asset('assets/images/play/Toffy.png'),
              ),
              childWhenDragging: Container(),
              onDraggableCanceled: (Velocity velocity, Offset offset) {
                setState(() => positionCandy = offset);
              },
            ),
          ),
          ////////////// toothBrush
          Positioned(
            left: toothBrush.dx,
            top: toothBrush.dy - height + 100,
            child: Draggable(
              feedback: Container(
                height: 146,
                child: Image.asset('assets/images/play/toothBrush.png'),
              ),
              child: Container(
                height: 146,
                child: Image.asset('assets/images/play/toothBrush.png'),
              ),
              childWhenDragging: Container(),
              onDraggableCanceled: (Velocity velocity, Offset offset) {
                setState(() => toothBrush = offset);
              },
            ),
          ),
          ////////////// Mirror
          Positioned(
            left: mirror.dx,
            top: mirror.dy - height + 100,
            child: Draggable(
              feedback: Container(
                height: 178,
                child: Image.asset('assets/images/play/mirror.png'),
              ),
              child: Container(
                height: 178,
                child: Image.asset('assets/images/play/mirror.png'),
              ),
              childWhenDragging: Container(),
              onDraggableCanceled: (Velocity velocity, Offset offset) {
                Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Home(),
                ),
              );
                playDialog.showSlideDialog(
                  context: context,
                  child: Container(),
                );
                setState(() => mirror = offset);
              },
            ),
          ),
          ////////
        ],
      ),
    );
  }
}
