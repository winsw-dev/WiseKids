import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class DataProvider extends ChangeNotifier {
  /// Internal, private state

  int _appOpen;
  bool _appReviewed = false;

  ///////////////// Book Statistics var
  Map _bookStatistics = {
    'book1':{
      'kidsReview':[],
      //////////
      'kidsExerciseScore':{ //// if score == null then don't show score bar
        /// '0' is index of kids in profile
        /// null value in score array mean that this kids haven't done an exercise yet thus no score recorded
        /// u should do funtion to add score like if score[0]**firstTime score == null then assign this score if != null look at next index
        /// and if all position != null then pop 1st position score and add recentest score to last position
        '0':[null,null,null],
        
      },
      //////////
      'kidsStickerCollection':[{
        'stickers':[]
      }],
      //////////
      'timeRead':[0]
    }
  };

  ///////////////// Current kids select by user
  int _currentKids = 0;

  ///////////////// User Account data
  String _userName, _userEmail;
  bool _userAcceptConsent;

  ///////////////// display data var
  List<String> _avatar = [''];
  List<String> _kidsName=[''];
  List<String> _kidsAge=[''];
  List<String> _displayName=[''];
  List<int> _kidsStar = [0];

  ///////////////// theme var
  List<int> _theme = [1];
  bool _theme1Visibility = true;
  bool _theme2Visibility = false;
  bool _theme3Visibility = false;
  bool _theme4Visibility = false;
  bool _theme5Visibility = false;

  Color _profileBorderColor = Color.fromRGBO(255, 96, 83, 1.00);

  ///////////////// Select Avatar&Theme addMoreKids Popup variables
  String _addkidsAvatar = 'boy';
  int _addkidsTheme = 1;

  bool _addkidsTheme1Visibility = true;
  bool _addkidsTheme2Visibility = false;
  bool _addkidsTheme3Visibility = false;
  bool _addkidsTheme4Visibility = false;
  bool _addkidsTheme5Visibility = false;

  ////////////////// Authentication var
  FirebaseAuth _auth;
  FirebaseUser _user;
  Status _status = Status.Uninitialized;

  DataProvider.instance() : _auth = FirebaseAuth.instance {
    _auth.onAuthStateChanged.listen(_onAuthStateChanged);
  }

  String _signinMethod;

  ///////////////// An unmodifiable view
  Map get bookStatistics => _bookStatistics;
  int get appOpen => _appOpen;
  bool get appReviewed => _appReviewed;
  List<String> get avatar => _avatar;
  List<int> get theme => _theme;
  List<String> get kidsName => _kidsName;
  List<String> get kidsAge => _kidsAge;
  List<int> get kidsStar => _kidsStar;
  String get userName => _userName;
  String get userEmail => _userEmail;
  bool get userAcceptConsent => _userAcceptConsent;
  int get currentKids => _currentKids;
  List<String> get displayName => _displayName;

  Color get profileBorderColor => _profileBorderColor;

  bool get theme1Visibility => _theme1Visibility;
  bool get theme2Visibility => _theme2Visibility;
  bool get theme3Visibility => _theme3Visibility;
  bool get theme4Visibility => _theme4Visibility;
  bool get theme5Visibility => _theme5Visibility;

  Status get status => _status;
  FirebaseUser get user => _user;

  String get signinMethod => _signinMethod;

  /////////////////////// save App open data to current session
  appOpenData(int timeAppHasOpened) {
    _appOpen = timeAppHasOpened;
  }

/////////////////////// Select Avatar&Theme addMoreKids Popup unmodifiable view & functions
  String get addkidsAvatar => _addkidsAvatar;
  int get addkidsTheme => _addkidsTheme;

  bool get addkidsTheme1Visibility => _addkidsTheme1Visibility;
  bool get addkidsTheme2Visibility => _addkidsTheme2Visibility;
  bool get addkidsTheme3Visibility => _addkidsTheme3Visibility;
  bool get addkidsTheme4Visibility => _addkidsTheme4Visibility;
  bool get addkidsTheme5Visibility => _addkidsTheme5Visibility;

  selectAvatarSwiperIndexAddKids() {
    if (_addkidsAvatar == 'boy') {
      return 0;
    } else if (_addkidsAvatar == 'girl') {
      return 1;
    } else if (_addkidsAvatar == 'cat') {
      return 2;
    }
    notifyListeners();
  }

  resetAddKids() {
    _addkidsAvatar = 'boy';
    _addkidsTheme = 1;
    _addkidsTheme1Visibility = true;
    _addkidsTheme2Visibility = false;
    _addkidsTheme3Visibility = false;
    _addkidsTheme4Visibility = false;
    _addkidsTheme5Visibility = false;
    notifyListeners();
  }

  void selectAvatarSwiperAddKids(int index) {
    if (index == 0) {
      _addkidsAvatar = 'boy';
    } else if (index == 1) {
      _addkidsAvatar = 'girl';
    } else if (index == 2) {
      _addkidsAvatar = 'cat';
    }
    notifyListeners();
  }

  chooseThemeAddKids(int selectedTheme) {
    if (selectedTheme == 1) {
      _addkidsTheme = 1;
      _addkidsTheme1Visibility = true;
      _addkidsTheme2Visibility = false;
      _addkidsTheme3Visibility = false;
      _addkidsTheme4Visibility = false;
      _addkidsTheme5Visibility = false;
    } else if (selectedTheme == 2) {
      _addkidsTheme = 2;
      _addkidsTheme1Visibility = false;
      _addkidsTheme2Visibility = true;
      _addkidsTheme3Visibility = false;
      _addkidsTheme4Visibility = false;
      _addkidsTheme5Visibility = false;
    } else if (selectedTheme == 3) {
      _addkidsTheme = 3;
      _addkidsTheme1Visibility = false;
      _addkidsTheme2Visibility = false;
      _addkidsTheme3Visibility = true;
      _addkidsTheme4Visibility = false;
      _addkidsTheme5Visibility = false;
    } else if (selectedTheme == 4) {
      _addkidsTheme = 4;
      _addkidsTheme1Visibility = false;
      _addkidsTheme2Visibility = false;
      _addkidsTheme3Visibility = false;
      _addkidsTheme4Visibility = true;
      _addkidsTheme5Visibility = false;
    } else if (selectedTheme == 5) {
      _addkidsTheme = 5;
      _addkidsTheme1Visibility = false;
      _addkidsTheme2Visibility = false;
      _addkidsTheme3Visibility = false;
      _addkidsTheme4Visibility = false;
      _addkidsTheme5Visibility = true;
    }

    notifyListeners();
  }

////////////////////////////////////////////////  Avatar
  void selectAvatar(String avatar) {
    _avatar[_currentKids] = avatar;
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  selectAvatarSwiperIndex() {
    if (_avatar[_currentKids] == 'boy') {
      return 0;
    } else if (_avatar[_currentKids] == 'girl') {
      return 1;
    } else if (_avatar[_currentKids] == 'cat') {
      return 2;
    }
    notifyListeners();
  }

  void setKisdNameAndAge(String name, String age) {
    _kidsName[_currentKids]= name; 
    _kidsAge[_currentKids]= age;

    _displayName = _kidsName;
    for (var i = 0; i<_kidsName.length; i++) {
      
      if (_kidsName[i].length <= 11) {
        _displayName[i] = _kidsName[i];
      } else if (_kidsName[i].length > 11) {
        _displayName[i] =
            _kidsName[i].substring(0, 10) + '.';
      }
    }

  }

  ///////////////////////////////////////// function to update selected avatar provider and database
  void selectAvatarSwiper(int index) {
    if (index == 0) {
      /////////////////////////////////// modify avatar list following current kids index thex push to database
      _avatar[_currentKids] = 'boy';
      FirebaseAuth.instance.currentUser().then((currentUser) => {
            if (currentUser != null)
              {
                Firestore.instance
                    .collection('WiseKidsUser')
                    .document(currentUser.uid)
                    .setData({'kidsAvatar': _avatar} , merge: true)
              }
          });
    } else if (index == 1) {
      _avatar[_currentKids] = 'girl';
      FirebaseAuth.instance.currentUser().then((currentUser) => {
            if (currentUser != null)
              {
                Firestore.instance
                    .collection('WiseKidsUser')
                    .document(currentUser.uid)
                    .setData({'kidsAvatar': _avatar} , merge: true)
              }
          });
    } else if (index == 2) {
      _avatar[_currentKids] = 'cat';
      FirebaseAuth.instance.currentUser().then((currentUser) => {
            if (currentUser != null)
              {
                Firestore.instance
                    .collection('WiseKidsUser')
                    .document(currentUser.uid)
                    .setData({'kidsAvatar': _avatar} , merge: true)
              }
          });
    }
    notifyListeners();
  }

////////////////////////////////////////////////// Theme 
/// function to upadate _theme following selected theme and push to database
  

  chooseTheme(int selectedTheme) {
    if (selectedTheme == 1) {
      _theme[_currentKids] = 1;
      _theme1Visibility = true;
      _theme2Visibility = false;
      _theme3Visibility = false;
      _theme4Visibility = false;
      _theme5Visibility = false;
      _profileBorderColor = Color.fromRGBO(255, 96, 83, 1.00);

      FirebaseAuth.instance.currentUser().then((currentUser) => {
            if (currentUser != null)
              {
                Firestore.instance
                    .collection('WiseKidsUser')
                    .document(currentUser.uid)
                    .setData({'kidsTheme': _theme}, merge: true)
              }
          });
    } else if (selectedTheme == 2) {
      _theme[_currentKids] = 2;
      _theme1Visibility = false;
      _theme2Visibility = true;
      _theme3Visibility = false;
      _theme4Visibility = false;
      _theme5Visibility = false;
      _profileBorderColor = Color.fromRGBO(245, 98, 167, 1.00);

      FirebaseAuth.instance.currentUser().then((currentUser) => {
            if (currentUser != null)
              {
                Firestore.instance
                    .collection('WiseKidsUser')
                    .document(currentUser.uid)
                    .setData({'kidsTheme': _theme}, merge: true)
              }
          });
    } else if (selectedTheme == 3) {
      _theme[_currentKids] = 3;
      _theme1Visibility = false;
      _theme2Visibility = false;
      _theme3Visibility = true;
      _theme4Visibility = false;
      _theme5Visibility = false;
      _profileBorderColor = Color.fromRGBO(222, 41, 68, 1.00);

      FirebaseAuth.instance.currentUser().then((currentUser) => {
            if (currentUser != null)
              {
                Firestore.instance
                    .collection('WiseKidsUser')
                    .document(currentUser.uid)
                    .setData({'kidsTheme': _theme}, merge: true)
              }
          });
    } else if (selectedTheme == 4) {
      _theme[_currentKids] = 4;
      _theme1Visibility = false;
      _theme2Visibility = false;
      _theme3Visibility = false;
      _theme4Visibility = true;
      _theme5Visibility = false;
      _profileBorderColor = Color.fromRGBO(222, 41, 68, 1.00);

      FirebaseAuth.instance.currentUser().then((currentUser) => {
            if (currentUser != null)
              {
                Firestore.instance
                    .collection('WiseKidsUser')
                    .document(currentUser.uid)
                    .setData({'kidsTheme': _theme}, merge: true)
              }
          });
    } else if (selectedTheme == 5) {
      _theme[_currentKids] = 5;
      _theme1Visibility = false;
      _theme2Visibility = false;
      _theme3Visibility = false;
      _theme4Visibility = false;
      _theme5Visibility = true;
      _profileBorderColor = Color.fromRGBO(51, 73, 57, 1.00);

      FirebaseAuth.instance.currentUser().then((currentUser) => {
            if (currentUser != null)
              {
                Firestore.instance
                    .collection('WiseKidsUser')
                    .document(currentUser.uid)
                    .setData({'kidsTheme': _theme}, merge: true)
              }
          });
    }

    notifyListeners();
  }

  Future<void> _onAuthStateChanged(FirebaseUser firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = firebaseUser;
      _status = Status.Authenticated;
    }
    notifyListeners();
  }

  ///////////////////////////////////////////////////// Google
/////////////////////////////////////////////////////

  final GoogleSignIn googleSignIn = GoogleSignIn();
  String name;
  String email;
  String imageUrl;

  Future<bool> signInWithGoogle() async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      final GoogleSignInAccount googleSignInAccount =
          await googleSignIn.signIn();

      _signinMethod = 'Google';

      //if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      /* final AuthResult authResult =
            await _auth.signInWithCredential(credential); */

      final googleUser = (await _auth.signInWithCredential(credential)).user;

      // Checking if email and name is null
      assert(googleUser.email != null);
      assert(googleUser.displayName != null);
      assert(googleUser.photoUrl != null);

      name = googleUser.displayName;
      email = googleUser.email;
      imageUrl = googleUser.photoUrl;
      _userName = name;
      _userEmail = email;

      // Only taking the first part of the name, i.e., First Name
      if (name.contains(" ")) {
        name = name.substring(0, name.indexOf(" "));
      }

      assert(!googleUser.isAnonymous);
      assert(await googleUser.getIdToken() != null);

      final FirebaseUser currentUser = await _auth.currentUser();
      assert(googleUser.uid == currentUser.uid);

      final dataSnapShot = await Firestore.instance
          .collection('WiseKidsUser')
          .document(currentUser.uid)
          .get();

      if (dataSnapShot == null || !dataSnapShot.exists) {
        // Document with id == uid doesn't exist. then
        ///// add user data to firestore database (New User)
        await Firestore.instance
            .collection('WiseKidsUser')
            .document(currentUser.uid)
            .setData({
          "uid": currentUser.uid,
          'userName': name,
          'email': email,
          'signInWith': 'Google',
          "acceptedConsent": false,
          'kidsAvatar': _avatar,
          'kidsTheme': _theme,
          'kidsName': _kidsName,
          'kidsAge': _kidsAge,
          'kidsStar': _kidsStar,
          'appReviewed' : _appReviewed,
          'bookStatistics': _bookStatistics
        });
        ////// fetch user data and update provider (Old User)
      } else {
        restoreUserData(dataSnapShot);
      }

      // }
      return true;
      //final FirebaseUser user = authResult.user;

    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  void signOutGoogle() async {
    // Sign out with firebase
    await _auth.signOut();
    // Sign out with Google
    await googleSignIn.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    print("Google Sign Out");
  }

  /////////////////////////////////////////////////////
///////////////////////////////////////////////////// Facebook
  var facebookLogin = FacebookLogin();

  Future<void> signInWithFacebook() async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      var facebookLoginResult =
          await facebookLogin.logIn(['email', "public_profile"]);
      String token = facebookLoginResult.accessToken.token;

      _signinMethod = 'Facebook';

      await _auth.signInWithCredential(
          FacebookAuthProvider.getCredential(accessToken: token));
      switch (facebookLoginResult.status) {
        case FacebookLoginStatus.error:
          print("facebook login Error");
          _status = Status.Unauthenticated;
          notifyListeners();
          return false;
          break;
        case FacebookLoginStatus.cancelledByUser:
          print("facebook login CancelledByUser");
          _status = Status.Unauthenticated;
          notifyListeners();
          return false;
          break;
        case FacebookLoginStatus.loggedIn:
          print("facebook Login success");

          var graphResponse = await http.get(
              'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.height(200)&access_token=${facebookLoginResult.accessToken.token}');

          var profile = json.decode(graphResponse.body);
          _userName = profile['name'];
          _userEmail = profile['email'];
          //print(profile.toString());
          final FirebaseUser currentUser = await _auth.currentUser();

          final dataSnapShot = await Firestore.instance
              .collection('WiseKidsUser')
              .document(currentUser.uid)
              .get();

          if (dataSnapShot == null || !dataSnapShot.exists) {
            // Document with id == uid doesn't exist. then
            ///// add user data to firestore database (New User)
            await Firestore.instance
                .collection('WiseKidsUser')
                .document(currentUser.uid)
                .setData({
              "uid": currentUser.uid,
              'userName': profile['name'],
              'email': profile['email'],
              'signInWith': 'Facebook',
              "acceptedConsent": false,
              'kidsAvatar': _avatar,
              'kidsTheme': _theme,
              'kidsName': _kidsName,
              'kidsAge': _kidsAge,
              'kidsStar': _kidsStar,
              'appReviewed' : _appReviewed,
              'bookStatistics': _bookStatistics
            });
            ////// fetch user data and update provider (Old User)
          } else {
            restoreUserData(dataSnapShot);
          }

          return true;
          break;
      }
      //return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  signOutFacebook() async {
    // Sign out with firebase
    await _auth.signOut();
    // Sign out with Facebook
    await facebookLogin.logOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    print("facebook Logged out");
  }

  restoreUserData(DocumentSnapshot userData) async {
    
    _bookStatistics = userData['bookStatistics'];
    _appReviewed = userData['appReviewed'];
    _userName = userData['userName'];
    _userEmail = userData['email'];
    _userAcceptConsent = userData['acceptedConsent'];
    _kidsName = List<String>.from(userData['kidsName'])    ;
    _kidsAge = List<String>.from(userData['kidsAge']);
    _avatar = List<String>.from(userData['kidsAvatar']);
    _theme = List<int>.from(userData['kidsTheme']);
    _signinMethod = userData['signInWith'];
    _kidsStar = List<int>.from(userData['kidsStar']);

    ///////////////////////////////////////////////////////// sort display name if it too long
    for (var i = 0; i < _kidsName.length; i++) {
      
      if (_kidsName[i].length <= 11) {
        _displayName[i] = _kidsName[i];
      } else if (_kidsName[i].length > 11) {
        _displayName[i] =
            _kidsName[i].substring(0, 10) + '.';
      }
    }
    print('\n----------Restored user data----------');
    print('Account name == $_userName');
    print('Kids in this profile == $_kidsName');
    print('--------------------------------------\n\n');
    notifyListeners();
    /////////////////////////// update theme & avatar after retrive user data from database
    
    chooseTheme(_theme[_currentKids]);
  }

  consentAccepted(bool consentAccepted) {
    _userAcceptConsent = consentAccepted;
  }
}
