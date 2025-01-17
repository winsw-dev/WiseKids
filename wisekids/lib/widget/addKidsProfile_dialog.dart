import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'dart:math';
import '../provider/audioProvider.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../provider/dataProvider.dart';

import '../widget/selectAvatar_addKidsProfile_dialog.dart'
    as selectAvatarAddKidsDialog;

Future<T> showSlideDialog<T>({
  @required BuildContext context,
  Color barrierColor,
  bool barrierDismissible = true,
  String popUpMode,
  int editWhichKid,
  Duration transitionDuration = const Duration(milliseconds: 300),
}) {
  assert(context != null);

  return showGeneralDialog(
    context: context,
    pageBuilder: (context, animation1, animation2) {},
    barrierColor: barrierColor ?? Colors.black.withOpacity(0.6),
    //barrierDismissible: barrierDismissible,
    barrierDismissible: false,
    barrierLabel: "Dismiss",
    transitionDuration: transitionDuration,
    transitionBuilder: (context, animation1, animation2, widget) {
      final curvedValue = Curves.easeInOut.transform(animation1.value) - 1.0;
      /* return /* Transform(
        //transform: Matrix4.translationValues(0.0, curvedValue * -300, 0.0),
        child: */
          Opacity(
        opacity: animation1.value,
        child: AddMoreKids(
          popUpMode: popUpMode,
          editWhichKid: editWhichKid,
        ),
      ); */
      return ScaleTransition(
        alignment: Alignment.center,
        scale: CurvedAnimation(
          parent: animation1,
          curve: SpringCurve(),
          reverseCurve: SpringReverseCurve(),
        ),
        child: Opacity(
          opacity: animation1.value,
          child: AddMoreKids(
            popUpMode: popUpMode,
            editWhichKid: editWhichKid,
          ),
        ),
      );
      /* ); */
    },
  );
}

class SpringCurve extends Curve {
  const SpringCurve({
    this.a = 0.22,
    this.w = 6.5,
  });
  final double a;
  final double w;

  @override
  double transformInternal(double t) {
    return -(pow(e, -t / a) * cos(t * w)) + 1;
  }
}

class SpringReverseCurve extends Curve {
  const SpringReverseCurve({
    this.a = 0.15,
    this.w = 6.5,
  });
  final double a;
  final double w;

  @override
  double transformInternal(double t) {
    return -(pow(e, -t / a) * cos(t * w)) + 1;
  }
}
//////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////

class AddMoreKids extends StatefulWidget {
  final int editWhichKid;
  final String popUpMode;
  AddMoreKids({Key key, @required this.popUpMode, this.editWhichKid})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => AddMoreKidsState();
}

class AddMoreKidsState extends State<AddMoreKids>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  double textfieldRoundEdge = 10.0;
  int _addKidsAge;
  final _textControllerName = TextEditingController();
  bool _buttonSwitch = false;

  bool _perventMultipleTab = true;

  ///////////////////////////////////////////// use this override to prevent [ setState() called after dispose() ] error!!
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  /////////////////////////////////////////////
  @override
  void initState() {
    super.initState();

    /* controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.bounceOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward(); */
  }

  checkNameAndAge() {
    if (_addKidsAge != null && _textControllerName.text != '') {
      setState(() {
        _buttonSwitch = true;
      });
    } else {
      _buttonSwitch = false;
    }
  }

  checkNameAndAgeEditMode() {
    if (_addKidsAge != null || _textControllerName.text != '') {
      setState(() {
        _buttonSwitch = true;
      });
    } else {
      _buttonSwitch = false;
    }
  }

  //////////////////////////////////////////////////// Age picker
  showPickerModal(BuildContext context) {
    Picker(
        adapter: NumberPickerAdapter(data: [
          NumberPickerColumn(
            begin: 1,
            end: 9,
            suffix: Provider.of<DataProvider>(context, listen: false)
                        .parentAreaLanguage ==
                    "TH"
                ? Text(
                    " ขวบ",
                  )
                : Text(" years old"),
          ),
        ]),
        textScaleFactor: 1,
        itemExtent: 50,
        confirmText: Provider.of<DataProvider>(context, listen: false)
                    .parentAreaLanguage ==
                "TH"
            ? 'ตกลง'
            : 'confirm',
        cancelText: Provider.of<DataProvider>(context, listen: false)
                    .parentAreaLanguage ==
                "TH"
            ? 'ยกเลิก'
            : 'cancel',
        confirmTextStyle: TextStyle(
          color: Color.fromRGBO(69, 223, 224, 1.0),
          fontSize: 18,
          fontFamily: 'NunitoRegular',
        ),
        cancelTextStyle: TextStyle(
          color: Color.fromRGBO(160, 163, 168, 1.0),
          fontSize: 18,
          fontFamily: 'NunitoRegular',
        ),
        hideHeader: false,
        selectedTextStyle:
            TextStyle(color: Color.fromRGBO(69, 223, 224, 1.0), fontSize: 25),
        onConfirm: (Picker picker, List value) {
          //print(value.toString());
          var age = json.decode(picker.adapter.text);
          print('Age: ' + age[0].toString() + ' years old selected');
          setState(() {
            _addKidsAge = age[0];
          });
          widget.popUpMode == 'createProfile'
              ? checkNameAndAge()
              : checkNameAndAgeEditMode();
        }).showModal(this.context); //_scaffoldKey.currentState);
  }

  _addKids() {
    /////////////////////// limited 5 kids profiles per account.
    if (Provider.of<DataProvider>(context, listen: false).kidsName.length < 5) {
      Provider.of<DataProvider>(context, listen: false).addKids(
          _addKidsAge.toString(),
          Provider.of<DataProvider>(context, listen: false).addkidsAvatar,
          _textControllerName.text,
          Provider.of<DataProvider>(context, listen: false).addkidsTheme);
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(30),
          /* child: ScaleTransition(
            scale: scaleAnimation, */
          child: Container(
            height:
                deviceHeight > 500 ? deviceHeight * 0.5 : deviceHeight * 0.85,
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
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(87, 87, 87, 0.40),
                    blurRadius: 20.0, // has the effect of softening the shadow
                    spreadRadius: -1, // has the effect of extending the shadow
                    offset: Offset(
                      0.0, // horizontal, move right 10
                      5.0, // vertical, move down 10
                    ),
                  ),
                ],
                //color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: AspectRatio(
              aspectRatio: 642 / 381,
              child: Container(
                  child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      /////////////////////////////// Create New User Text
                      Container(
                        height:
                            Provider.of<DataProvider>(context, listen: false)
                                        .parentAreaLanguage ==
                                    "TH"
                                ? deviceHeight > 500
                                    ? (deviceHeight * 0.5) * 0.115
                                    : (deviceHeight * 0.85) * 0.115
                                : deviceHeight > 500
                                    ? (deviceHeight * 0.5) * 0.1
                                    : (deviceHeight * 0.85) * 0.1,
                        margin: EdgeInsets.only(
                            left: deviceHeight > 500
                                ? (deviceHeight * 0.5) * (52 / 381)
                                : (deviceHeight * 0.85) * (52 / 381),
                            top: deviceHeight > 500
                                ? (deviceHeight * 0.5) * 0.11
                                : (deviceHeight * 0.85) * 0.11,
                            bottom: deviceHeight > 500
                                ? (deviceHeight * 0.5) * (20 / 381)
                                : (deviceHeight * 0.85) * (20 / 381)),
                        child: Provider.of<DataProvider>(context, listen: false)
                                    .parentAreaLanguage ==
                                "TH"
                            ? FittedBox(
                                fit: BoxFit.fitHeight,
                                child: widget.popUpMode == 'createProfile'
                                    ? Text('สร้างโปรไฟล์ใหม่',
                                        style: TextStyle(
                                          fontFamily: 'PromptSemiBold',
                                          color: Colors
                                              .white /* Color.fromRGBO(69, 223, 224, 1.0) */,
                                        ))
                                    : Text('แก้ไขโปรไฟล์',
                                        style: TextStyle(
                                          fontFamily: 'PromptSemiBold',
                                          color: Colors
                                              .white /* Color.fromRGBO(69, 223, 224, 1.0) */,
                                        )),
                              )
                            : FittedBox(
                                fit: BoxFit.fitHeight,
                                child: widget.popUpMode == 'createProfile'
                                    ? Text('Create New Profile',
                                        style: TextStyle(
                                          fontFamily: 'NunitoExtraBold',
                                          color: Colors
                                              .white /* Color.fromRGBO(69, 223, 224, 1.0) */,
                                        ))
                                    : Text('Edit Profile',
                                        style: TextStyle(
                                          fontFamily: 'NunitoExtraBold',
                                          color: Colors
                                              .white /* Color.fromRGBO(69, 223, 224, 1.0) */,
                                        )),
                              ),
                      ),
                      Spacer(),
                      //////////////////////////////////////////// Close Btn
                      GestureDetector(
                        onTap: _perventMultipleTab
                            ? () {
                                setState(() {
                                  _perventMultipleTab = false;
                                });

                                Timer(
                                    Duration(seconds: 1),
                                    () => setState(
                                        () => _perventMultipleTab = true));
                                Provider.of<AudioProvider>(context,
                                        listen: false)
                                    .playSoundEffect("click3", 1.0);

                                Navigator.pop(context);

                                /////////////////////////////////// prevent flickering when dismiss dialog
                                Future.delayed(
                                    const Duration(milliseconds: 300), () {
                                  Provider.of<DataProvider>(context,
                                          listen: false)
                                      .resetAddKids();
                                });
                              }
                            : null,
                        child: Container(
                          margin: EdgeInsets.only(
                              top: deviceHeight > 500
                                  ? (deviceHeight * 0.5) * 0.04
                                  : (deviceHeight * 0.85) * 0.04,
                              right: deviceHeight > 500
                                  ? (deviceHeight * 0.5) * 0.04
                                  : (deviceHeight * 0.85) * 0.04),
                          height: deviceHeight > 500
                              ? (deviceHeight * 0.5) * 0.09
                              : (deviceHeight * 0.85) * 0.09,
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: SvgPicture.asset(
                              'assets/images/loginDialog/close.svg',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      //////////////////////////////////// Avatar Select overall
                      GestureDetector(
                        onTap: widget.popUpMode == 'createProfile'
                            ? () {
                                Provider.of<AudioProvider>(context,
                                        listen: false)
                                    .playSoundEffect("select", 1.0);
                                /* Provider.of<DataProvider>(context,
                                                    listen: false)
                                                .initEditKidsProfileCacheVar(widget.editWhichKid); */
                                selectAvatarAddKidsDialog.showSlideDialog(
                                  popUpMode: widget.popUpMode,
                                  editWhichKid: widget.editWhichKid,
                                  context: context,
                                  child: Container(
                                    color: Colors.white,
                                  ),
                                );
                              }
                            : () {},
                        child: Container(
                          margin: EdgeInsets.only(
                            left: deviceHeight > 500
                                ? (deviceHeight * 0.5) * (104 / 381)
                                : (deviceHeight * 0.85) * (104 / 381),
                          ),
                          height: deviceHeight > 500
                              ? (deviceHeight * 0.5) * (162 / 381)
                              : (deviceHeight * 0.85) * (162 / 381),
                          child: AspectRatio(
                            aspectRatio: 162 / 156,
                            child: Stack(
                              children: <Widget>[
                                ////////////////////////////////////////////////// Avatar Select Pic
                                Container(
                                  width: deviceHeight > 500
                                      ? (deviceHeight * 0.5) * (156 / 381)
                                      : (deviceHeight * 0.85) * (156 / 381),
                                  /* margin: EdgeInsets.only(
                                        top: deviceHeight > 500
                                            ? (deviceHeight * 0.5) * (20 / 381)
                                            : (deviceHeight * 0.85) * (20 / 381)), */
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(1000),
                                    /* border: Border.all(
                                          width: deviceHeight > 500 ? 6 : 3,
                                          color: Color.fromRGBO(238, 239, 243,
                                              1.0) //                   <--- border width here
                                          ), */
                                  ),
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Consumer<DataProvider>(
                                        builder: (context, avatar, child) {
                                      return ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(1000),
                                        child:
                                            widget.popUpMode == 'createProfile'
                                                ? Image.asset(
                                                    'assets/images/avatar_' +
                                                        avatar.addkidsAvatar +
                                                        '.png',
                                                    gaplessPlayback: true,
                                                  )
                                                : Image.asset(
                                                    'assets/images/avatar_' +
                                                        avatar
                                                            .cacheEditKidsProfileAvatar +
                                                        '.png',
                                                    gaplessPlayback: true,
                                                  ),
                                      );
                                    }),
                                  ),
                                ),
                                /////////////////////////////////////////////////// Edit Icon
                                Positioned.fill(
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Stack(
                                      children: <Widget>[
                                        Container(
                                          height: deviceHeight > 500
                                              ? (deviceHeight * 0.5) *
                                                  (50 / 381)
                                              : (deviceHeight * 0.85) *
                                                  (50 / 381),
                                          child: AspectRatio(
                                            aspectRatio: 1,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Color.fromRGBO(
                                                        160, 163, 168, 0.30),
                                                    blurRadius:
                                                        12.0, // has the effect of softening the shadow
                                                    spreadRadius:
                                                        -1, // has the effect of extending the shadow
                                                    offset: Offset(
                                                      0.0, // horizontal, move right 10
                                                      2.0, // vertical, move down 10
                                                    ),
                                                  ),
                                                ],
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(1000),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned.fill(
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Container(
                                              height: deviceHeight > 500
                                                  ? (deviceHeight * 0.5) *
                                                      (25 / 381)
                                                  : (deviceHeight * 0.85) *
                                                      (25 / 381),
                                              child: SvgPicture.asset(
                                                'assets/images/parentalKidsCenter/pencil.svg',
                                                color: Color.fromRGBO(
                                                    248, 226, 55, 1.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      ////////////////////////////////////////////////////// Kid's Name and Kid's Age Column
                      Spacer(),
                      Container(
                        margin: EdgeInsets.only(
                          right: deviceHeight > 500
                              ? (deviceHeight * 0.5) * (52 / 381)
                              : (deviceHeight * 0.85) * (52 / 381),
                        ),
                        height: deviceHeight > 500
                            ? (deviceHeight * 0.5) * (162 / 381)
                            : (deviceHeight * 0.85) * (162 / 381),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          /////////////////////////// Kids name text
                          children: <Widget>[
                            Container(
                              height: deviceHeight > 500
                                  ? (deviceHeight * 0.5) * (27 / 381)
                                  : (deviceHeight * 0.85) * (27 / 381),
                              child: FittedBox(
                                fit: BoxFit.fitHeight,
                                child: Provider.of<DataProvider>(context,
                                                listen: false)
                                            .parentAreaLanguage ==
                                        "TH"
                                    ? Text('ชื่อเล่น',
                                        style: TextStyle(
                                          fontFamily: 'PromptLight',
                                          //fontSize: deviceHeight > 500 ? 20 : 16,
                                          color: Colors.white
                                          /* Color.fromRGBO(69, 223, 224, 1.0) */,
                                        ))
                                    : Text('Kid\'s Name ',
                                        style: TextStyle(
                                          fontFamily: 'NunitoRegular',
                                          //fontSize: deviceHeight > 500 ? 20 : 16,
                                          color: Colors.white
                                          /* Color.fromRGBO(69, 223, 224, 1.0) */,
                                        )),
                              ),
                            ),
                            //////////////////////////// Kids name textfield
                            Container(
                              margin: EdgeInsets.only(
                                  top: deviceHeight > 500
                                      ? (deviceHeight * 0.5) * (4 / 381)
                                      : (deviceHeight * 0.85) * (4 / 381)),
                              height: deviceHeight > 500
                                  ? (deviceHeight * 0.5) * (45 / 381)
                                  : (deviceHeight * 0.85) * (45 / 381),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromRGBO(160, 163, 168, 0.16),
                                    blurRadius:
                                        6.0, // has the effect of softening the shadow
                                    spreadRadius:
                                        0, // has the effect of extending the shadow
                                    offset: Offset(
                                      0.0, // horizontal, move right 10
                                      3.0, // vertical, move down 10
                                    ),
                                  ),
                                ],
                              ),
                              child: AspectRatio(
                                aspectRatio: 222 / 45,
                                child: TextFormField(
                                  onChanged: (text) {
                                    widget.popUpMode == 'createProfile'
                                        ? checkNameAndAge()
                                        : checkNameAndAgeEditMode();
                                  },
                                  controller: _textControllerName,
                                  maxLines: 1,
                                  inputFormatters: [
                                    BlacklistingTextInputFormatter(new RegExp(
                                        '[.,0123456789@":;?><()_=/!-*-+#%^&]')),
                                  ],
                                  cursorColor:
                                      Color.fromRGBO(132, 134, 148, 0.50),
                                  decoration:
                                      new InputDecoration /* .collapsed */ (
                                    hintText: /* null */ widget.popUpMode ==
                                            'createProfile'
                                        ? Provider.of<DataProvider>(context,
                                                        listen: false)
                                                    .parentAreaLanguage ==
                                                "TH"
                                            ? 'กรอกชื่อเล่น'
                                            : 'Type Kid\'s Name...'
                                        : Provider.of<DataProvider>(context,
                                                listen: false)
                                            .kidsName[widget.editWhichKid],
                                    hintStyle: Provider.of<DataProvider>(
                                                    context,
                                                    listen: false)
                                                .parentAreaLanguage ==
                                            "TH"
                                        ? TextStyle(
                                            fontFamily: 'PromptLight',
                                            color: Color.fromRGBO(
                                                132, 134, 148, 1.0))
                                        : TextStyle(
                                            color: Color.fromRGBO(
                                                132, 134, 148, 1.0)),
                                    contentPadding: EdgeInsets.only(left: 15),
                                    filled: true,
                                    fillColor: Colors.white
                                    /* Color.fromRGBO(238, 239, 243, 1.0) */,
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                textfieldRoundEdge)),
                                        borderSide: BorderSide(
                                            width: 1,
                                            color: Colors
                                                .transparent /* Color.fromRGBO(
                                                  170, 170, 170, 0.14) */
                                            )),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(textfieldRoundEdge)),
                                      borderSide: const BorderSide(
                                          color: Colors
                                              .transparent /* Color.fromRGBO(
                                                170, 170, 170, 0.14) */
                                          ,
                                          width: 0.0),
                                    ),
                                    border: new OutlineInputBorder(
                                        //InputBorder.none,
                                        borderRadius: new BorderRadius.circular(
                                            textfieldRoundEdge),
                                        borderSide:
                                            new BorderSide(color: Colors.teal)),
                                  ),
                                  //textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: deviceHeight > 500 ? 13 : 11,
                                    fontFamily: 'NunitoRegular',
                                    //fontSize: deviceHeight > 500 ? 20 : 16,
                                    color: Color.fromRGBO(132, 134, 148, 1.00),
                                  ),
                                ),
                              ),
                            ),
                            /////////////////////////// Kids Age text
                            Spacer(),
                            Container(
                              height: deviceHeight > 500
                                  ? (deviceHeight * 0.5) * (27 / 381)
                                  : (deviceHeight * 0.85) * (27 / 381),
                              child: FittedBox(
                                fit: BoxFit.fitHeight,
                                child: Provider.of<DataProvider>(context,
                                                listen: false)
                                            .parentAreaLanguage ==
                                        "TH"
                                    ? Text('อายุ',
                                        style: TextStyle(
                                          fontFamily: 'PromptLight',
                                          //fontSize: deviceHeight > 500 ? 20 : 16,
                                          color: Colors.white
                                          /* Color.fromRGBO(69, 223, 224, 1.0) */,
                                        ))
                                    : Text('Kid\'s Age ',
                                        style: TextStyle(
                                          fontFamily: 'NunitoRegular',
                                          //fontSize: deviceHeight > 500 ? 20 : 16,
                                          color: Colors.white
                                          /* Color.fromRGBO(69, 223, 224, 1.0) */,
                                        )),
                              ),
                            ),

                            Stack(
                              children: <Widget>[
                                //////////////////////////// Kids Age textfield
                                Container(
                                  margin: EdgeInsets.only(
                                      top: deviceHeight > 500
                                          ? (deviceHeight * 0.5) * (4 / 381)
                                          : (deviceHeight * 0.85) * (4 / 381)),
                                  height: deviceHeight > 500
                                      ? (deviceHeight * 0.5) * (45 / 381)
                                      : (deviceHeight * 0.85) * (45 / 381),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Color.fromRGBO(160, 163, 168, 0.16),
                                        blurRadius:
                                            6.0, // has the effect of softening the shadow
                                        spreadRadius:
                                            0, // has the effect of extending the shadow
                                        offset: Offset(
                                          0.0, // horizontal, move right 10
                                          3.0, // vertical, move down 10
                                        ),
                                      ),
                                    ],
                                  ),
                                  child: AspectRatio(
                                      aspectRatio: 222 / 45,
                                      child: Consumer<DataProvider>(
                                          builder: (context, provider, child) =>
                                              TextFormField(
                                                enabled: false,
                                                maxLines: 1,
                                                inputFormatters: [
                                                  WhitelistingTextInputFormatter
                                                      .digitsOnly,
                                                  BlacklistingTextInputFormatter(
                                                      new RegExp('[0]')),
                                                ],
                                                cursorColor: Color.fromRGBO(
                                                    248, 226, 55, 1.00),
                                                decoration: widget.popUpMode ==
                                                        'createProfile'
                                                    ? new InputDecoration /* .collapsed */ (
                                                        hintText: /* null */ /* Provider
                                                            .of<DataProvider>(
                                                                context,
                                                                listen: false)
                                                        .addkidAge == */
                                                            _addKidsAge == null
                                                                ? Provider.of<DataProvider>(context, listen: false)
                                                                            .parentAreaLanguage ==
                                                                        "TH"
                                                                    ? 'เลือกอายุ'
                                                                    : 'Select kid\'s Age...'
                                                                : /* Provider.of<DataProvider>(
                                                            context,
                                                            listen: false)
                                                        .addkidAge */
                                                                _addKidsAge
                                                                        .toString() +
                                                                    ' years old',
                                                        hintStyle: Provider.of<DataProvider>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .parentAreaLanguage ==
                                                                "TH"
                                                            ? TextStyle(
                                                                fontFamily:
                                                                    'PromptLight',
                                                                color: Color
                                                                    .fromRGBO(
                                                                        132,
                                                                        134,
                                                                        148,
                                                                        1.0))
                                                            : TextStyle(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        132,
                                                                        134,
                                                                        148,
                                                                        1.0)),
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                                left: 15),
                                                        filled: true,
                                                        fillColor: Colors
                                                            .white /* Color.fromRGBO(
                                                238, 239, 243, 1.0) */
                                                        ,
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            textfieldRoundEdge)),
                                                                borderSide: BorderSide(
                                                                    width: 1,
                                                                    color: Colors
                                                                        .transparent /* Color.fromRGBO(
                                                          170, 170, 170, 0.14) */
                                                                    )),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      textfieldRoundEdge)),
                                                          borderSide:
                                                              const BorderSide(
                                                                  color: Colors
                                                                      .transparent /* Color.fromRGBO(
                                                        170, 170, 170, 0.14) */
                                                                  ,
                                                                  width: 0.0),
                                                        ),
                                                        disabledBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      textfieldRoundEdge)),
                                                          borderSide:
                                                              const BorderSide(
                                                                  color: Colors
                                                                      .transparent /* Color.fromRGBO(
                                                        170, 170, 170, 0.14) */
                                                                  ,
                                                                  width: 0.0),
                                                        ),
                                                        border:
                                                            new OutlineInputBorder(
                                                                //InputBorder.none,
                                                                borderRadius:
                                                                    new BorderRadius
                                                                            .circular(
                                                                        textfieldRoundEdge),
                                                                borderSide: new BorderSide(
                                                                    color: Colors
                                                                        .teal)),
                                                      )
                                                    :
                                                    //////////////////////////////////// edit profile mode age
                                                    new InputDecoration /* .collapsed */ (
                                                        hintText: _addKidsAge ==
                                                                null
                                                            ? provider.kidsAge[
                                                                    widget
                                                                        .editWhichKid] +
                                                                ' years old'
                                                            : _addKidsAge
                                                                    .toString() +
                                                                ' years old',
                                                        hintStyle: TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    132,
                                                                    134,
                                                                    148,
                                                                    1.0)),
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                                left: 15),
                                                        filled: true,
                                                        fillColor: Colors
                                                            .white /* Color.fromRGBO(
                                                238, 239, 243, 1.0) */
                                                        ,
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            textfieldRoundEdge)),
                                                                borderSide: BorderSide(
                                                                    width: 1,
                                                                    color: Colors
                                                                        .transparent /* Color.fromRGBO(
                                                          170, 170, 170, 0.14) */
                                                                    )),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      textfieldRoundEdge)),
                                                          borderSide:
                                                              const BorderSide(
                                                                  color: Colors
                                                                      .transparent /* Color.fromRGBO(
                                                        170, 170, 170, 0.14) */
                                                                  ,
                                                                  width: 0.0),
                                                        ),
                                                        disabledBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      textfieldRoundEdge)),
                                                          borderSide:
                                                              const BorderSide(
                                                                  color: Colors
                                                                      .transparent /* Color.fromRGBO(
                                                        170, 170, 170, 0.14) */
                                                                  ,
                                                                  width: 0.0),
                                                        ),
                                                        border:
                                                            new OutlineInputBorder(
                                                                //InputBorder.none,
                                                                borderRadius:
                                                                    new BorderRadius
                                                                            .circular(
                                                                        textfieldRoundEdge),
                                                                borderSide: new BorderSide(
                                                                    color: Colors
                                                                        .teal)),
                                                      ),
                                                //textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: deviceHeight > 500
                                                      ? 13
                                                      : 11,
                                                  fontFamily: 'NunitoRegular',
                                                  //fontSize: deviceHeight > 500 ? 20 : 16,
                                                  color: Color.fromRGBO(
                                                      132, 134, 148, 1.00),
                                                ),
                                              ))),
                                ),
                                ////////////////////////////////////  Age select Icon
                                Positioned.fill(
                                  child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        margin: EdgeInsets.only(right: 10),
                                        height: 20,
                                        child: SvgPicture.asset(
                                          'assets/icon/arrowDown.svg',
                                          color: Color.fromRGBO(
                                              132, 134, 148, 1.00),
                                        ),
                                      )),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Provider.of<AudioProvider>(context,
                                            listen: false)
                                        .playSoundEffect("select", 1.0);
                                    showPickerModal(context);
                                  },
                                  child: Container(
                                    height: deviceHeight > 500
                                        ? (deviceHeight * 0.5) * (45 / 381)
                                        : (deviceHeight * 0.85) * (45 / 381),
                                    child: AspectRatio(
                                      aspectRatio: 222 / 45,
                                      child: Container(
                                        color: Colors.transparent,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  ///////////////////////////////////////// Btn Row
                  Spacer(),
                  Row(
                    children: <Widget>[
                      ///////////////////////////////////// Cancel Btn
                      Padding(
                        padding: EdgeInsets.only(
                            left: deviceHeight > 500
                                ? (deviceHeight * 0.5) * (52 / 381)
                                : (deviceHeight * 0.85) * (52 / 381)),
                        child: GestureDetector(
                          onTap: _perventMultipleTab
                              ? () {
                                  setState(() {
                                    _perventMultipleTab = false;
                                  });

                                  Timer(
                                      Duration(seconds: 1),
                                      () => setState(
                                          () => _perventMultipleTab = true));
                                  Provider.of<AudioProvider>(context,
                                          listen: false)
                                      .playSoundEffect("click3", 1.0);

                                  Navigator.pop(context);
                                  /////////////////////////////////// prevent flickering when dismiss dialog
                                  Future.delayed(
                                      const Duration(milliseconds: 300), () {
                                    Provider.of<DataProvider>(context,
                                            listen: false)
                                        .resetAddKids();
                                  });
                                }
                              : null,
                          child: Stack(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                      width: deviceHeight > 500 ? 3 : 3,
                                      color: Color.fromRGBO(248, 226, 55,
                                          1.0) //                   <--- border width here
                                      ),
                                  color: Colors
                                      .white /* Color.fromRGBO(244, 244, 248, 1.0) */,
                                ),
                                height: deviceHeight > 500
                                    ? (deviceHeight * 0.5) * (54 / 381)
                                    : (deviceHeight * 0.85) * (54 / 381),
                                child: AspectRatio(
                                  aspectRatio: 153 / 54,
                                ),
                              ),
                              ////////////////////////////// Text Cancel
                              Positioned.fill(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    height: deviceHeight > 500
                                        ? (deviceHeight * 0.5) * (30 / 381)
                                        : (deviceHeight * 0.85) * (30 / 381),
                                    child: FittedBox(
                                      fit: BoxFit.fitHeight,
                                      child: Provider.of<DataProvider>(context,
                                                      listen: false)
                                                  .parentAreaLanguage ==
                                              "TH"
                                          ? Text(
                                              'ยกเลิก',
                                              style: TextStyle(
                                                fontFamily: 'PromptMedium',
                                                //fontSize: deviceHeight > 500 ? 20 : 16,
                                                color: Color.fromRGBO(
                                                    248, 226, 55, 1.0),
                                              ),
                                            )
                                          : Text(
                                              'Cancel',
                                              style: TextStyle(
                                                fontFamily: 'NunitoBold',
                                                //fontSize: deviceHeight > 500 ? 20 : 16,
                                                color: Color.fromRGBO(
                                                    248, 226, 55, 1.0),
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Spacer(),
                      ///////////////////////////////////// Create Btn
                      Padding(
                        padding: EdgeInsets.only(
                            right: deviceHeight > 500
                                ? (deviceHeight * 0.5) * (52 / 381)
                                : (deviceHeight * 0.85) * (52 / 381)),
                        child: Stack(
                          children: <Widget>[
                            ////////////////////////////////// disable
                            !_buttonSwitch
                                ? Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color.fromRGBO(
                                              160, 163, 168, 0.16),
                                          blurRadius:
                                              6.0, // has the effect of softening the shadow
                                          spreadRadius:
                                              0, // has the effect of extending the shadow
                                          offset: Offset(
                                            0.0, // horizontal, move right 10
                                            3.0, // vertical, move down 10
                                          ),
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(30),
                                      color: Color.fromRGBO(244, 244, 248, 1.0),
                                    ),
                                    height: deviceHeight > 500
                                        ? (deviceHeight * 0.5) * (54 / 381)
                                        : (deviceHeight * 0.85) * (54 / 381),
                                    child: AspectRatio(
                                      aspectRatio: 167 / 54,
                                    ),
                                  )
                                :
                                /////////////////////////////////// enable
                                GestureDetector(
                                    onTap: _perventMultipleTab
                                        ? () async {
                                            setState(() {
                                              _perventMultipleTab = false;
                                            });

                                            Timer(
                                                Duration(seconds: 1),
                                                () => setState(() =>
                                                    _perventMultipleTab =
                                                        true));
                                            Provider.of<AudioProvider>(context,
                                                    listen: false)
                                                .playSoundEffect("click2", 1.0);
                                            if (widget.popUpMode ==
                                                'createProfile') {
                                              await _addKids();
                                            } else {
                                              var editInputAge;
                                              var editInputName;

                                              if (_addKidsAge == null) {
                                                editInputAge =
                                                    Provider.of<DataProvider>(
                                                                context,
                                                                listen: false)
                                                            .kidsAge[
                                                        widget.editWhichKid];
                                              } else {
                                                editInputAge = _addKidsAge;
                                              }
                                              if (_textControllerName.text ==
                                                  '') {
                                                editInputName =
                                                    Provider.of<DataProvider>(
                                                                context,
                                                                listen: false)
                                                            .kidsName[
                                                        widget.editWhichKid];
                                              } else {
                                                editInputName =
                                                    _textControllerName.text;
                                              }
                                              await Provider.of<DataProvider>(
                                                      context,
                                                      listen: false)
                                                  .saveEditKidsProfile(
                                                      whichKids:
                                                          widget.editWhichKid,
                                                      kidsAgeInput: editInputAge
                                                          .toString(),
                                                      kidsNameInput:
                                                          editInputName,
                                                      kidsAvatarInput: Provider
                                                              .of<DataProvider>(
                                                                  context,
                                                                  listen: false)
                                                          .cacheEditKidsProfileAvatar,
                                                      kidsThemeInput: Provider
                                                              .of<DataProvider>(
                                                                  context,
                                                                  listen: false)
                                                          .cacheEditKidsProfileTheme);
                                            }

                                            Navigator.pop(context);
                                            /////////////////////////////////// prevent flickering when dismiss dialog
                                            Future.delayed(
                                                const Duration(
                                                    milliseconds: 250), () {
                                              widget.popUpMode ==
                                                      'createProfile'
                                                  ? Provider.of<DataProvider>(
                                                          context,
                                                          listen: false)
                                                      .resetAddKids()
                                                  : null;
                                            });
                                          }
                                        : null,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Color.fromRGBO(248, 226, 55, 1.0)
                                        /* Color.fromRGBO(69, 223, 224, 1.0) */,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color.fromRGBO(
                                                160, 163, 168, 0.16),
                                            blurRadius:
                                                6.0, // has the effect of softening the shadow
                                            spreadRadius:
                                                0, // has the effect of extending the shadow
                                            offset: Offset(
                                              0.0, // horizontal, move right 10
                                              3.0, // vertical, move down 10
                                            ),
                                          ),
                                        ],
                                      ),
                                      height: deviceHeight > 500
                                          ? (deviceHeight * 0.5) * (54 / 381)
                                          : (deviceHeight * 0.85) * (54 / 381),
                                      child: AspectRatio(
                                        aspectRatio: 167 / 54,
                                      ),
                                    ),
                                  ),
                            ////////////////////////////// Text Create Profile
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.center,
                                child: GestureDetector(
                                  onTap: _buttonSwitch
                                      ? _perventMultipleTab
                                          ? () async {
                                              setState(() {
                                                _perventMultipleTab = false;
                                              });

                                              Timer(
                                                  Duration(seconds: 1),
                                                  () => setState(() =>
                                                      _perventMultipleTab =
                                                          true));
                                              Provider.of<AudioProvider>(
                                                      context,
                                                      listen: false)
                                                  .playSoundEffect(
                                                      "click2", 1.0);
                                              if (widget.popUpMode ==
                                                  'createProfile') {
                                                await _addKids();
                                              } else {
                                                var editInputAge;
                                                var editInputName;

                                                if (_addKidsAge == null) {
                                                  editInputAge =
                                                      Provider.of<DataProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .kidsAge[
                                                          widget.editWhichKid];
                                                } else {
                                                  editInputAge = _addKidsAge;
                                                }
                                                if (_textControllerName.text ==
                                                    '') {
                                                  editInputName =
                                                      Provider.of<DataProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .kidsName[
                                                          widget.editWhichKid];
                                                } else {
                                                  editInputName =
                                                      _textControllerName.text;
                                                }
                                                await Provider.of<DataProvider>(
                                                        context,
                                                        listen: false)
                                                    .saveEditKidsProfile(
                                                        whichKids:
                                                            widget.editWhichKid,
                                                        kidsAgeInput:
                                                            editInputAge,
                                                        kidsNameInput:
                                                            editInputName,
                                                        kidsAvatarInput: Provider
                                                                .of<DataProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                            .cacheEditKidsProfileAvatar,
                                                        kidsThemeInput: Provider
                                                                .of<DataProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                            .cacheEditKidsProfileTheme);
                                              }

                                              Navigator.pop(context);
                                              /////////////////////////////////// prevent flickering when dismiss dialog
                                              Future.delayed(
                                                  const Duration(
                                                      milliseconds: 250), () {
                                                widget.popUpMode ==
                                                        'createProfile'
                                                    ? Provider.of<DataProvider>(
                                                            context,
                                                            listen: false)
                                                        .resetAddKids()
                                                    : null;
                                              });
                                            }
                                          : null
                                      : null,
                                  child: Container(
                                    height: deviceHeight > 500
                                        ? (deviceHeight * 0.5) * (30 / 381)
                                        : (deviceHeight * 0.85) * (30 / 381),
                                    child: FittedBox(
                                      fit: BoxFit.fitHeight,
                                      child: Provider.of<DataProvider>(context,
                                                      listen: false)
                                                  .parentAreaLanguage ==
                                              'TH'
                                          ? Text(
                                              widget.popUpMode ==
                                                      'createProfile'
                                                  ? 'สร้างโปรไฟล์'
                                                  : 'บันทึก',
                                              style: TextStyle(
                                                fontFamily: 'PromptMedium',
                                                //fontSize: deviceHeight > 500 ? 20 : 16,
                                                color: !_buttonSwitch
                                                    ? Color.fromRGBO(
                                                        209, 212, 217, 1.00)
                                                    : Colors.white,
                                              ),
                                            )
                                          : Text(
                                              widget.popUpMode ==
                                                      'createProfile'
                                                  ? 'Create Profile'
                                                  : 'Save',
                                              style: TextStyle(
                                                fontFamily: 'NunitoBold',
                                                //fontSize: deviceHeight > 500 ? 20 : 16,
                                                color: !_buttonSwitch
                                                    ? Color.fromRGBO(
                                                        209, 212, 217, 1.00)
                                                    : Colors.white,
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                ],
              )),
            ),
          ),
          /* ), */
        ),
      ),
    );
  }
}
