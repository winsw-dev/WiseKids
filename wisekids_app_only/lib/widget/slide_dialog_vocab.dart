import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SlideDialogVocab extends StatefulWidget {
  final Widget child;

  SlideDialogVocab({
    @required this.child,
  });

  @override
  _SlideDialogVocabState createState() => _SlideDialogVocabState();
}

class _SlideDialogVocabState extends State<SlideDialogVocab> {
  //var _initialPosition = 0.0;
  //var _currentPosition = 0.0;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets + EdgeInsets.only(top: 0),
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
            Center(
              //////////////////////////// vocab
              child: Container(
                width: deviceHeight > 500
                    ? deviceWidth * 0.964
                    : deviceWidth * 0.964,
                //height: MediaQuery.of(context).size.height,
                child: Image.asset('assets/images/vocabulary/vocab.png'),
              ),
            ),
            //////////////////////////// close Btn
            Positioned.fill(
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(500),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.1),
                        blurRadius:
                            10.0, // has the effect of softening the shadow
                        spreadRadius:
                            -1, // has the effect of extending the shadow
                        offset: Offset(
                          0.0, // horizontal, move right 10
                          0.0, // vertical, move down 10
                        ),
                      ),
                    ],
                  ),
                  margin: EdgeInsets.only(
                      right: deviceHeight > 500
                          ? deviceHeight * 0.05
                          : deviceHeight * 0.05,
                      top: deviceHeight > 500
                          ? deviceHeight * 0.05
                          : deviceHeight * 0.05),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        return;
                      },
                      child: Container(
                        height: deviceHeight>500?deviceWidth*0.078:deviceWidth*0.078,
                        child: SvgPicture.asset(
                            'assets/images/vocabulary/closeBtn.svg'),
                      )),
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
