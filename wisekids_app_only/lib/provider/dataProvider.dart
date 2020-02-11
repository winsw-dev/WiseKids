import 'package:flutter/material.dart';

class DataProvider extends ChangeNotifier {
  /// Internal, private state

  ///////////////// avatar var
  String _avatar = '';

  ///////////////// theme var
  int _theme = 1;
  bool _theme1Visibility = true;
  bool _theme2Visibility = false;
  bool _theme3Visibility = false;
  bool _theme4Visibility = false;
  bool _theme5Visibility = false;
  Color _profileBorderColor = Color.fromRGBO(255, 96, 83, 1.00);
  int _starScoreBgAndloginBtn = 0;


  ///////////////// An unmodifiable view
  String get avatar => _avatar;
  int get theme => _theme;
  Color get profileBorderColor => _profileBorderColor;
  int get starScoreBgAndloginBtn => _starScoreBgAndloginBtn;

  bool get theme1Visibility => _theme1Visibility;
  bool get theme2Visibility => _theme2Visibility;
  bool get theme3Visibility => _theme3Visibility;
  bool get theme4Visibility => _theme4Visibility;
  bool get theme5Visibility => _theme5Visibility;

////////////////////////////////////////////////  Avatar
  void selectAvatar(String avatar) {
    _avatar = avatar;
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  selectAvatarSwiperIndex() {
    if (_avatar == 'boy') {
      return 0;
    } else if (_avatar == 'girl') {
      return 1;
    } else if (_avatar == 'cat') {
      return 2;
    }
    notifyListeners();
  }

  void selectAvatarSwiper(int index) {
    if (index == 0) {
      _avatar = 'boy';
    } else if (index == 1) {
      _avatar = 'girl';
    } else if (index == 2) {
      _avatar = 'cat';
    }
    notifyListeners();
  }

////////////////////////////////////////////////// Theme
  themeData() {
    if (_theme == 1) {
      return 'assets/images/theme1/theme1FullBg.png';
    } else if (_theme == 2) {
      return 'assets/images/theme2/theme2FullBg.png';
    } else if (_theme == 3) {
      return 'assets/images/theme3/theme3FullBg.png';
    } else if (_theme == 4) {
      return 'assets/images/theme4/theme4FullBg.png';
    } else if (_theme == 5) {
      return 'assets/images/theme5/theme5FullBg.png';
    }
  }

  chooseTheme(int selectedTheme) {
    if (selectedTheme == 1) {
      _theme = 1;
      _theme1Visibility = true;
      _theme2Visibility = false;
      _theme3Visibility = false;
      _theme4Visibility = false;
      _theme5Visibility = false;
      _profileBorderColor = Color.fromRGBO(255, 96, 83, 1.00);
      _starScoreBgAndloginBtn = 0;
    } else if (selectedTheme == 2) {
      _theme = 2;
      _theme1Visibility = false;
      _theme2Visibility = true;
      _theme3Visibility = false;
      _theme4Visibility = false;
      _theme5Visibility = false;
      _profileBorderColor = Color.fromRGBO(245, 98, 167, 1.00);
      _starScoreBgAndloginBtn = 1;
    } else if (selectedTheme == 3) {
      _theme = 3;
      _theme1Visibility = false;
      _theme2Visibility = false;
      _theme3Visibility = true;
      _theme4Visibility = false;
      _theme5Visibility = false;
      _profileBorderColor = Color.fromRGBO(222, 41, 68, 1.00);
      _starScoreBgAndloginBtn = 2;
    } else if (selectedTheme == 4) {
      _theme = 4;
      _theme1Visibility = false;
      _theme2Visibility = false;
      _theme3Visibility = false;
      _theme4Visibility = true;
      _theme5Visibility = false;
      _profileBorderColor = Color.fromRGBO(222, 41, 68, 1.00);
      _starScoreBgAndloginBtn = 3;
    } else if (selectedTheme == 5) {
      _theme = 5;
      _theme1Visibility = false;
      _theme2Visibility = false;
      _theme3Visibility = false;
      _theme4Visibility = false;
      _theme5Visibility = true;
      _profileBorderColor = Color.fromRGBO(51, 73, 57, 1.00);
      _starScoreBgAndloginBtn = 4;
    }

    notifyListeners();
  }
}
