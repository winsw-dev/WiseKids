import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
<<<<<<< HEAD
import 'package:flutter_svg/flutter_svg.dart';
import './home.dart';

class WithARkitScreen extends StatefulWidget {
//recieve data from select avatar page
  final String avatar;
  WithARkitScreen({this.avatar});

=======

class WithARkitScreen extends StatefulWidget {
>>>>>>> 7bfdda0a3c8ea7faa13ccbb6c2a0b7e9a11ef939
  @override
  _WithARkitScreenState createState() => _WithARkitScreenState();
}

class CustomPopupMenu {
<<<<<<< HEAD


=======
>>>>>>> 7bfdda0a3c8ea7faa13ccbb6c2a0b7e9a11ef939
  CustomPopupMenu({this.title, this.scene});

  String title;
  int scene;
}

List<CustomPopupMenu> choices = <CustomPopupMenu>[
  CustomPopupMenu(title: 'AR World Map', scene: 0),
  CustomPopupMenu(title: 'Face Mesh', scene: 1),
  CustomPopupMenu(title: 'Check Support', scene: 2),
  CustomPopupMenu(title: 'Camera Image', scene: 3),
  CustomPopupMenu(title: 'Environment Probes', scene: 4),
  CustomPopupMenu(title: 'AR Core Face Regions', scene: 5),
  CustomPopupMenu(title: 'ARKit Face Blend Shapes', scene: 6),
  CustomPopupMenu(title: 'Face Pose', scene: 7),
  CustomPopupMenu(title: 'Human Body Tracking 2D', scene: 8),
  CustomPopupMenu(title: 'Human Body Tracking 3D', scene: 9),
  CustomPopupMenu(title: 'Human Segmentation Images', scene: 10),
  CustomPopupMenu(title: 'Image Tracking', scene: 11),
  CustomPopupMenu(title: 'Light Estimation', scene: 12),
  CustomPopupMenu(title: 'Object Tracking', scene: 13),
  CustomPopupMenu(title: 'Feathered planes', scene: 14),
  CustomPopupMenu(title: 'Toggle Plane Detection', scene: 15),
  CustomPopupMenu(title: 'Scale', scene: 16),
  CustomPopupMenu(title: 'Simple AR', scene: 17),
];

class _WithARkitScreenState extends State<WithARkitScreen> {
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();
  UnityWidgetController _unityWidgetController;
  double _sliderValue = 0.0;

  CustomPopupMenu _selectedChoices = choices[0];

  void _select(CustomPopupMenu choice) {
    setState(() {
      _selectedChoices = choice;
    });

    print('Selected');

    _unityWidgetController.postMessage(
      'GameManager',
      'LoadGameScene',
      choice.scene.toString(),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
<<<<<<< HEAD
        children: <Widget>[
          UnityWidget(
            onUnityViewCreated: onUnityCreated,
            isARScene: false,
            onUnityMessage: onUnityMessage,
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.topRight,
              child:  Container(
                margin: EdgeInsets.only(top: 150),
                height: 50,
                width: 50,
                child: PopupMenuButton<CustomPopupMenu>(
                  elevation: 3.2,
                  color: Colors.white,
                  initialValue: choices[1],
                  onCanceled: () {
                    print('You have not chossed anything');
                  },
                  tooltip: 'This is tooltip',
                  onSelected: _select,
                  itemBuilder: (BuildContext context) {
                    return choices.map((CustomPopupMenu choice) {
                      return PopupMenuItem<CustomPopupMenu>(
                        value: choice,
                        child: Text(choice.title),
                      );
                    }).toList();
                  },
                ),
              ),
                
              
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                  /* Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Home(widget.avatar),
                          ),
                        ); */},
                              child: Container(
                  margin: EdgeInsets.only(top: 3, left: 3),
                  height: 80,
                  width: 80,
                  child: SvgPicture.asset(
                    'assets/icon/home_AR.svg',
=======
          children: <Widget>[
            UnityWidget(
              onUnityViewCreated: onUnityCreated,
              isARScene: true,
              onUnityMessage: onUnityMessage,
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  margin: EdgeInsets.only(top: 300),
                  height: 50,
                  width: 50,
                  child: PopupMenuButton<CustomPopupMenu>(
                    elevation: 3.2,
                    color: Colors.white,
                    initialValue: choices[1],
                    onCanceled: () {
                      print('You have not chossed anything');
                    },
                    tooltip: 'This is tooltip',
                    onSelected: _select,
                    itemBuilder: (BuildContext context) {
                      return choices.map((CustomPopupMenu choice) {
                        return PopupMenuItem<CustomPopupMenu>(
                          value: choice,
                          child: Text(choice.title),
                        );
                      }).toList();
                    },
>>>>>>> 7bfdda0a3c8ea7faa13ccbb6c2a0b7e9a11ef939
                  ),
                ),
              ),
            ),
<<<<<<< HEAD
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: EdgeInsets.only(top: 10, right: 6),
                height: 80,
                width: 80,
                child: SvgPicture.asset(
                  'assets/icon/3d_AR.svg',
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                //margin: EdgeInsets.only(bottom: 8),
                height: 105,
                
                child: Image.asset(
                  'assets/icon/button_book_back.png',
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                //margin: EdgeInsets.only(bottom: 8),
                height: 105,
                
                child: Image.asset(
                  'assets/icon/button_book_forward.png',
                ),
              ),
            ),
          ),
        ],
      ),
=======
          ],
        ),
     
>>>>>>> 7bfdda0a3c8ea7faa13ccbb6c2a0b7e9a11ef939
    );
  }

  void setRotationSpeed(String speed) {
    _unityWidgetController.postMessage(
      'Cube',
      'SetRotationSpeed',
      speed,
    );
  }

  void onUnityMessage(controller, message) {
    print('Received message from unity: ${message.toString()}');
  }

  // Callback that connects the created controller to the unity controller
  void onUnityCreated(controller) {
    this._unityWidgetController = controller;
  }
}
