import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_picker/flutter_picker.dart';

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
  Duration transitionDuration = const Duration(milliseconds: 300),
}) {
  assert(context != null);

  return showGeneralDialog(
    context: context,
    pageBuilder: (context, animation1, animation2) {},
    barrierColor: barrierColor ?? Colors.black.withOpacity(0.2),
    //barrierDismissible: barrierDismissible,
    barrierDismissible: false,
    barrierLabel: "Dismiss",
    transitionDuration: transitionDuration,
    transitionBuilder: (context, animation1, animation2, widget) {
      final curvedValue = Curves.easeInOut.transform(animation1.value) - 1.0;
      return /* Transform(
        //transform: Matrix4.translationValues(0.0, curvedValue * -300, 0.0),
        child: */
          Opacity(
        opacity: animation1.value,
        child: AddMoreKids(),
      );
      /* ); */
    },
  );
}

class AddMoreKids extends StatefulWidget {
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

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.bounceOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
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

  //////////////////////////////////////////////////// Age picker
  showPickerModal(BuildContext context) {
    Picker(
        adapter: NumberPickerAdapter(data: [
          NumberPickerColumn(
            begin: 1,
            end: 9,
            suffix: Text(" years old"),
          ),
        ]),
        textScaleFactor: 1,
        itemExtent: 50,
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
          checkNameAndAge();
        }).showModal(this.context); //_scaffoldKey.currentState);
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
          child: ScaleTransition(
            scale: scaleAnimation,
            child: Container(
              height:
                  deviceHeight > 500 ? deviceHeight * 0.5 : deviceHeight * 0.85,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(87, 87, 87, 0.40),
                      blurRadius:
                          20.0, // has the effect of softening the shadow
                      spreadRadius:
                          -1, // has the effect of extending the shadow
                      offset: Offset(
                        0.0, // horizontal, move right 10
                        5.0, // vertical, move down 10
                      ),
                    ),
                  ],
                  color: Colors.white,
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
                          height: deviceHeight > 500
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
                          child: FittedBox(
                            fit: BoxFit.fitHeight,
                            child: Text('Create New Profile',
                                style: TextStyle(
                                  fontFamily: 'NunitoExtraBold',
                                  //fontSize: deviceHeight > 500 ? 20 : 16,
                                  color: Color.fromRGBO(69, 223, 224, 1.0),
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
                                ? (deviceHeight * 0.5) * 0.16
                                : (deviceHeight * 0.85) * 0.16,
                            child: Image.asset(
                                'assets/images/parentalKidsCenter/addMoreKidsPopup_closeBtn.png'),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        //////////////////////////////////// Avatar Select overall
                        GestureDetector(
                          onTap: () {
                            selectAvatarAddKidsDialog.showSlideDialog(
                              context: context,
                              child: Container(
                                color: Colors.white,
                              ),
                            );
                          },
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
                                      border: Border.all(
                                          width: deviceHeight > 500 ? 6 : 3,
                                          color: Color.fromRGBO(238, 239, 243,
                                              1.0) //                   <--- border width here
                                          ),
                                    ),
                                    child: AspectRatio(
                                      aspectRatio: 1,
                                      child: Consumer<DataProvider>(
                                          builder: (context, avatar, child) {
                                        return ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(1000),
                                          child: Image.asset(
                                            'assets/images/avatar_' +
                                                avatar.addkidsAvatar +
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
                                                      BorderRadius.circular(
                                                          1000),
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
                                  child: Text('Kid\'s Name ',
                                      style: TextStyle(
                                        fontFamily: 'NunitoRegular',
                                        //fontSize: deviceHeight > 500 ? 20 : 16,
                                        color:
                                            Color.fromRGBO(69, 223, 224, 1.0),
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
                                child: AspectRatio(
                                  aspectRatio: 222 / 45,
                                  child: TextFormField(
                                    onChanged: (text) {
                                      checkNameAndAge();
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
                                      hintText: /* null */ 'Type Your Name...',
                                      hintStyle: TextStyle(
                                          color: Color.fromRGBO(
                                              132, 134, 148, 1.0)),
                                      contentPadding: EdgeInsets.only(left: 15),
                                      filled: true,
                                      fillColor:
                                          Color.fromRGBO(238, 239, 243, 1.0),
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
                                            Radius.circular(
                                                textfieldRoundEdge)),
                                        borderSide: const BorderSide(
                                            color: Colors
                                                .transparent /* Color.fromRGBO(
                                                170, 170, 170, 0.14) */
                                            ,
                                            width: 0.0),
                                      ),
                                      border: new OutlineInputBorder(
                                          //InputBorder.none,
                                          borderRadius:
                                              new BorderRadius.circular(
                                                  textfieldRoundEdge),
                                          borderSide: new BorderSide(
                                              color: Colors.teal)),
                                    ),
                                    //textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: deviceHeight > 500 ? 13 : 11,
                                      fontFamily: 'NunitoRegular',
                                      //fontSize: deviceHeight > 500 ? 20 : 16,
                                      color:
                                          Color.fromRGBO(132, 134, 148, 1.00),
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
                                  child: Text('Kid\'s Age ',
                                      style: TextStyle(
                                        fontFamily: 'NunitoRegular',
                                        //fontSize: deviceHeight > 500 ? 20 : 16,
                                        color:
                                            Color.fromRGBO(69, 223, 224, 1.0),
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
                                            : (deviceHeight * 0.85) *
                                                (4 / 381)),
                                    height: deviceHeight > 500
                                        ? (deviceHeight * 0.5) * (45 / 381)
                                        : (deviceHeight * 0.85) * (45 / 381),
                                    child: AspectRatio(
                                        aspectRatio: 222 / 45,
                                        child: TextFormField(
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
                                          decoration:
                                              new InputDecoration /* .collapsed */ (
                                            hintText: /* null */ /* Provider
                                                            .of<DataProvider>(
                                                                context,
                                                                listen: false)
                                                        .addkidAge == */
                                                _addKidsAge == null
                                                    ? 'Select Your Age...'
                                                    : /* Provider.of<DataProvider>(
                                                            context,
                                                            listen: false)
                                                        .addkidAge */
                                                    _addKidsAge.toString() +
                                                        ' years old',
                                            hintStyle: TextStyle(
                                                color: Color.fromRGBO(
                                                    132, 134, 148, 1.0)),
                                            contentPadding:
                                                EdgeInsets.only(left: 15),
                                            filled: true,
                                            fillColor: Color.fromRGBO(
                                                238, 239, 243, 1.0),
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
                                                  Radius.circular(
                                                      textfieldRoundEdge)),
                                              borderSide: const BorderSide(
                                                  color: Colors
                                                      .transparent /* Color.fromRGBO(
                                                        170, 170, 170, 0.14) */
                                                  ,
                                                  width: 0.0),
                                            ),
                                            disabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      textfieldRoundEdge)),
                                              borderSide: const BorderSide(
                                                  color: Colors
                                                      .transparent /* Color.fromRGBO(
                                                        170, 170, 170, 0.14) */
                                                  ,
                                                  width: 0.0),
                                            ),
                                            border: new OutlineInputBorder(
                                                //InputBorder.none,
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        textfieldRoundEdge),
                                                borderSide: new BorderSide(
                                                    color: Colors.teal)),
                                          ),
                                          //textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize:
                                                deviceHeight > 500 ? 13 : 11,
                                            fontFamily: 'NunitoRegular',
                                            //fontSize: deviceHeight > 500 ? 20 : 16,
                                            color: Color.fromRGBO(
                                                132, 134, 148, 1.00),
                                          ),
                                        )),
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
                                    color: Color.fromRGBO(244, 244, 248, 1.0),
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
                                          ? (deviceHeight * 0.5) * (26 / 381)
                                          : (deviceHeight * 0.85) * (26 / 381),
                                      child: FittedBox(
                                        fit: BoxFit.fitHeight,
                                        child: Text(
                                          'Cancel',
                                          style: TextStyle(
                                            fontFamily: 'NunitoBold',
                                            //fontSize: deviceHeight > 500 ? 20 : 16,
                                            color: Color.fromRGBO(
                                                160, 163, 168, 1.00),
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
                                        borderRadius: BorderRadius.circular(30),
                                        color:
                                            Color.fromRGBO(244, 244, 248, 1.0),
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
                                      onTap: () async {
                                        print('test');
                                        final FirebaseUser currentUser =
                                            await FirebaseAuth.instance
                                                .currentUser();
                                        Firestore.instance
                                            .collection('WiseKidsUser')
                                            .document(currentUser.uid)
                                            ////////////////////////////////// set data
                                            /* .setData({
                                          "Test": ['555','55555','123'],
                                          
                                          //'kids1Star':
                                        },merge: true);
                                      } */
                                      ///////////////////////////////////// add data 
                                          /*   .updateData({
                                          "Test":
                                              FieldValue.arrayUnion(['Added'])
                                        }); */

                                        /////////////////////////////////// remove data
                                        .updateData({
                                          "Test":
                                              FieldValue.arrayRemove(['Added'])
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color:
                                              Color.fromRGBO(69, 223, 224, 1.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color.fromRGBO(
                                                  69, 223, 224, 0.40),
                                              blurRadius:
                                                  10.0, // has the effect of softening the shadow
                                              spreadRadius:
                                                  -1, // has the effect of extending the shadow
                                              offset: Offset(
                                                0.0, // horizontal, move right 10
                                                3.0, // vertical, move down 10
                                              ),
                                            ),
                                          ],
                                        ),
                                        height: deviceHeight > 500
                                            ? (deviceHeight * 0.5) * (54 / 381)
                                            : (deviceHeight * 0.85) *
                                                (54 / 381),
                                        child: AspectRatio(
                                          aspectRatio: 167 / 54,
                                        ),
                                      ),
                                    ),
                              ////////////////////////////// Text Create
                              Positioned.fill(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    height: deviceHeight > 500
                                        ? (deviceHeight * 0.5) * (26 / 381)
                                        : (deviceHeight * 0.85) * (26 / 381),
                                    child: FittedBox(
                                      fit: BoxFit.fitHeight,
                                      child: Text(
                                        'Create Profile',
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
          ),
        ),
      ),
    );
  }
}
