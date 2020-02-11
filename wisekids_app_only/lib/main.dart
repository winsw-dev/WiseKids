import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import './screen/selectAvatar.dart';
//import 'with_arkit_screen.dart';
import 'dart:async';


import './provider/dataProvider.dart';


void main() => runApp(ChangeNotifierProvider(
      create: (context) => DataProvider(),
      child: MyApp(),
    ));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Hide notification bar
    SystemChrome.setEnabledSystemUIOverlays([]);
    // Set landscape orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
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
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SelectAvatar(),
        ),
      );
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
    var textStyle = TextStyle(
      fontFamily: 'NunitoBold',
      color: Colors.grey,
      fontSize: 50,
    );
    return Scaffold(
      body: Center(
       
        child: Image.asset('assets/images/splashScreen.png')
        
        
        
        /* Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Shimmer.fromColors(
              baseColor: Color.fromRGBO(180, 180, 180, 1.0),
              highlightColor: Color.fromRGBO(200, 200, 200, 1.0),
              child: Text('WiseKids', style: textStyle),
            )
          ],
        ), */
      ),
    );
  }
}
