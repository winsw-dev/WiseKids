import 'package:flutter/material.dart';



class VocabuaryDialog extends StatefulWidget {
  final Widget child;
  

  VocabuaryDialog({
    @required this.child,
    
  });

  @override
  _VocabuaryDialogState createState() => _VocabuaryDialogState();
}

class _VocabuaryDialogState extends State<VocabuaryDialog> {
  var _initialPosition = 0.0;
  var _currentPosition = 0.0;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets +
          EdgeInsets.only(left: 8,right: 8,top: 19,bottom: 19),
      duration: Duration(milliseconds: 100),
      curve: Curves.decelerate,
      child: MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: context,
        child: widget.child,
      ),
    );
  }

  
}
