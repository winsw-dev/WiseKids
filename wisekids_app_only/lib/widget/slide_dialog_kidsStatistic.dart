import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:provider/provider.dart';
import '../provider/dataProvider.dart';

class SlideDialogKidsStatistic extends StatefulWidget {
  final Widget child;
  final Color backgroundColor;

  SlideDialogKidsStatistic({
    @required this.child,
    @required this.backgroundColor,
  });

  @override
  _SlideDialogKidsStatisticState createState() =>
      _SlideDialogKidsStatisticState();
}

class _SlideDialogKidsStatisticState extends State<SlideDialogKidsStatistic> {
  var _initialPosition = 0.0;
  var _currentPosition = 0.0;

  var avatarSwipeController = new SwiperController();

  List<String> mock = [
    'assets/images/kidsStatisticDialog/mock1.png',
    'assets/images/kidsStatisticDialog/mock2.png',
    'assets/images/kidsStatisticDialog/mock3.png',
    'assets/images/kidsStatisticDialog/mock4.png',
    'assets/images/kidsStatisticDialog/mock5.png',
    'assets/images/kidsStatisticDialog/mock6.png',
  ];

  
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets + EdgeInsets.all(0),
      /* MediaQuery.of(context).viewInsets +
          EdgeInsets.only(top: deviceHeight / 3.0 + _currentPosition), */
      duration: Duration(milliseconds: 100),
      curve: Curves.bounceInOut,
      child: MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: context,
        child: Center(
          child: Stack(
            children: <Widget>[
              Container(
                height: 440,
                child: Swiper(
                  viewportFraction: 0.9,
                  scale: 1.0,
                  itemCount: 6,
                  index: 0,
                  loop: false,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.only(left: 20,right: 20,),
                      height: 425,
                      width: 904,
                      child: Image.asset(
                          mock[index]),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onVerticalDragStart(DragStartDetails drag) {
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
  }
}

class SelectThemeWidget extends StatefulWidget {
  String themePath;
  double deviceHeight;
  bool visible;

  SelectThemeWidget({
    @required this.themePath,
    Key key,
    @required this.deviceHeight,
    @required this.visible,
  }) : super(key: key);

  @override
  _SelectThemeWidgetState createState() => _SelectThemeWidgetState();
}

class _SelectThemeWidgetState extends State<SelectThemeWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: widget.deviceHeight > 500
              ? widget.deviceHeight * 0.08
              : widget.deviceHeight * 0.08,
          child: Image.asset(widget.themePath),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: Visibility(
              visible: widget.visible,
              child: Container(
                height: widget.deviceHeight > 500
                    ? widget.deviceHeight * 0.034
                    : widget.deviceHeight * 0.034,
                child: Image.asset('assets/images/themePopup/theme1Choose.png'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
