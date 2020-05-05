import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as services;
import 'package:provider/provider.dart';
//import 'package:shimmer/shimmer.dart';
import './screen/selectAvatar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
//import 'with_arkit_screen.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import './provider/dataProvider.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './screen/home.dart';

/////////////////////////// Device Preview
void main() => runApp(
      DevicePreview(
          /* style: DevicePreviewStyle(
            toolBar: DevicePreviewToolBarStyle.light(),
            background: BoxDecoration(color: const Color(0xFFFF0000)),
          ), */
          enabled: true,
          builder: (context) => MultiProvider(
                providers: [
                  ChangeNotifierProvider(
                    create: (context) => DataProvider.instance(),
                  ),
                  /*  ChangeNotifierProvider.value(
                    value: UserAuthentication.instance(),
                  ), */
                ],
                child: Phoenix(child: MyApp()),
              )),
    );

/*  void main() => runApp(
  ChangeNotifierProvider(
      create: (context) => DataProvider(),
      child: MyApp(),
    ),
  
  ); */

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Hide notification bar
    services.SystemChrome.setEnabledSystemUIOverlays([]);
    // Set landscape orientation
    services.SystemChrome.setPreferredOrientations([
      services.DeviceOrientation.landscapeLeft,
      services.DeviceOrientation.landscapeRight,
    ]);

    return MaterialApp(
      // Device Preview
      locale: DevicePreview.of(context).locale, // <--- Add the locale
      builder: DevicePreview.appBuilder, // <--- Add the builder

      debugShowCheckedModeBanner: false,
      title: 'WiseKids',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyColor {
  static var turquoise = Color(0xFF4BDBCD);
  static var limeGreen = Color(0xFF86CF4B);
  static var aqua = Color(0xFF47DBE0);
  static var violet = Color(0xFFB839EA);
  static var magenta = Color(0xFFFB64A6);
  static var yellow = Color(0xFFF8E237);
  static var salmon = Color(0xFFFF5F4A);
  static var pinkBg = Color(0xFFE44590);
  static var yellowBg = Color(0xFFF0D322);
  static var babyBlueBG = Color(0xFFC7D8FF);
  static var babyBlueBg2 = Color(0xFF82A8FF);
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AudioCache audioCache = AudioCache();

  ////////////////////////////// Function to check how many time wisekids has been opened
  openAppCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _checkValue = prefs.containsKey('appOpenCount'); ////// check key

    if (_checkValue) {
      /////// if true openTime+1
      int openTimeStored = prefs.getInt('appOpenCount');
      int openTimeCurrent = openTimeStored + 1;
      /////// save open time data to provider 
      Provider.of<DataProvider>(context, listen: false)
          .appOpenData(openTimeCurrent);
      print(
          '######################################\nWiseKids App has opened for $openTimeCurrent times.\n######################################');
      prefs.setInt('appOpenCount', openTimeCurrent);
    } else {
      ////////// if false then set initial value
      prefs.setInt('appOpenCount', 1);
      print(
          '######################################\nWiseKids App has opened for 1 times.\n######################################');
    }
  }

  @override
  void initState() {
    super.initState();
    openAppCount();
    Future.delayed(Duration(seconds: 2), () {
      //audioCache.loop('sound/background.mp3'); ////// BG sound
      FirebaseAuth.instance
          .currentUser()
          .then((currentUser) => {
                if (currentUser == null)
                  {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SelectAvatar(),
                      ),
                    )
                  }
                else
                  {
                    Firestore.instance
                        .collection("WiseKidsUser")
                        .document(currentUser.uid)
                        .get()
                        .then((DocumentSnapshot result) async {
                          
                      /* //////////////////////////////////////////////////// restore avatar & theme data
                      Provider.of<DataProvider>(context, listen: false)
                          .selectAvatar(result["kidsAvatar"]);
                      await Provider.of<DataProvider>(context, listen: false)
                          .chooseTheme(result["kidsTheme"]); */
                      //////////////////////////////////////////////////// restore user data ex. name email age etc.
                      await Provider.of<DataProvider>(context, listen: false)
                          .restoreUserData(result);
                      /* Provider.of<DataProvider>(context, listen: false)
                          .chooseTheme(result["kids1Name"]); */
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Home(

                                  /* title: result["fname"] + "'s Tasks",
                                          uid: currentUser.uid, */
                                  )));
                    }).catchError((err) => print(err))
                  }
              })
          .catchError((err) => print(err));
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    /// initialize device size into provider 
    Provider.of<DataProvider>(context, listen: false)
                                  .getDeviceSize(deviceHeight, deviceWidth);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: deviceWidth,
            height: deviceHeight,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [
                  0.1,
                  1.0
                ],
                    colors: [
                  Color.fromRGBO(71, 220, 214, 1.0),
                  Color.fromRGBO(132, 207, 78, 1.0),
                ])),
          ),
          ////////////////////////////////////////////// Pattern
          Container(
            width: deviceWidth,
            child: Image.asset(
              'assets/images/splashScreen/pattern.png',
              fit: BoxFit.fitWidth,
            ),
          ),
          /////////////////////////////////////////////// Logo
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Container(
                width: deviceWidth * 0.34,
                child: Image.asset(
                  'assets/images/splashScreen/wisekidsLogo.png',
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
