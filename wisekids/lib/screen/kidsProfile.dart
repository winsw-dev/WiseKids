import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../widget/addKidsProfile_dialog.dart' as editProfile;
import '../widget/slide_popup_dialog_deleteProflie.dart' as deleteProfile;

import '../widget/slide_dialog_kidsStatistic.dart' as kidsStatistic;
import 'parentalKidsCenter.dart';
import '../provider/dataProvider.dart';

class KidsProfile extends StatefulWidget {
  final int kids;
  KidsProfile({Key key, @required this.kids}) : super(key: key);
  @override
  _KidsProfileState createState() => _KidsProfileState();
}

class _KidsProfileState extends State<KidsProfile> {
  /* void _showKidsStatisticDialog() {
    kidsStatistic.showSlideDialog(
      context: context,
      child: Container(
          //color: Colors.white,
          ),
    );
  } */

  @override
  void initState() {
    //////////////////////// Send Build Context of this page to use in provider
    Provider.of<DataProvider>(context, listen: false)
        .getKidsProfileBuildContext(context);
    //////////////////////// initialize list of book History widgets before it get build by BuildContext
    Provider.of<DataProvider>(context, listen: false)
        .kidsProfileReadBookWidgetBuilder(widget.kids);
    super.initState();
  }

  void _showEditProfileDialog() {
    Provider.of<DataProvider>(context, listen: false)
        .initEditKidsProfileCacheVar(widget.kids);
    editProfile.showSlideDialog(
        popUpMode: 'editProflie', editWhichKid: widget.kids, context: context);
  }

  void _showDeleteProfileDialog() {
    deleteProfile.showSlideDialog(
        child: Container(), deleteWhichKid: widget.kids, context: context);
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.00),
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            ///////////////////////////////// gradient Bg
            Container(
              width: deviceWidth,
              height: deviceHeight,
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
                  height: double.infinity,
                  width: double.infinity,
                  margin: EdgeInsets.all(
                      deviceHeight > 500 ? deviceHeight * 0.04 : 0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        deviceHeight > 500 ? BorderRadius.circular(10) : null,
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          //////////////////////////////// Back to parent area Btn
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ParentalKidsCenter(),
                                ),
                              );
                            },
                            child: Container(
                              height: deviceHeight > 500
                                  ? deviceHeight * 0.93 * 0.04
                                  : 30,
                              margin: EdgeInsets.all(deviceHeight > 500
                                  ? deviceWidth * 0.015
                                  : deviceWidth * 0.025),
                              child: AspectRatio(
                                aspectRatio: 136.88 / 28.42,
                                child: SvgPicture.asset(
                                  'assets/images/kidsProfile/backToParentArea.svg',
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      //////////////////////////////////////////////////////////////// Kids Profile
                      Container(
                        //////////////////// height of all content white card container
                        height: deviceHeight > 500
                            ? deviceHeight -
                                (deviceHeight * 0.08) -
                                ((deviceHeight * 0.93 * 0.04) +
                                    (deviceWidth * 0.015 * 2))
                            : deviceHeight - ((deviceWidth * 0.025 * 2) + 30),
                        /* width: deviceHeight > 500
                            ? deviceWidth * (820 / 1024)
                            : deviceWidth * (880 / 1024), */
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Spacer(),
                            //////////////////////////////////// Kids Profile
                            Column(
                              children: <Widget>[
                                Container(
                                  //////////// size of profile frame
                                  height: deviceHeight > 500
                                      ? deviceHeight * (130 / 768)
                                      : deviceHeight * 0.4,
                                  /* margin: EdgeInsets.only(
                                      top: deviceHeight > 500
                                          ? (deviceHeight / 2) -
                                              (deviceHeight * 0.04) -
                                              ((deviceHeight * 0.93 * 0.04) +
                                                  (deviceWidth * 0.015 * 2)) -
                                              (deviceHeight * (130 / 768) / 2) -
                                              7
                                          : deviceHeight * 0.05), */
                                  child:
                                      /* Hero(
                                    tag: widget.kids.toString() + 'Profile',
                                    child: */
                                      Material(
                                    color: Colors.transparent,
                                    child: AspectRatio(
                                      aspectRatio: 100 / 130,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            /* boxShadow: [
                                                BoxShadow(
                                                  color: Color.fromRGBO(
                                                      69, 223, 224, 1.00),
                                                  blurRadius:
                                                      10.0, // has the effect of softening the shadow
                                                  spreadRadius:
                                                      -1, // has the effect of extending the shadow
                                                  offset: Offset(
                                                    0.0, // horizontal, move right 10
                                                    2.0, // vertical, move down 10
                                                  ),
                                                ),
                                              ], */
                                            color: Colors
                                                .white /* Color.fromRGBO(
                                                  69, 223, 224, 1.00) */
                                            ,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(1000),
                                                border: Border.all(
                                                    width: deviceHeight > 500
                                                        ? 1
                                                        : 1,
                                                    color: Color.fromRGBO(
                                                        219,
                                                        212,
                                                        227,
                                                        1.0) //                   <--- border width here
                                                    ),
                                              ),
                                              /* margin: EdgeInsets.only(
                                                    right: 15, left: 15), */
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(1000),
                                                child: Image.asset(
                                                    'assets/images/avatar_' +
                                                        Provider.of<DataProvider>(
                                                                context,
                                                                listen: false)
                                                            .avatar[widget.kids] +
                                                        '.png'),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 10, right: 10),
                                              height: deviceHeight > 500
                                                  ? deviceHeight *
                                                      (130 / 768) *
                                                      (24 / 130)
                                                  : deviceHeight *
                                                      0.4 *
                                                      (24 / 130),
                                              child: FittedBox(
                                                fit: BoxFit.fitWidth,
                                                child: Consumer<DataProvider>(
                                                  builder: (context, provider,
                                                          child) =>
                                                      Text(
                                                    provider.displayName[
                                                                widget.kids][0]
                                                            .toUpperCase() +
                                                        provider.displayName[
                                                                widget.kids]
                                                            .substring(1),
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'NunitoBold',
                                                        //fontSize: 21,
                                                        color: Color.fromRGBO(
                                                            80, 85, 89, 1.0)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  /* ), */
                                ),
                                ///////////////////////////////////////// Time read today
                                Container(
                                    height: deviceHeight > 500
                                        ? deviceHeight *
                                            (130 / 768) *
                                            (24 / 130)
                                        : deviceHeight * 0.4 * (24 / 130),
                                    //margin: EdgeInsets.only(top: 14),
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                          Provider.of<DataProvider>(context,
                                                      listen: false)
                                                  .kidsReadingTime[
                                                      Provider.of<DataProvider>(
                                                              context,
                                                              listen: false)
                                                          .currentKids]
                                                  .toString() +
                                              ' mins today',
                                          style: TextStyle(
                                              fontFamily: 'NunitoSemiBold',
                                              //fontSize: 21,
                                              color: Color.fromRGBO(
                                                  69, 222, 223, 1.0))),
                                    )),

                                /////////////////////////////////////// Edit Profile
                                GestureDetector(
                                  onTap: _showEditProfileDialog,
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      top: deviceHeight > 500
                                          ? deviceHeight *
                                              (130 / 768) *
                                              (15 / 130)
                                          : deviceHeight * 0.35 * (15 / 130),
                                    ),
                                    height: deviceHeight > 500
                                        ? deviceHeight *
                                            (130 / 768) *
                                            (30 / 130)
                                        : deviceHeight * 0.35 * (30 / 130),
                                    child: AspectRatio(
                                      aspectRatio: 154 / 30,
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            child: Image.asset(
                                              'assets/images/kidsProfile/editProfile.png',
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                /////////////////////////////////////// Delete Profile
                                Provider.of<DataProvider>(context,
                                                listen: false)
                                            .avatar
                                            .length >
                                        1
                                    ? GestureDetector(
                                        onTap: () {
                                          _showDeleteProfileDialog();
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(
                                            top: deviceHeight > 500
                                                ? deviceHeight *
                                                    (130 / 768) *
                                                    (15 / 130)
                                                : deviceHeight *
                                                    0.35 *
                                                    (15 / 130),
                                          ),
                                          height: deviceHeight > 500
                                              ? deviceHeight *
                                                  (130 / 768) *
                                                  (30 / 130)
                                              : deviceHeight *
                                                  0.35 *
                                                  (30 / 130),
                                          child: Image.asset(
                                            'assets/images/kidsProfile/deleteProfile.png',
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                            Spacer(),
                            VerticalDivider(
                              thickness: 1,
                            ),
                            Spacer(),
                            ////////////////////////////////////////////// Book History
                            Consumer<DataProvider>(
                              builder: (context, provider, child) =>
                                  ///////////////////// No reading History
                                  provider
                                              .bookStatistic[widget.kids]
                                                  ['readBook']
                                              .length ==
                                          0
                                      ? Container(
                                          height: deviceHeight > 500
                                              ? deviceHeight * (238 / 768)
                                              : deviceHeight * (290 / 459),
                                          margin: EdgeInsets.only(
                                              top: deviceHeight > 500
                                                  ? (deviceHeight / 2) -
                                                      (deviceHeight * 0.04) -
                                                      ((deviceHeight *
                                                              0.93 *
                                                              0.04) +
                                                          (deviceWidth *
                                                              0.015 *
                                                              2)) -
                                                      (deviceHeight *
                                                          (238 / 768) /
                                                          2)
                                                  : deviceHeight * 0.03),
                                          child: Image.asset(
                                              'assets/images/kidsProfile/noHistory.png'),
                                        )
                                      :
                                      ////////////////////// have reading history
                                      Container(
                                          margin: EdgeInsets.only(
                                              top: deviceHeight > 500
                                                  ? 0
                                                  : deviceHeight * 0.05),
                                          height: double.infinity,
                                          width: deviceHeight > 500
                                              ? deviceWidth * (645 / 1024)
                                              : deviceWidth * (630 / 1024),
                                          /* color: Colors.blue, */
                                          child: Wrap(
                                            children: Provider.of<DataProvider>(
                                                    context,
                                                    listen: false)
                                                .kidsProfileReadBookWidget,
                                          ),
                                        ),
                            ),
                            Consumer<DataProvider>(
                              builder: (context, provider, child) => provider
                                          .bookStatistic[widget.kids]
                                              ['readBook']
                                          .length ==
                                      0
                                  ? Spacer()
                                  : Container(),
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            /////////////////////// OLD
            /* /////////////////////////////// White Card
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
            /////////////////////////////// back to Parent Area
            GestureDetector(
              onTap: (){
                Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ParentalKidsCenter(),
                      ),
                    );
              },
                        child: Container(
                margin: EdgeInsets.only(top:70,left: 75),
                child: SvgPicture.asset(
                    'assets/images/kidsProfile/backToParentArea.svg'),
              ),
            ),

            /////////////////////////////// listview
            GestureDetector(
              onTap: _showKidsStatisticDialog,
                        child: Container(
                margin: EdgeInsets.only(left: 88, top: 180),
                child: Stack(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 12, top: 330),
                      child: Text(
                        '0 minutes today',
                        style: TextStyle(
                          fontFamily: 'NunitoRegular',
                          fontSize: deviceHeight > 500 ? 17 : 16,
                        ),
                      ),
                    ),
                    Row(
                      
                      children: <Widget>[
                        Container(
                          color: Colors.blueGrey,
                          margin: EdgeInsets.only(right: 20),
                          /* child: Image.asset(
                              'assets/images/parentalKidsCenter/Todd.png'), */
                          width: 145,
                          height: 160,
                        ),
                        Container(
                          height: 500,
                          width: 750,
                          child: ListView(
                            children: <Widget>[
                              Wrap(
                                children: <Widget>[
                                  ////////////////// book 1
                                  Container(
                                    margin: EdgeInsets.only(left: 20, bottom: 20),
                                    height: 203,
                                    decoration: new BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color.fromRGBO(69, 223, 224, 0.5),
                                          blurRadius:
                                              10.0, // has the effect of softening the shadow
                                          spreadRadius:
                                              1, // has the effect of extending the shadow
                                          offset: Offset(
                                            0.0, // horizontal, move right 10
                                            2.0, // vertical, move down 10
                                          ),
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child:
                                            Image.asset('assets/images/Book7.png')),
                                  ),
                                  ////////////////// book 2
                                  Container(
                                    margin: EdgeInsets.only(left: 20, bottom: 20),
                                    height: 203,
                                    decoration: new BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color.fromRGBO(69, 223, 224, 0.5),
                                          blurRadius:
                                              10.0, // has the effect of softening the shadow
                                          spreadRadius:
                                              -1, // has the effect of extending the shadow
                                          offset: Offset(
                                            0.0, // horizontal, move right 10
                                            2.0, // vertical, move down 10
                                          ),
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child:
                                            Image.asset('assets/images/Book2.png')),
                                  ),
                                  ////////////////// book 3
                                  Container(
                                    margin: EdgeInsets.only(left: 20, bottom: 20),
                                    height: 203,
                                    decoration: new BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color.fromRGBO(69, 223, 224, 0.5),
                                          blurRadius:
                                              10.0, // has the effect of softening the shadow
                                          spreadRadius:
                                              -1, // has the effect of extending the shadow
                                          offset: Offset(
                                            0.0, // horizontal, move right 10
                                            2.0, // vertical, move down 10
                                          ),
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child:
                                            Image.asset('assets/images/Book3.png')),
                                  ),
                                  ////////////////// book 4
                                  Container(
                                    margin: EdgeInsets.only(left: 20, bottom: 20),
                                    height: 203,
                                    decoration: new BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color.fromRGBO(69, 223, 224, 0.5),
                                          blurRadius:
                                              10.0, // has the effect of softening the shadow
                                          spreadRadius:
                                              -1, // has the effect of extending the shadow
                                          offset: Offset(
                                            0.0, // horizontal, move right 10
                                            2.0, // vertical, move down 10
                                          ),
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child:
                                            Image.asset('assets/images/Book4.png')),
                                  ),
                                  ////////////////// book 5
                                  Container(
                                    margin: EdgeInsets.only(left: 20, bottom: 20),
                                    height: 203,
                                    decoration: new BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color.fromRGBO(69, 223, 224, 0.5),
                                          blurRadius:
                                              10.0, // has the effect of softening the shadow
                                          spreadRadius:
                                              -1, // has the effect of extending the shadow
                                          offset: Offset(
                                            0.0, // horizontal, move right 10
                                            2.0, // vertical, move down 10
                                          ),
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child:
                                            Image.asset('assets/images/Book8.png')),
                                  ),
                                  ////////////////// book 6
                                  Container(
                                    margin: EdgeInsets.only(left: 20, bottom: 20),
                                    height: 203,
                                    decoration: new BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color.fromRGBO(69, 223, 224, 0.5),
                                          blurRadius:
                                              10.0, // has the effect of softening the shadow
                                          spreadRadius:
                                              -1, // has the effect of extending the shadow
                                          offset: Offset(
                                            0.0, // horizontal, move right 10
                                            2.0, // vertical, move down 10
                                          ),
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child:
                                            Image.asset('assets/images/Book6.png')),
                                  ),
                                  ////////////////////////
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ) */
          ],
        ),
      ),
    );
  }
}
