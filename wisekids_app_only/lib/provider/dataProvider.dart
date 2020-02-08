
import 'package:flutter/material.dart';

class DataProvider extends ChangeNotifier {
  /// Internal, private state 
  String _avatar = '';

  /// An unmodifiable view
  String get avatar => _avatar;

  
  
  void selectAvatar(String avatar) {
    _avatar = avatar;
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}