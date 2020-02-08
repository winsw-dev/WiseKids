<<<<<<< HEAD
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:slide_popup_dialog/slide_popup_dialog.dart' as slideDialog;
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:wisekids_app/main.dart';
import 'package:wisekids_app/colorThemeWidget.dart';
import 'package:slide_popup_dialog/vocabuaryPopup.dart' as vocabuaryPopup;
import 'with_arkit_screen.dart';

class Home extends StatefulWidget {
  //recieve data from select avatar page
  final String avatar;
  Home(this.avatar);

  @override
  _HomeState createState() => _HomeState();
}

class SelectedVisibility {
  static var aquaLime = true;
  static var aquaViolet = false;
  static var violetMagenta = false;
  static var yellowSalmon = false;
  static var pinkYellow = false;
  static var blueCat = false;
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    checkAvatar();
    super.initState();
  }

  String _value;

/////////////////////////////////////////////////////////////////////////////// var setup
  var themeColor1 = [MyColor.aqua, MyColor.limeGreen];
  var themeColor1Offset = [0.1, 1.0];

  var themeColor2 = [MyColor.aqua, MyColor.violet];
  var themeColor2Offset = [0.1, 1.0];

  var themeColor3 = [MyColor.magenta, MyColor.violet];
  var themeColor3Offset = [0.1, 1.0];

  var themeColor4 = [MyColor.yellow, MyColor.salmon];
  var themeColor4Offset = [0.1, 1.0];

  var themeColor5 = [
    MyColor.pinkBg,
    MyColor.pinkBg,
    MyColor.yellowBg,
    MyColor.yellowBg
  ];
  var themeColor5Offset = [0.1, 0.5, 0.51, 1.0];

  var themeColor6 = [
    MyColor.babyBlueBG,
    MyColor.babyBlueBG,
    MyColor.babyBlueBg2,
    MyColor.babyBlueBg2
  ];

  int avtarIndex;
  ////////////////////////////////////////////////////////////////////// theme setup

  var selectedTheme = 'aquaLimegreen';
  var bgGradient = [MyColor.aqua, MyColor.limeGreen];
  var shadowColor = Color.fromRGBO(69, 223, 224, 0.5);
  var popupShadowColor = Color.fromRGBO(69, 223, 224, 0.25);
  var themeColor = MyColor.aqua;

  var themeColor6Offset = [0.1, 0.5, 0.51, 1.0];
  var avatarSwipeController = new SwiperController();

  void _themefunction() {
    setState(() {
      if (selectedTheme == '0') {
        SelectedVisibility.aquaLime = true;
        SelectedVisibility.aquaViolet = false;
        SelectedVisibility.violetMagenta = false;
        SelectedVisibility.yellowSalmon = false;
        SelectedVisibility.pinkYellow = false;
        SelectedVisibility.blueCat = false;
        bgGradient = [MyColor.aqua, MyColor.limeGreen];
        shadowColor = Color.fromRGBO(69, 223, 224, 0.5);
        popupShadowColor = Color.fromRGBO(69, 223, 224, 0.25);
        themeColor = MyColor.aqua;
      } else if (selectedTheme == '1') {
        SelectedVisibility.aquaLime = false;
        SelectedVisibility.aquaViolet = true;
        SelectedVisibility.violetMagenta = false;
        SelectedVisibility.yellowSalmon = false;
        SelectedVisibility.pinkYellow = false;
        SelectedVisibility.blueCat = false;
        bgGradient = [MyColor.aqua, MyColor.violet];
        shadowColor = Color.fromRGBO(69, 223, 224, 0.5);
        popupShadowColor = Color.fromRGBO(69, 223, 224, 0.25);
        themeColor = MyColor.aqua;
      } else if (selectedTheme == '2') {
        SelectedVisibility.aquaLime = false;
        SelectedVisibility.aquaViolet = false;
        SelectedVisibility.violetMagenta = true;
        SelectedVisibility.yellowSalmon = false;
        SelectedVisibility.pinkYellow = false;
        SelectedVisibility.blueCat = false;
        bgGradient = [MyColor.magenta, MyColor.violet];
        shadowColor = Color.fromRGBO(69, 223, 224, 0.5);
        popupShadowColor = Color.fromRGBO(69, 223, 224, 0.25);
        themeColor = MyColor.magenta;
      } else if (selectedTheme == '3') {
        SelectedVisibility.aquaLime = false;
        SelectedVisibility.aquaViolet = false;
        SelectedVisibility.violetMagenta = false;
        SelectedVisibility.yellowSalmon = true;
        SelectedVisibility.pinkYellow = false;
        SelectedVisibility.blueCat = false;
        bgGradient = [MyColor.yellow, MyColor.salmon];
        shadowColor = Color.fromRGBO(69, 223, 224, 0.5);
        popupShadowColor = Color.fromRGBO(69, 223, 224, 0.25);
        themeColor = MyColor.magenta;
      } else if (selectedTheme == '4') {
        SelectedVisibility.aquaLime = false;
        SelectedVisibility.aquaViolet = false;
        SelectedVisibility.violetMagenta = false;
        SelectedVisibility.yellowSalmon = false;
        SelectedVisibility.pinkYellow = true;
        SelectedVisibility.blueCat = false;
        bgGradient = [MyColor.yellow, MyColor.salmon];
        shadowColor = Color.fromRGBO(69, 223, 224, 0.5);
        popupShadowColor = Color.fromRGBO(69, 223, 224, 0.25);
        themeColor = MyColor.magenta;
      } else if (selectedTheme == '5') {
        SelectedVisibility.aquaLime = false;
        SelectedVisibility.aquaViolet = false;
        SelectedVisibility.violetMagenta = false;
        SelectedVisibility.yellowSalmon = false;
        SelectedVisibility.pinkYellow = false;
        SelectedVisibility.blueCat = true;
        bgGradient = [MyColor.yellow, MyColor.salmon];
        shadowColor = Color.fromRGBO(69, 223, 224, 0.5);
        popupShadowColor = Color.fromRGBO(69, 223, 224, 0.25);
        themeColor = MyColor.magenta;
      }
    });
  }

  /////////////////////////////////////////////////////////////////////////
  var bookShelf = [
    "assets/images/Book1.png",
    "assets/images/Book2.png",
    "assets/images/Book3.png",
    "assets/images/Book4.png",
    "assets/images/Book5.png",
    "assets/images/Book6.png",
    "assets/images/Book7.png",
    "assets/images/Book8.png",
  ];

  var avatar = [
    "assets/images/avatar_boy.png",
    "assets/images/avatar_girl.png",
    "assets/images/avatar_cat.png"
  ];

  List<Color> popupSelectThemeGradient = [
    Color.fromRGBO(
      69,
      223,
      224,
      1.00,
    ),
    Color.fromRGBO(
      105,
      214,
      142,
      1.00,
    ),
    Color.fromRGBO(135, 207, 74, 1.00),
  ];
  List<double> popupSelectThemeStop = [0.1, 0.32, 1.0];
  List<Color> popupLoginGradient = [
    Color.fromRGBO(
      69,
      223,
      224,
      1.00,
    ),
    Color.fromRGBO(
      105,
      214,
      100,
      1.00,
    ),
  ];
  List<double> popupLoginStop = [0.1, 1.0];

  ///////////////////////////////////////////////////////////////////////////////// function

  void _showCategoryDialog() {
    vocabuaryPopup.showVocabuaryDialog(
      context: context,
      child: Material(
        color: Colors.transparent,
        child: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(12),
              width: 811,
              height: 353,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.1, 1.0],
                  colors: popupLoginGradient,
                ),
              ),
              child: Image.asset(
                'assets/icon/bgPattern.png',
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    return;
                  },
                  child: Container(
                    width: 29,
                    height: 29,
                    margin: EdgeInsets.only(right: 24, top: 24),
                    child: SvgPicture.asset(
                      'assets/icon/iconClose.svg',
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                width: 672,
                height: 258,
                child: Wrap(
                  spacing: 18,
                  runSpacing: 18,
                  children: <Widget>[
                    ///////////////////////////////////////////////////// bookshelf
                    CatagoryBtn(
                      iconHeight: 60,
                      iconWidth: 78,
                      iconImage: 'assets/icon/bookshelf.svg',
                      title: 'All',
                      iconMarginTop: 20,
                    ),
                    CatagoryBtn(
                      iconHeight: 85,
                      iconWidth: 95,
                      iconImage: 'assets/icon/readAgain.svg',
                      title: 'Read agian',
                      iconMarginTop: 3,
                    ),
                    CatagoryBtn(
                      iconHeight: 60,
                      iconWidth: 59,
                      iconImage: 'assets/icon/favourite.svg',
                      title: 'Favourite',
                      iconMarginTop: 21,
                    ),
                    CatagoryBtn(
                      iconHeight: 59,
                      iconWidth: 72,
                      iconImage: 'assets/icon/new.svg',
                      title: 'New',
                      iconMarginTop: 21,
                    ),
                    CatagoryBtn(
                      iconHeight: 59,
                      iconWidth: 64,
                      iconImage: 'assets/icon/treasure-map.svg',
                      title: 'Adventure',
                      iconMarginTop: 23,
                    ),
                    CatagoryBtn(
                      iconHeight: 78,
                      iconWidth: 68,
                      iconImage: 'assets/icon/learning.svg',
                      title: 'Learning',
                      iconMarginTop: 5,
                    ),
                    CatagoryBtn(
                      iconHeight: 57,
                      iconWidth: 61,
                      iconImage: 'assets/icon/animal.svg',
                      title: 'Animal',
                      iconMarginTop: 21,
                    ),
                    CatagoryBtn(
                      iconHeight: 70,
                      iconWidth: 92,
                      iconImage: 'assets/icon/holiday.svg',
                      title: 'Holiday',
                      iconMarginTop: 18,
                    ),
                    CatagoryBtn(
                      iconHeight: 65,
                      iconWidth: 63,
                      iconImage: 'assets/icon/sport.svg',
                      title: 'Sport',
                      iconMarginTop: 16,
                    ),
                    CatagoryBtn(
                      iconHeight: 68,
                      iconWidth: 45,
                      iconImage: 'assets/icon/science.svg',
                      title: 'Science',
                      iconMarginTop: 15,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showVocabuaryDialog() {
    vocabuaryPopup.showVocabuaryDialog(
      context: context,
      child: Material(
        color: Colors.transparent,
        child: Stack(
          children: <Widget>[
            Container(
              width: 835,
              height: 355,
              child: SvgPicture.asset(
                'assets/icon/vocabuaryPopup.svg',
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    return;
                  },
                  child: Container(
                    width: 29,
                    height: 29,
                    margin: EdgeInsets.only(right: 14, top: 6),
                    child: SvgPicture.asset(
                      'assets/icon/iconClose.svg',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLoginDialog() {
    slideDialog.showSlideDialog(
      propVisibility: true,
      bgGradient: popupLoginGradient,
      gradientStop: popupLoginStop,
      containerColor: Colors.transparent,
      context: context,
      child: Material(
        color: Colors.transparent,
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 86,
                  margin: EdgeInsets.only(top: 27),
                  child: SvgPicture.asset(
                    'assets/icon/wiseKidsLogoLogin.svg',
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.only(top: 120),
                  child: Text(
                    'Sign in to set up multiple profiles.',
                    style: TextStyle(
                      fontFamily: 'NunitoRegular',
                      fontSize: 9,
                      color: Color.fromRGBO(255, 255, 255, 1.00),
                    ),
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    return;
                  },
                  child: Container(
                    width: 20,
                    height: 20,
                    margin: EdgeInsets.only(right: 17, top: 17),
                    child: SvgPicture.asset(
                      'assets/icon/iconClose.svg',
                    ),
                  ),
                ),
              ),
            ),
            //////////////////////////////////////////////////////////////////// facebook btn
            Positioned.fill(
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.only(top: 159),
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.25),
                        blurRadius:
                            15.0, // has the effect of softening the shadow
                        spreadRadius:
                            -5, // has the effect of extending the shadow
                        offset: Offset(
                          0.0, // horizontal, move right 10
                          10.0, // vertical, move down 10
                        ),
                      ),
                    ],
                    color: Colors.white,
                  ),
                  height: 44,
                  width: 300,
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Facebook',
                            style: TextStyle(
                              fontFamily: 'NunitoRegular',
                              fontSize: 11,
                              color: Color.fromRGBO(80, 85, 89, 1.00),
                            ),
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(left: 22),
                            child: SvgPicture.asset(
                              'assets/icon/Facebook.svg',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ////////////////////////////////////////////////////////////////// google btn
            Positioned.fill(
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.only(top: 220),
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.25),
                        blurRadius:
                            15.0, // has the effect of softening the shadow
                        spreadRadius:
                            -5, // has the effect of extending the shadow
                        offset: Offset(
                          0.0, // horizontal, move right 10
                          10.0, // vertical, move down 10
                        ),
                      ),
                    ],
                    color: Colors.white,
                  ),
                  height: 44,
                  width: 300,
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Google',
                            style: TextStyle(
                              fontFamily: 'NunitoRegular',
                              fontSize: 11,
                              color: Color.fromRGBO(80, 85, 89, 1.00),
                            ),
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(left: 22),
                            child: SvgPicture.asset(
                              'assets/icon/Google.svg',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ////////////////////////////////// use as guest
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(bottom: 18),
                  child: Text(
                    'Use as Guest',
                    style: TextStyle(
                      fontFamily: 'NunitoRegular',
                      fontSize: 10,
                      color: Color.fromRGBO(255, 255, 255, 1.00),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showThemeDialog() {
    slideDialog.showSlideDialog(
      propVisibility: false,
      bgGradient: popupSelectThemeGradient,
      gradientStop: popupSelectThemeStop,
      containerColor: Colors.white,
      context: context,
      child: Stack(
        children: <Widget>[
          Container(
            child: SvgPicture.asset(
              'assets/images/whiteCloudBG.svg',
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  return;
                },
                child: Container(
                  width: 20,
                  height: 20,
                  margin: EdgeInsets.only(right: 17, top: 17),
                  child: SvgPicture.asset(
                    'assets/icon/iconClose.svg',
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 126,
            margin: EdgeInsets.only(top: 40),
            child: new Swiper(
              index: 1,
              loop: false,
              controller: avatarSwipeController,
              onTap: (int index) {
                if (index == 0) {
                  avatarSwipeController.move(0, animation: true);
                } else if (index == 1) {
                  avatarSwipeController.move(1, animation: true);
                } else if (index == 2) {
                  avatarSwipeController.move(2, animation: true);
                }
              },
              onIndexChanged: (int index) {
                print(index);
                setState(() {
                  avtarIndex = index;
                });
              },
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      BoxShadow(
                        color: popupShadowColor,
                        blurRadius:
                            15.0, // has the effect of softening the shadow
                        spreadRadius:
                            -5, // has the effect of extending the shadow
                        offset: Offset(
                          0.0, // horizontal, move right 10
                          10.0, // vertical, move down 10
                        ),
                      )
                    ],
                  ),
                  margin: EdgeInsets.only(left: 8, right: 8, bottom: 20),
                  child: new ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      avatar[index],
                      fit: BoxFit.fill,
                    ),
                  ),
                );
              },
              itemCount: 3,
              viewportFraction: 0.31,
              scale: 0.2,
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Container(
                height: 50,
                width: 300,
                margin: EdgeInsets.only(top: 45),
                child: SvgPicture.asset(
                  'assets/icon/selectYourTheme.svg',
                  color: themeColor,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                //margin: EdgeInsets.only(bottom: 0),
                width: 325,
                child: Wrap(
                  alignment: WrapAlignment.start,
                  runSpacing: 15,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedTheme = '0';
                        });

                        _themefunction();
                      },
                      child: ColorThemeWidget(
                        gradientColor: themeColor1,
                        gradientOffset: themeColor1Offset,
                        checkedVisibility: SelectedVisibility.aquaLime,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedTheme = '1';
                        });

                        _themefunction();
                      },
                      child: ColorThemeWidget(
                          gradientColor: themeColor2,
                          gradientOffset: themeColor2Offset,
                          checkedVisibility: SelectedVisibility.aquaViolet),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedTheme = '2';
                        });

                        _themefunction();
                      },
                      child: ColorThemeWidget(
                        gradientColor: themeColor3,
                        gradientOffset: themeColor3Offset,
                        checkedVisibility: SelectedVisibility.violetMagenta,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedTheme = '3';
                        });

                        _themefunction();
                      },
                      child: ColorThemeWidget(
                        gradientColor: themeColor4,
                        gradientOffset: themeColor4Offset,
                        checkedVisibility: SelectedVisibility.yellowSalmon,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedTheme = '4';
                        });

                        _themefunction();
                      },
                      child: ColorThemeWidget(
                        gradientColor: themeColor5,
                        gradientOffset: themeColor5Offset,
                        checkedVisibility: SelectedVisibility.pinkYellow,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedTheme = '5';
                        });

                        _themefunction();
                      },
                      child: ColorThemeWidget(
                        gradientColor: themeColor6,
                        gradientOffset: themeColor6Offset,
                        checkedVisibility: SelectedVisibility.blueCat,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  checkAvatar() {
    setState(() {
      if (widget.avatar == 'Boy') {
        avtarIndex = 0;
      } else if (widget.avatar == 'Girl') {
        avtarIndex = 1;
      } else if (widget.avatar == 'Cat') {
        avtarIndex = 2;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  ////////////////////////////////////////////////////////////////  BG
                  Center(
                    child: Container(
                      child: SvgPicture.asset(
                        'assets/images/bgPattern.svg',
                      ),
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        // Box decoration takes a gradient
                        gradient: LinearGradient(
                          // Where the linear gradient begins and ends
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          // Add one stop for each color. Stops should increase from 0 to 1
                          stops: [0.1, 0.42],
                          colors: bgGradient,
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        color: Colors.white,
                        height: MediaQuery.of(context).size.height / 2,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        child: SvgPicture.asset(
                          'assets/images/whiteCloudBG.svg',
                        ),
                      ),
                    ),
                  ),
                  /////////////////////////////////////////////////////////////////////////////// end of BG
                  ///
                  ///////////////////////////////////////////////////////////////////////////////  Begin of Avatar, Vocab, Category, login dropdown
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _showThemeDialog();
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 15, left: 15),
                      decoration: new BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                            blurRadius:
                                15.0, // has the effect of softening the shadow
                            spreadRadius:
                                -5, // has the effect of extending the shadow
                            offset: Offset(
                              0.0, // horizontal, move right 10
                              10.0, // vertical, move down 10
                            ),
                          )
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Container(
                          child: Image.asset(
                            avatar[avtarIndex],
                          ),
                          height: 97,
                          width: 97,
                        ),
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: _showVocabuaryDialog,
                    child: Container(
                      margin: EdgeInsets.only(top: 18, left: 135),
                      height: 69,
                      child: SvgPicture.asset(
                        'assets/icon/Vocabuary.svg',
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: _showCategoryDialog,
                    child: Container(
                      margin: EdgeInsets.only(top: 18, left: 220),
                      height: 69,
                      child: SvgPicture.asset(
                        'assets/icon/Category.svg',
                      ),
                    ),
                  ),

                  Stack(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                          top: 32,
                          left: MediaQuery.of(context).size.width * 0.8025,
                        ),
                        child: SvgPicture.asset(
                          'assets/icon/Button_Yl.svg',
                        ),
                      ),
                    ],
                  ),

                  IndexedStack(
                    index:
                        0, ////////////////////////////////////////////////////////////////////////// Login Button switch
                    children: <Widget>[
                      GestureDetector(
                        onTap: _showLoginDialog,
                        child: Container(
                          height: 45,
                          width: 148,
                          margin: EdgeInsets.only(
                            top: 32,
                            left: MediaQuery.of(context).size.width * 0.8025,
                          ),
                          child: Stack(
                            children: <Widget>[
                              Container(
                                alignment: Alignment(1.0, 0.0),
                                margin: EdgeInsets.only(right: 20),
                                child: SvgPicture.asset(
                                  'assets/icon/arrowRight.svg',
                                ),
                              ),
                              Container(
                                alignment: Alignment(-1.0, 0.0),
                                margin: EdgeInsets.only(left: 20),
                                child: Text(
                                  'Login        ',
                                  style: TextStyle(
                                      fontFamily: 'NunitoBlack',
                                      fontSize: 15,
                                      color:
                                          Color.fromRGBO(255, 255, 255, 1.00)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 32,
                          left: MediaQuery.of(context).size.width * 0.8025,
                        ),
                        height: 45,
                        width: 148,
                        child: Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              icon: SvgPicture.asset(
                                'assets/icon/arrowDown.svg',
                              ),
                              onChanged: (String value) {
                                setState(() {
                                  _value = value;
                                });
                              },
                              hint: Text(
                                'Login',
                                style: TextStyle(
                                    fontFamily: 'NunitoBlack',
                                    fontSize: 15,
                                    color: Color.fromRGBO(255, 255, 255, 1.00)),
                              ),
                              items: [
                                DropdownMenuItem<String>(
                                  child: Text('Item 1'),
                                  value: 'one',
                                ),
                                DropdownMenuItem<String>(
                                  child: Text('Item 2'),
                                  value: 'two',
                                ),
                                DropdownMenuItem<String>(
                                  child: Text('Item 3'),
                                  value: 'three',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  ///////////////////////////////////////////////////////////////////////////////  Bookshelf
                  Container(
                    margin: EdgeInsets.only(top: 155),
                    height: 230,
                    width: MediaQuery.of(context).size.width,
                    child: new Swiper(
                      onTap: (index) {
                        /*  Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WithARkitScreen(avatar: widget.avatar,),
                          ),
                        ); */
                        /////////////////////
                        /* Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WithARkitScreen(
                                    avatar: widget.avatar,
                                  )),
                        ); */
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: shadowColor,
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
                          margin: EdgeInsets.only(
                              left: 12, right: 12, bottom: 10, top: 10),
                          //padding: EdgeInsets.only(bottom: 20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Container(
                              child: new Image.asset(
                                bookShelf[index],
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: 8,
                      //itemHeight: 206,
                      //itemWidth: 147,

                      viewportFraction: 0.22,
                      scale: 1.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CatagoryBtn extends StatelessWidget {
  final double iconWidth;
  final double iconHeight;
  final String iconImage;
  final String title;
  final double iconMarginTop;

  const CatagoryBtn({
    this.iconMarginTop,
    this.iconHeight,
    this.iconWidth,
    this.iconImage,
    this.title,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      width: 120,
      height: 120,
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.only(top: iconMarginTop),
                width: iconWidth,
                height: iconHeight,
                child: SvgPicture.asset(
                  iconImage,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: 11),
                child: Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'NunitoBlack',
                    fontSize: 12,
                    color: MyColor.aqua,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
=======
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:slide_popup_dialog/slide_popup_dialog.dart' as slideDialog;
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:wisekids_app/main.dart';
import 'package:wisekids_app/colorThemeWidget.dart';
import 'package:slide_popup_dialog/vocabuaryPopup.dart' as vocabuaryPopup;
import 'with_arkit_screen.dart';

class Home extends StatefulWidget {
  //recieve data from select avatar page
  final String avatar;
  Home(this.avatar);

  @override
  _HomeState createState() => _HomeState();
}

class SelectedVisibility {
  static var aquaLime = true;
  static var aquaViolet = false;
  static var violetMagenta = false;
  static var yellowSalmon = false;
  static var pinkYellow = false;
  static var blueCat = false;
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    checkAvatar();
    super.initState();
  }

  String _value;

/////////////////////////////////////////////////////////////////////////////// var setup
  var themeColor1 = [MyColor.aqua, MyColor.limeGreen];
  var themeColor1Offset = [0.1, 1.0];

  var themeColor2 = [MyColor.aqua, MyColor.violet];
  var themeColor2Offset = [0.1, 1.0];

  var themeColor3 = [MyColor.magenta, MyColor.violet];
  var themeColor3Offset = [0.1, 1.0];

  var themeColor4 = [MyColor.yellow, MyColor.salmon];
  var themeColor4Offset = [0.1, 1.0];

  var themeColor5 = [
    MyColor.pinkBg,
    MyColor.pinkBg,
    MyColor.yellowBg,
    MyColor.yellowBg
  ];
  var themeColor5Offset = [0.1, 0.5, 0.51, 1.0];

  var themeColor6 = [
    MyColor.babyBlueBG,
    MyColor.babyBlueBG,
    MyColor.babyBlueBg2,
    MyColor.babyBlueBg2
  ];

  int avtarIndex;
  ////////////////////////////////////////////////////////////////////// theme setup

  var selectedTheme = 'aquaLimegreen';
  var bgGradient = [MyColor.aqua, MyColor.limeGreen];
  var shadowColor = Color.fromRGBO(69, 223, 224, 0.5);
  var popupShadowColor = Color.fromRGBO(69, 223, 224, 0.25);
  var themeColor = MyColor.aqua;

  var themeColor6Offset = [0.1, 0.5, 0.51, 1.0];
  var avatarSwipeController = new SwiperController();

  void _themefunction() {
    setState(() {
      if (selectedTheme == '0') {
        SelectedVisibility.aquaLime = true;
        SelectedVisibility.aquaViolet = false;
        SelectedVisibility.violetMagenta = false;
        SelectedVisibility.yellowSalmon = false;
        SelectedVisibility.pinkYellow = false;
        SelectedVisibility.blueCat = false;
        bgGradient = [MyColor.aqua, MyColor.limeGreen];
        shadowColor = Color.fromRGBO(69, 223, 224, 0.5);
        popupShadowColor = Color.fromRGBO(69, 223, 224, 0.25);
        themeColor = MyColor.aqua;
      } else if (selectedTheme == '1') {
        SelectedVisibility.aquaLime = false;
        SelectedVisibility.aquaViolet = true;
        SelectedVisibility.violetMagenta = false;
        SelectedVisibility.yellowSalmon = false;
        SelectedVisibility.pinkYellow = false;
        SelectedVisibility.blueCat = false;
        bgGradient = [MyColor.aqua, MyColor.violet];
        shadowColor = Color.fromRGBO(69, 223, 224, 0.5);
        popupShadowColor = Color.fromRGBO(69, 223, 224, 0.25);
        themeColor = MyColor.aqua;
      } else if (selectedTheme == '2') {
        SelectedVisibility.aquaLime = false;
        SelectedVisibility.aquaViolet = false;
        SelectedVisibility.violetMagenta = true;
        SelectedVisibility.yellowSalmon = false;
        SelectedVisibility.pinkYellow = false;
        SelectedVisibility.blueCat = false;
        bgGradient = [MyColor.magenta, MyColor.violet];
        shadowColor = Color.fromRGBO(69, 223, 224, 0.5);
        popupShadowColor = Color.fromRGBO(69, 223, 224, 0.25);
        themeColor = MyColor.magenta;
      } else if (selectedTheme == '3') {
        SelectedVisibility.aquaLime = false;
        SelectedVisibility.aquaViolet = false;
        SelectedVisibility.violetMagenta = false;
        SelectedVisibility.yellowSalmon = true;
        SelectedVisibility.pinkYellow = false;
        SelectedVisibility.blueCat = false;
        bgGradient = [MyColor.yellow, MyColor.salmon];
        shadowColor = Color.fromRGBO(69, 223, 224, 0.5);
        popupShadowColor = Color.fromRGBO(69, 223, 224, 0.25);
        themeColor = MyColor.magenta;
      } else if (selectedTheme == '4') {
        SelectedVisibility.aquaLime = false;
        SelectedVisibility.aquaViolet = false;
        SelectedVisibility.violetMagenta = false;
        SelectedVisibility.yellowSalmon = false;
        SelectedVisibility.pinkYellow = true;
        SelectedVisibility.blueCat = false;
        bgGradient = [MyColor.yellow, MyColor.salmon];
        shadowColor = Color.fromRGBO(69, 223, 224, 0.5);
        popupShadowColor = Color.fromRGBO(69, 223, 224, 0.25);
        themeColor = MyColor.magenta;
      } else if (selectedTheme == '5') {
        SelectedVisibility.aquaLime = false;
        SelectedVisibility.aquaViolet = false;
        SelectedVisibility.violetMagenta = false;
        SelectedVisibility.yellowSalmon = false;
        SelectedVisibility.pinkYellow = false;
        SelectedVisibility.blueCat = true;
        bgGradient = [MyColor.yellow, MyColor.salmon];
        shadowColor = Color.fromRGBO(69, 223, 224, 0.5);
        popupShadowColor = Color.fromRGBO(69, 223, 224, 0.25);
        themeColor = MyColor.magenta;
      }
    });
  }

  /////////////////////////////////////////////////////////////////////////
  var bookShelf = [
    "assets/images/Book1.png",
    "assets/images/Book2.png",
    "assets/images/Book3.png",
    "assets/images/Book4.png",
    "assets/images/Book5.png",
    "assets/images/Book6.png",
    "assets/images/Book7.png",
    "assets/images/Book8.png",
  ];

  var avatar = [
    "assets/images/avatar_boy.png",
    "assets/images/avatar_girl.png",
    "assets/images/avatar_cat.png"
  ];

  List<Color> popupSelectThemeGradient = [
    Color.fromRGBO(
      69,
      223,
      224,
      1.00,
    ),
    Color.fromRGBO(
      105,
      214,
      142,
      1.00,
    ),
    Color.fromRGBO(135, 207, 74, 1.00),
  ];
  List<double> popupSelectThemeStop = [0.1, 0.32, 1.0];
  List<Color> popupLoginGradient = [
    Color.fromRGBO(
      69,
      223,
      224,
      1.00,
    ),
    Color.fromRGBO(
      105,
      214,
      100,
      1.00,
    ),
  ];
  List<double> popupLoginStop = [0.1, 1.0];

  ///////////////////////////////////////////////////////////////////////////////// function

  void _showCategoryDialog() {
    vocabuaryPopup.showVocabuaryDialog(
      context: context,
      child: Material(
        color: Colors.transparent,
        child: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(12),
              width: 811,
              height: 353,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.1, 1.0],
                  colors: popupLoginGradient,
                ),
              ),
              child: Image.asset(
                'assets/icon/bgPattern.png',
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    return;
                  },
                  child: Container(
                    width: 29,
                    height: 29,
                    margin: EdgeInsets.only(right: 24, top: 24),
                    child: SvgPicture.asset(
                      'assets/icon/iconClose.svg',
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                width: 672,
                height: 258,
                child: Wrap(
                  spacing: 18,
                  runSpacing: 18,
                  children: <Widget>[
                    ///////////////////////////////////////////////////// bookshelf
                    CatagoryBtn(
                      iconHeight: 60,
                      iconWidth: 78,
                      iconImage: 'assets/icon/bookshelf.svg',
                      title: 'All',
                      iconMarginTop: 20,
                    ),
                    CatagoryBtn(
                      iconHeight: 85,
                      iconWidth: 95,
                      iconImage: 'assets/icon/readAgain.svg',
                      title: 'Read agian',
                      iconMarginTop: 3,
                    ),
                    CatagoryBtn(
                      iconHeight: 60,
                      iconWidth: 59,
                      iconImage: 'assets/icon/favourite.svg',
                      title: 'Favourite',
                      iconMarginTop: 21,
                    ),
                    CatagoryBtn(
                      iconHeight: 59,
                      iconWidth: 72,
                      iconImage: 'assets/icon/new.svg',
                      title: 'New',
                      iconMarginTop: 21,
                    ),
                    CatagoryBtn(
                      iconHeight: 59,
                      iconWidth: 64,
                      iconImage: 'assets/icon/treasure-map.svg',
                      title: 'Adventure',
                      iconMarginTop: 23,
                    ),
                    CatagoryBtn(
                      iconHeight: 78,
                      iconWidth: 68,
                      iconImage: 'assets/icon/learning.svg',
                      title: 'Learning',
                      iconMarginTop: 5,
                    ),
                    CatagoryBtn(
                      iconHeight: 57,
                      iconWidth: 61,
                      iconImage: 'assets/icon/animal.svg',
                      title: 'Animal',
                      iconMarginTop: 21,
                    ),
                    CatagoryBtn(
                      iconHeight: 70,
                      iconWidth: 92,
                      iconImage: 'assets/icon/holiday.svg',
                      title: 'Holiday',
                      iconMarginTop: 18,
                    ),
                    CatagoryBtn(
                      iconHeight: 65,
                      iconWidth: 63,
                      iconImage: 'assets/icon/sport.svg',
                      title: 'Sport',
                      iconMarginTop: 16,
                    ),
                    CatagoryBtn(
                      iconHeight: 68,
                      iconWidth: 45,
                      iconImage: 'assets/icon/science.svg',
                      title: 'Science',
                      iconMarginTop: 15,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showVocabuaryDialog() {
    vocabuaryPopup.showVocabuaryDialog(
      context: context,
      child: Material(
        color: Colors.transparent,
        child: Stack(
          children: <Widget>[
            Container(
              width: 835,
              height: 355,
              child: SvgPicture.asset(
                'assets/icon/vocabuaryPopup.svg',
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    return;
                  },
                  child: Container(
                    width: 29,
                    height: 29,
                    margin: EdgeInsets.only(right: 14, top: 6),
                    child: SvgPicture.asset(
                      'assets/icon/iconClose.svg',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLoginDialog() {
    slideDialog.showSlideDialog(
      propVisibility: true,
      bgGradient: popupLoginGradient,
      gradientStop: popupLoginStop,
      containerColor: Colors.transparent,
      context: context,
      child: Material(
        color: Colors.transparent,
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 86,
                  margin: EdgeInsets.only(top: 27),
                  child: SvgPicture.asset(
                    'assets/icon/wiseKidsLogoLogin.svg',
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.only(top: 120),
                  child: Text(
                    'Sign in to set up multiple profiles.',
                    style: TextStyle(
                      fontFamily: 'NunitoRegular',
                      fontSize: 9,
                      color: Color.fromRGBO(255, 255, 255, 1.00),
                    ),
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    return;
                  },
                  child: Container(
                    width: 20,
                    height: 20,
                    margin: EdgeInsets.only(right: 17, top: 17),
                    child: SvgPicture.asset(
                      'assets/icon/iconClose.svg',
                    ),
                  ),
                ),
              ),
            ),
            //////////////////////////////////////////////////////////////////// facebook btn
            Positioned.fill(
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.only(top: 159),
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.25),
                        blurRadius:
                            15.0, // has the effect of softening the shadow
                        spreadRadius:
                            -5, // has the effect of extending the shadow
                        offset: Offset(
                          0.0, // horizontal, move right 10
                          10.0, // vertical, move down 10
                        ),
                      ),
                    ],
                    color: Colors.white,
                  ),
                  height: 44,
                  width: 300,
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Facebook',
                            style: TextStyle(
                              fontFamily: 'NunitoRegular',
                              fontSize: 11,
                              color: Color.fromRGBO(80, 85, 89, 1.00),
                            ),
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(left: 22),
                            child: SvgPicture.asset(
                              'assets/icon/Facebook.svg',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ////////////////////////////////////////////////////////////////// google btn
            Positioned.fill(
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.only(top: 220),
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.25),
                        blurRadius:
                            15.0, // has the effect of softening the shadow
                        spreadRadius:
                            -5, // has the effect of extending the shadow
                        offset: Offset(
                          0.0, // horizontal, move right 10
                          10.0, // vertical, move down 10
                        ),
                      ),
                    ],
                    color: Colors.white,
                  ),
                  height: 44,
                  width: 300,
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Google',
                            style: TextStyle(
                              fontFamily: 'NunitoRegular',
                              fontSize: 11,
                              color: Color.fromRGBO(80, 85, 89, 1.00),
                            ),
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(left: 22),
                            child: SvgPicture.asset(
                              'assets/icon/Google.svg',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ////////////////////////////////// use as guest
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(bottom: 18),
                  child: Text(
                    'Use as Guest',
                    style: TextStyle(
                      fontFamily: 'NunitoRegular',
                      fontSize: 10,
                      color: Color.fromRGBO(255, 255, 255, 1.00),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showThemeDialog() {
    slideDialog.showSlideDialog(
      propVisibility: false,
      bgGradient: popupSelectThemeGradient,
      gradientStop: popupSelectThemeStop,
      containerColor: Colors.white,
      context: context,
      child: Stack(
        children: <Widget>[
          Container(
            child: SvgPicture.asset(
              'assets/images/whiteCloudBG.svg',
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  return;
                },
                child: Container(
                  width: 20,
                  height: 20,
                  margin: EdgeInsets.only(right: 17, top: 17),
                  child: SvgPicture.asset(
                    'assets/icon/iconClose.svg',
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 126,
            margin: EdgeInsets.only(top: 40),
            child: new Swiper(
              index: 1,
              loop: false,
              controller: avatarSwipeController,
              onTap: (int index) {
                if (index == 0) {
                  avatarSwipeController.move(0, animation: true);
                } else if (index == 1) {
                  avatarSwipeController.move(1, animation: true);
                } else if (index == 2) {
                  avatarSwipeController.move(2, animation: true);
                }
              },
              onIndexChanged: (int index) {
                print(index);
                setState(() {
                  avtarIndex = index;
                });
              },
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      BoxShadow(
                        color: popupShadowColor,
                        blurRadius:
                            15.0, // has the effect of softening the shadow
                        spreadRadius:
                            -5, // has the effect of extending the shadow
                        offset: Offset(
                          0.0, // horizontal, move right 10
                          10.0, // vertical, move down 10
                        ),
                      )
                    ],
                  ),
                  margin: EdgeInsets.only(left: 8, right: 8, bottom: 20),
                  child: new ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      avatar[index],
                      fit: BoxFit.fill,
                    ),
                  ),
                );
              },
              itemCount: 3,
              viewportFraction: 0.31,
              scale: 0.2,
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Container(
                height: 50,
                width: 300,
                margin: EdgeInsets.only(top: 45),
                child: SvgPicture.asset(
                  'assets/icon/selectYourTheme.svg',
                  color: themeColor,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                //margin: EdgeInsets.only(bottom: 0),
                width: 325,
                child: Wrap(
                  alignment: WrapAlignment.start,
                  runSpacing: 15,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedTheme = '0';
                        });

                        _themefunction();
                      },
                      child: ColorThemeWidget(
                        gradientColor: themeColor1,
                        gradientOffset: themeColor1Offset,
                        checkedVisibility: SelectedVisibility.aquaLime,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedTheme = '1';
                        });

                        _themefunction();
                      },
                      child: ColorThemeWidget(
                          gradientColor: themeColor2,
                          gradientOffset: themeColor2Offset,
                          checkedVisibility: SelectedVisibility.aquaViolet),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedTheme = '2';
                        });

                        _themefunction();
                      },
                      child: ColorThemeWidget(
                        gradientColor: themeColor3,
                        gradientOffset: themeColor3Offset,
                        checkedVisibility: SelectedVisibility.violetMagenta,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedTheme = '3';
                        });

                        _themefunction();
                      },
                      child: ColorThemeWidget(
                        gradientColor: themeColor4,
                        gradientOffset: themeColor4Offset,
                        checkedVisibility: SelectedVisibility.yellowSalmon,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedTheme = '4';
                        });

                        _themefunction();
                      },
                      child: ColorThemeWidget(
                        gradientColor: themeColor5,
                        gradientOffset: themeColor5Offset,
                        checkedVisibility: SelectedVisibility.pinkYellow,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedTheme = '5';
                        });

                        _themefunction();
                      },
                      child: ColorThemeWidget(
                        gradientColor: themeColor6,
                        gradientOffset: themeColor6Offset,
                        checkedVisibility: SelectedVisibility.blueCat,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  checkAvatar() {
    setState(() {
      if (widget.avatar == 'Boy') {
        avtarIndex = 0;
      } else if (widget.avatar == 'Girl') {
        avtarIndex = 1;
      } else if (widget.avatar == 'Cat') {
        avtarIndex = 2;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  ////////////////////////////////////////////////////////////////  BG
                  Center(
                    child: Container(
                      child: SvgPicture.asset(
                        'assets/images/bgPattern.svg',
                      ),
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        // Box decoration takes a gradient
                        gradient: LinearGradient(
                          // Where the linear gradient begins and ends
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          // Add one stop for each color. Stops should increase from 0 to 1
                          stops: [0.1, 0.42],
                          colors: bgGradient,
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        color: Colors.white,
                        height: MediaQuery.of(context).size.height / 2,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        child: SvgPicture.asset(
                          'assets/images/whiteCloudBG.svg',
                        ),
                      ),
                    ),
                  ),
                  /////////////////////////////////////////////////////////////////////////////// end of BG
                  ///
                  ///////////////////////////////////////////////////////////////////////////////  Begin of Avatar, Vocab, Category, login dropdown
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _showThemeDialog();
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 15, left: 15),
                      decoration: new BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                            blurRadius:
                                15.0, // has the effect of softening the shadow
                            spreadRadius:
                                -5, // has the effect of extending the shadow
                            offset: Offset(
                              0.0, // horizontal, move right 10
                              10.0, // vertical, move down 10
                            ),
                          )
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Container(
                          child: Image.asset(
                            avatar[avtarIndex],
                          ),
                          height: 97,
                          width: 97,
                        ),
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: _showVocabuaryDialog,
                    child: Container(
                      margin: EdgeInsets.only(top: 18, left: 135),
                      height: 69,
                      child: SvgPicture.asset(
                        'assets/icon/Vocabuary.svg',
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: _showCategoryDialog,
                    child: Container(
                      margin: EdgeInsets.only(top: 18, left: 220),
                      height: 69,
                      child: SvgPicture.asset(
                        'assets/icon/Category.svg',
                      ),
                    ),
                  ),

                  Stack(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                          top: 32,
                          left: MediaQuery.of(context).size.width * 0.8025,
                        ),
                        child: SvgPicture.asset(
                          'assets/icon/Button_Yl.svg',
                        ),
                      ),
                    ],
                  ),

                  IndexedStack(
                    index:
                        0, ////////////////////////////////////////////////////////////////////////// Login Button switch
                    children: <Widget>[
                      GestureDetector(
                        onTap: _showLoginDialog,
                        child: Container(
                          height: 45,
                          width: 148,
                          margin: EdgeInsets.only(
                            top: 32,
                            left: MediaQuery.of(context).size.width * 0.8025,
                          ),
                          child: Stack(
                            children: <Widget>[
                              Container(
                                alignment: Alignment(1.0, 0.0),
                                margin: EdgeInsets.only(right: 20),
                                child: SvgPicture.asset(
                                  'assets/icon/arrowRight.svg',
                                ),
                              ),
                              Container(
                                alignment: Alignment(-1.0, 0.0),
                                margin: EdgeInsets.only(left: 20),
                                child: Text(
                                  'Login        ',
                                  style: TextStyle(
                                      fontFamily: 'NunitoBlack',
                                      fontSize: 15,
                                      color:
                                          Color.fromRGBO(255, 255, 255, 1.00)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 32,
                          left: MediaQuery.of(context).size.width * 0.8025,
                        ),
                        height: 45,
                        width: 148,
                        child: Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              icon: SvgPicture.asset(
                                'assets/icon/arrowDown.svg',
                              ),
                              onChanged: (String value) {
                                setState(() {
                                  _value = value;
                                });
                              },
                              hint: Text(
                                'Login',
                                style: TextStyle(
                                    fontFamily: 'NunitoBlack',
                                    fontSize: 15,
                                    color: Color.fromRGBO(255, 255, 255, 1.00)),
                              ),
                              items: [
                                DropdownMenuItem<String>(
                                  child: Text('Item 1'),
                                  value: 'one',
                                ),
                                DropdownMenuItem<String>(
                                  child: Text('Item 2'),
                                  value: 'two',
                                ),
                                DropdownMenuItem<String>(
                                  child: Text('Item 3'),
                                  value: 'three',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  ///////////////////////////////////////////////////////////////////////////////  Bookshelf
                  Container(
                    margin: EdgeInsets.only(top: 155),
                    height: 230,
                    width: MediaQuery.of(context).size.width,
                    child: new Swiper(
                      onTap: (index) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WithARkitScreen(),
                          ),
                        );
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: shadowColor,
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
                          margin: EdgeInsets.only(
                              left: 12, right: 12, bottom: 10, top: 10),
                          //padding: EdgeInsets.only(bottom: 20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Container(
                              child: new Image.asset(
                                bookShelf[index],
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: 8,
                      //itemHeight: 206,
                      //itemWidth: 147,

                      viewportFraction: 0.22,
                      scale: 1.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CatagoryBtn extends StatelessWidget {
  final double iconWidth;
  final double iconHeight;
  final String iconImage;
  final String title;
  final double iconMarginTop;

  const CatagoryBtn({
    this.iconMarginTop,
    this.iconHeight,
    this.iconWidth,
    this.iconImage,
    this.title,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      width: 120,
      height: 120,
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.only(top: iconMarginTop),
                width: iconWidth,
                height: iconHeight,
                child: SvgPicture.asset(
                  iconImage,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: 11),
                child: Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'NunitoBlack',
                    fontSize: 12,
                    color: MyColor.aqua,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
>>>>>>> 7bfdda0a3c8ea7faa13ccbb6c2a0b7e9a11ef939
