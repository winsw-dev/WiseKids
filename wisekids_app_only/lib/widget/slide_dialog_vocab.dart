import 'package:flutter/material.dart';

//import './pill_gesture.dart';

class SlideDialog extends StatefulWidget {
  final Widget child;
  final Color backgroundColor;
  final Color pillColor;
  final Color containerColor;
  final List<Color> bgGradient;
  final List<double> gradientStop;
  final bool propVisibility;

  SlideDialog({
    @required this.child,
    @required this.pillColor,
    @required this.backgroundColor,
    @required this.containerColor,
    @required this.bgGradient,
    @required this.gradientStop,
    @required this.propVisibility,
  });

  @override
  _SlideDialogState createState() => _SlideDialogState();
}

class _SlideDialogState extends State<SlideDialog> {
  //var _initialPosition = 0.0;
  var _currentPosition = 0.0;

  @override
  Widget build(BuildContext context) {
    //final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets +
          EdgeInsets.only(top: deviceHeight / 5 + _currentPosition),
      duration: Duration(milliseconds: 100),
      curve: Curves.decelerate,
      child: MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: context,
        child: Stack(
          children: <Widget>[
            Visibility(
              visible: widget.propVisibility,
              child: Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      return;
                    },
                    child: Container(
                      width: 851,
                      child: Image.asset('assets/images/loginPropBoyGirl.png'),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                width: 400,
                height: MediaQuery.of(context).size.height,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                    // Box decoration takes a gradient
                    gradient: LinearGradient(
                      // Where the linear gradient begins and ends
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      // Add one stop for each color. Stops should increase from 0 to 1
                      stops: widget.gradientStop,
                      colors: widget.bgGradient,
                    ),
                  ),
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: MediaQuery.of(context).size.height / 2,
                            color: widget.containerColor,
                          ),
                        ),
                      ),
                      /*
                  PillGesture(
                    pillColor: widget.pillColor,
                    onVerticalDragStart: _onVerticalDragStart,
                    onVerticalDragEnd: _onVerticalDragEnd,
                    onVerticalDragUpdate: _onVerticalDragUpdate,
                  ),*/
                      widget.child,
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
              visible: widget.propVisibility,
              child: Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    margin: EdgeInsets.only(left: 155),
                    width: 100,
                    child: Image.asset('assets/images/loginPropCat.png'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

 /*  void _onVerticalDragStart(DragStartDetails drag) {
    setState(() {
      _initialPosition = drag.globalPosition.dy;
    });
  }

  void _onVerticalDragUpdate(DragUpdateDetails drag) {
    setState(() {
      final temp = _currentPosition;
      _currentPosition = drag.globalPosition.dy - _initialPosition;
      if (_currentPosition < 0) {
        _currentPosition = temp;
      }
    });
  }

  void _onVerticalDragEnd(DragEndDetails drag) {
    if (_currentPosition > 100.0) {
      Navigator.pop(context);
      return;
    }
    setState(() {
      _currentPosition = 0.0;
    });
  } */
}
