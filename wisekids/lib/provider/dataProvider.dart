import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../screen/unityArBook.dart';
import '../widget/addKidsProfile_dialog.dart' as addMoreKidsDialog;
import '../screen/parentalConsent.dart';
import '../screen/parentalKidsCenter.dart';
import '../screen/kidsProfile.dart';
import '../widget/slide_dialog_kidsStatistic.dart' as kidsStatistic;
import '../widget/kidsStatisticPhoneSize.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class DataProvider extends ChangeNotifier {
  /// Internal, private state
  int _displayNameLength = 10;
  int _kidsLimit = 4;
  BuildContext _parentalKidsCenterContext;
  BuildContext _selectKidsPopupContext;
  BuildContext _kidsProfileContext;
  double _deviceHeight;
  double _deviceWidth;

  /// use to create function showAddKids Dialog that required context in provider
  //////////////////

  int _appOpen;
  bool _appReviewed = false;

  ///////////////// Book Statistics var
  List<Map> _bookStatistic = [
    {'readBook': []}
  ]; //when finish reading create,update local var, update database
  /* = {
    'book1': {
      'kidsReview': [null],
      //////////
      'kidsExerciseScore': {
        //// if score == null then don't show score bar
        /// '0' is index of kids in profile
        /// null value in score array mean that this kids haven't done an exercise yet thus no score recorded
        /// u should do funtion to add score like if score[0]**firstTime score == null then assign this score if != null look at next index
        /// and if all position != null then pop 1st position score and add recentest score to last position
        '0': [
          {'firstExerciseScore': null, 'secondExerciseScore': null},
          {'firstExerciseScore': null, 'secondExerciseScore': null},
          {'firstExerciseScore': null, 'secondExerciseScore': null}
        ],
      },
      //////////
      'kidsStickerCollection': [
        {'stickers': []}
      ],
      //////////
      'timeRead': [0],
      'amountRead': [0]
    }
  }; */

  ///////////////// Current kids select by user
  int _currentKids = 0;

  ///////////////// User Account data
  String _userName, _userEmail;
  bool _userAcceptConsent;

  ///////////////// display data var
  List<String> _avatar = [''];
  List<String> _kidsName = [''];
  List<String> _kidsAge = [''];
  List<String> _displayName = [''];
  List<int> _kidsStar = [0];
  List<int> _kidsContentLevel = [1];
  List<Widget> _kidsProfileWidget;
  List<Widget> _selectKidsPopupWidget;
  List<Widget> _kidsProfileReadBookWidget;

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

  ////////////////// UnityARPage Subtitle dat
  List<bool> _textSelected = [];
  String _inputSubtitle = 'Todd likes to eat dessert. Candy is his favourite.';
  List<Widget> _subtitleItems = [];
  bool _allowTab = true; 

  ///////////////// An unmodifiable view
  double get deviceHeight => _deviceHeight;
  double get deviceWidth => _deviceWidth;
  BuildContext get kidsProfileContext => _kidsProfileContext;
  List<Widget> get kidsProfileReadBookWidget => _kidsProfileReadBookWidget;
  BuildContext get selectKidsPopupContext => _selectKidsPopupContext;
  List<Widget> get selectKidsPopupWidget => _selectKidsPopupWidget;
  BuildContext get parentalKidsCenterContext => _parentalKidsCenterContext;
  List<Widget> get kidsProfileWidget => _kidsProfileWidget;
  List<int> get kidsContentLevel => _kidsContentLevel;
  List<Map> get bookStatistic => _bookStatistic;
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

  List<bool> get textSelected => _textSelected;
  String get inputSubtitle => _inputSubtitle;
  List<Widget> get subtitleItems => _subtitleItems;
  bool get allowTab => _allowTab;

  getDeviceSize(double height, double width) {
    _deviceHeight = height;
    _deviceWidth = width;
  }

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

  getParentalKidsCenterBuildContext(BuildContext context) {
    _parentalKidsCenterContext = context;
  }

  void _showAddMoreKisDialog() {
    addMoreKidsDialog.showSlideDialog(
      context: _parentalKidsCenterContext,
    );
  }

  kidsProfileWidgetBuilder() async {
    //////////// put this Future.delayed to prevent setState() or markNeedsBuild() called during build. Error
    /// https://app.asana.com/0/1169144468173007/1174071424345692 <== take a look at this for issue
    await Future.delayed(const Duration(milliseconds: 100), () {});
    // clear widget
    _kidsProfileWidget = [];

    // then rebuild everytime it get call
    for (var i = 0; i < _avatar.length; i++) {
      _kidsProfileWidget.add(
        //////////////////////////////////// Kids Profile
        GestureDetector(
          onTap: () {
            Navigator.of(_parentalKidsCenterContext).push(
              MaterialPageRoute(
                builder: (context) {
                  return KidsProfile(kids: i);
                },
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.only(
                top: 10, bottom: 16, right: _deviceHeight > 500 ? 36 : 25),
            child: Hero(
              tag: i.toString() + 'Profile',
              child: Material(
                color: Colors.transparent,
                child: AspectRatio(
                  aspectRatio: 113 / 129,
                  child: Container(
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(69, 223, 224, 1.00),
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
                        color: Color.fromRGBO(69, 223, 224, 1.00),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(right: 15, left: 15),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(1000),
                            child: Image.asset('assets/images/avatar_' +
                                _avatar[i].toString() +
                                '.png'),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          height: _deviceHeight > 500
                              ? (_deviceHeight * 0.93 * 0.08 +
                                      _deviceWidth * 0.030) *
                                  0.3
                              : (_deviceHeight - (54 + _deviceWidth * 0.025)) *
                                  0.09,
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              _displayName[i],
                              style: TextStyle(
                                  fontFamily: 'NunitoBold',
                                  //fontSize: 21,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }
    _kidsProfileWidget
        .add(///////////////////////////////////// Add more kids Btn
            _avatar.length < _kidsLimit
                ? GestureDetector(
                    onTap: _showAddMoreKisDialog,
                    child: Container(
                      margin: EdgeInsets.only(top: 10, bottom: 16, right: 16),
                      child: AspectRatio(
                        aspectRatio: 113 / 129,
                        child: DottedBorder(
                          color: Color.fromRGBO(69, 223, 224, 1.00),
                          strokeWidth: 2,
                          borderType: BorderType.RRect,
                          radius: Radius.circular(10),
                          dashPattern: [10, 4],
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                                'assets/images/parentalKidsCenter/addMore.svg'),
                          ),
                        ),
                      ),
                    ),
                  )
                : Container());

    notifyListeners();
  }

  addKids(
    String kidsAgeInput,
    String kidsAvatarInput,
    String kidsNameInput,
    int kidsThemeInput,
  ) async {
    print('pressed');
    /////////////////////////////////// add kid to local provider
    _kidsName.add(kidsNameInput);
    _kidsAge.add(kidsAgeInput);
    _kidsContentLevel.add(1);
    _kidsStar.add(0);
    _avatar.add(kidsAvatarInput);
    _theme.add(kidsThemeInput);
    _bookStatistic.add({'readBook': []});
    //set default kidsExerciseScore
    /*  _bookStatistic['book1']['kidsExerciseScore']
        [(_avatar.length - 1).toString()] = [
      {'firstExerciseScore': null, 'secondExerciseScore': null},
      {'firstExerciseScore': null, 'secondExerciseScore': null},
      {'firstExerciseScore': null, 'secondExerciseScore': null}
    ];
    _bookStatistic['book1']['kidsReview'].add(null);
    _bookStatistic['book1']['kidsStickerCollection'].add({'stickers': []});
    _bookStatistic['book1']['timeRead'].add(0); 
    _bookStatistic['book1']['amountRead'].add(0);*/

    /////// sort display name
    for (var i = 0; i < _kidsName.length; i++) {
      if (_kidsName[i].length <= _displayNameLength) {
        _displayName[i] = _kidsName[i];
      } else if (_kidsName[i].length > _displayNameLength) {
        _displayName[i] = _kidsName[i].substring(0, 10) + '.';
      }
    }

    notifyListeners();
    /////////////////////////////////// add kids to database
    final FirebaseUser currentUser = await _auth.currentUser();

    await Firestore.instance
        .collection('WiseKidsUser')
        .document(currentUser.uid)
        .updateData(
      {
        'kidsAvatar': _avatar,
        'kidsTheme': _theme,
        'kidsName': _kidsName,
        'kidsAge': _kidsAge,
        'kidsStar': _kidsStar,
        'bookStatistic': _bookStatistic,
        'kidsContentLevel': _kidsContentLevel,
      }, /* merge: true */
    );
    kidsProfileWidgetBuilder();
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
    _kidsName[_currentKids] = name;
    _kidsAge[_currentKids] = age;

    _displayName = _kidsName;
    for (var i = 0; i < _kidsName.length; i++) {
      if (_kidsName[i].length <= _displayNameLength) {
        _displayName[i] = _kidsName[i];
      } else if (_kidsName[i].length > _displayNameLength) {
        _displayName[i] = _kidsName[i].substring(0, 10) + '.';
      }
    }
  }

  ///////////////////////////////////////// function to update selected avatar provider and database
  void selectAvatarSwiper(int index) {
    if (index == 0) {
      /////////////////////////////////// modify avatar list following current kids index thex push to database
      _avatar[_currentKids] = 'boy';
      saveDataToSharedPreferences();
      FirebaseAuth.instance.currentUser().then((currentUser) => {
            if (currentUser != null)
              {
                Firestore.instance
                    .collection('WiseKidsUser')
                    .document(currentUser.uid)
                    .setData({'kidsAvatar': _avatar}, merge: true)
              }
            else if (currentUser == null)
              {}
          });
    } else if (index == 1) {
      _avatar[_currentKids] = 'girl';
      saveDataToSharedPreferences();
      FirebaseAuth.instance.currentUser().then((currentUser) => {
            if (currentUser != null)
              {
                Firestore.instance
                    .collection('WiseKidsUser')
                    .document(currentUser.uid)
                    .setData({'kidsAvatar': _avatar}, merge: true)
              }
          });
    } else if (index == 2) {
      _avatar[_currentKids] = 'cat';
      saveDataToSharedPreferences();
      FirebaseAuth.instance.currentUser().then((currentUser) => {
            if (currentUser != null)
              {
                Firestore.instance
                    .collection('WiseKidsUser')
                    .document(currentUser.uid)
                    .setData({'kidsAvatar': _avatar}, merge: true)
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
      saveDataToSharedPreferences();

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
      saveDataToSharedPreferences();

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
      saveDataToSharedPreferences();

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
      saveDataToSharedPreferences();

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
      saveDataToSharedPreferences();

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

      // Only taking the first part of the name, i.e., First Name
      if (name.contains(" ")) {
        name = name.substring(0, name.indexOf(" "));
      }

      _userName = name;
      _userEmail = email;

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
          'appReviewed': _appReviewed,
          'bookStatistic': _bookStatistic,
          'kidsContentLevel': _kidsContentLevel,
          'currentKids': _currentKids,
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
              'appReviewed': _appReviewed,
              'bookStatistic': _bookStatistic,
              'kidsContentLevel': _kidsContentLevel,
              'currentKids': _currentKids,
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
    _kidsContentLevel = List<int>.from(userData['kidsContentLevel']);
    _bookStatistic = List<Map>.from(userData['bookStatistic']);
    _appReviewed = userData['appReviewed'];
    _userName = userData['userName'];
    _userEmail = userData['email'];
    _userAcceptConsent = userData['acceptedConsent'];
    _kidsName = List<String>.from(userData['kidsName']);
    _kidsAge = List<String>.from(userData['kidsAge']);
    _avatar = List<String>.from(userData['kidsAvatar']);
    _theme = List<int>.from(userData['kidsTheme']);
    _signinMethod = userData['signInWith'];
    _kidsStar = List<int>.from(userData['kidsStar']);
    _currentKids = userData['currentKids'];

    print(_bookStatistic);

    ///////////////////////////////////////////////////////// sort display name if it too long
    for (var i = 0; i < _kidsName.length; i++) {
      if (_displayName.length < _kidsName.length) {
        _displayName.add('');
      }

      if (_kidsName[i].length <= _displayNameLength) {
        _displayName[i] = _kidsName[i];
      } else if (_kidsName[i].length > _displayNameLength) {
        _displayName[i] = _kidsName[i].substring(0, 10) + '.';
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

  /// reset variable in provider to default
  resetProvider() async {
    _avatar = [''];
    _kidsName = [''];
    _kidsAge = [''];
    _displayName = [''];
    _kidsStar = [0];
    _kidsContentLevel = [1];
    _theme = [1];
    _theme1Visibility = true;
    _theme2Visibility = false;
    _theme3Visibility = false;
    _theme4Visibility = false;
    _theme5Visibility = false;
    _currentKids = 0;
    _profileBorderColor = Color.fromRGBO(255, 96, 83, 1.00);
    _bookStatistic = [
      {'readBook': []}
    ];

    /// reset local database
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    /* = {
      'book1': {
        'kidsReview': [null],
        'kidsExerciseScore': {
          '0': [
            {'firstExerciseScore': null, 'secondExerciseScore': null},
            {'firstExerciseScore': null, 'secondExerciseScore': null},
            {'firstExerciseScore': null, 'secondExerciseScore': null}
          ],
        },
        'kidsStickerCollection': [
          {'stickers': []}
        ],
        'timeRead': [0],
        'amountRead': [0]
      }
    };
    _appReviewed = false;*/
  }

  selectKidsPopupWidgetBuilder(BuildContext context) {
    /// reset list before build
    _selectKidsPopupWidget = [];

    for (var i = 0; i < _avatar.length; i++) {
      _selectKidsPopupWidget.add(
        /////////////////////////////////////////// kid name
        Padding(
          padding: EdgeInsets.only(
            left: _deviceHeight > 500
                ? (_deviceWidth * 0.075) * (178 / 58) * 0.07
                : (_deviceWidth * 0.065) * (178 / 58) * 0.07,
            /* right: _deviceHeight > 500
                  ? (_deviceWidth * 0.075) * (178 / 58) * 0.07
                  : (_deviceWidth * 0.065) * (178 / 58) * 0.07 */
          ),
          child: GestureDetector(
            onTap: () {
              print('Choosen kids: ' + _kidsName[i]);
              _currentKids = i;
              chooseTheme(_theme[_currentKids]);
              notifyListeners();
              ////////// save selected kids to database to save select kids stage after restart
              FirebaseAuth.instance.currentUser().then((currentUser) => {
                    if (currentUser != null)
                      {
                        Firestore.instance
                            .collection('WiseKidsUser')
                            .document(currentUser.uid)
                            .setData({'currentKids': _currentKids}, merge: true)
                      }
                  });
            },
            child: Row(
              children: <Widget>[
                Container(
                  height: _deviceHeight > 500
                      ? (_deviceWidth * 0.075) * 0.45
                      : (_deviceWidth * 0.065) * 0.50,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    ////////// change display name hilight following selecet kids
                    child: Consumer<DataProvider>(
                      builder: (context, provider, child) => Text(
                        _displayName[i],
                        style: TextStyle(
                          fontFamily: 'NunitoBold',
                          //fontSize: deviceHeight > 500 ? 20 : 16,
                          color: provider.currentKids == i
                              ? Color.fromRGBO(69, 223, 224, 1.0)
                              : Color.fromRGBO(160, 163, 168, 1.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      _selectKidsPopupWidget.add(
        ////////////////////////////////////////////////////////////// Devider
        Divider(
          height: _deviceHeight > 500
              ? (_deviceWidth * 0.075) * (178 / 58) * 0.07 * 2
              : (_deviceWidth * 0.065) * (178 / 58) * 0.07 * 2,
          color: Color.fromRGBO(238, 239, 243, 1.0),
        ),
      );
    }
    _selectKidsPopupWidget.add(
      ////////////////////////////////////////////////////////////// Paretal Area
      GestureDetector(
        onTap: () {
          /////////////////////////////// if consented skip to parentCenter
          if (_userAcceptConsent) {
            Navigator.pop(context);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return ParentalKidsCenter();
                },
              ),
            );
          } else {
            ////////////////////// if not consented goto parentConsent
            Navigator.pop(context);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return ParentalConsent(
                    consentDetail: _signinMethod,
                  );
                },
              ),
            );
          }
        },
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  left: _deviceHeight > 500
                      ? (_deviceWidth * 0.075) * (178 / 58) * 0.07
                      : (_deviceWidth * 0.065) * (178 / 58) * 0.07),
              child: Container(
                height: _deviceHeight > 500
                    ? (_deviceWidth * 0.075) * 0.45
                    : (_deviceWidth * 0.065) * 0.50,
                alignment: Alignment.centerLeft,
                child: Container(
                  height: _deviceHeight > 500
                      ? (_deviceWidth * 0.075) * 0.35
                      : (_deviceWidth * 0.065) * 0.40,
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      'Parental Area',
                      style: TextStyle(
                        fontFamily: 'NunitoRegular',
                        //fontSize: deviceHeight > 500 ? 20 : 16,
                        color: Color.fromRGBO(160, 163, 168, 1.0),
                      ),
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

  getKidsProfileBuildContext(BuildContext context) {
    _kidsProfileContext = context;
  }

  kidsProfileReadBookWidgetBuilder(int whichKids) {
    ///////// clear array before build
    _kidsProfileReadBookWidget = [];

    if (_bookStatistic[whichKids]['readBook'][0] != null) {
      print('pass');
      for (var i in _bookStatistic[whichKids]['readBook']) {
        _kidsProfileReadBookWidget.add(
          GestureDetector(
            onTap: _deviceHeight > 500
                ? () {
                    kidsStatistic.showSlideDialog(
                      context: _kidsProfileContext,
                      book: i,
                      totalTimeRead: _bookStatistic[whichKids]
                          ['book' + i.toString()]['timeMinuteReadTotal'],
                      firstExerciseScore: _bookStatistic[whichKids]
                          ['book' + i.toString()]['kidsExerciseScore'][0],
                      secondExerciseScore: _bookStatistic[whichKids]
                          ['book' + i.toString()]['kidsExerciseScore'][1],
                      thirdExerciseScore: _bookStatistic[whichKids]
                          ['book' + i.toString()]['kidsExerciseScore'][2],
                      kidsReview: _bookStatistic[whichKids]
                          ['book' + i.toString()]['kidsReview'],
                    );
                  }
                : () {
                    Navigator.of(_kidsProfileContext).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return KidsStatisticPhoneSize(
                            book: i,
                            totalTimeRead: _bookStatistic[whichKids]
                                ['book' + i.toString()]['timeMinuteReadTotal'],
                            firstExerciseScore: _bookStatistic[whichKids]
                                ['book' + i.toString()]['kidsExerciseScore'][0],
                            secondExerciseScore: _bookStatistic[whichKids]
                                ['book' + i.toString()]['kidsExerciseScore'][1],
                            thirdExerciseScore: _bookStatistic[whichKids]
                                ['book' + i.toString()]['kidsExerciseScore'][2],
                            kidsReview: _bookStatistic[whichKids]
                                ['book' + i.toString()]['kidsReview'],
                          );
                        },
                      ),
                    );
                  },
            child: Hero(
              tag: 'book',
              child: Container(
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
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
                height: deviceHeight > 500
                    ? deviceHeight * (203 / 768)
                    : deviceHeight * (250 / 495),
                width: (deviceHeight * (250 / 495)) * (1258 / 1638),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                      'assets/images/kidsProfile/book' + i.toString() + '.png'),
                ),
              ),
            ),
          ),
        );
      }
    } else {
      _kidsProfileReadBookWidget.add(Container());
    }
  }

  saveDataToSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    /* prefs.setStringList(key, value) */
    prefs.setStringList('avatar', _avatar);
    prefs.setStringList('kidsName', _kidsName);
    prefs.setStringList('kidsAge', _kidsAge);
    prefs.setStringList('displayName', _displayName);

    List<String> kidsStarListString =
        _kidsStar.map((i) => i.toString()).toList();
    prefs.setStringList('kidsStar', kidsStarListString);

    List<String> kidsContentLevelListString =
        _kidsContentLevel.map((i) => i.toString()).toList();
    prefs.setStringList('kidsContentLevel', kidsContentLevelListString);

    List<String> themeListString = _theme.map((i) => i.toString()).toList();
    prefs.setStringList('theme', themeListString);

    prefs.setBool('theme1Visibility', _theme1Visibility);
    prefs.setBool('theme2Visibility', _theme1Visibility);
    prefs.setBool('theme3Visibility', _theme1Visibility);
    prefs.setBool('theme4Visibility', _theme1Visibility);
    prefs.setBool('theme5Visibility', _theme1Visibility);

    //prefs.setInt('currentKids', _currentKids);

    String bookStatisticStringConverted = json.encode(_bookStatistic);
    // use jsonDecode(...) to convert back to map
    prefs.setString('bookStatistic', bookStatisticStringConverted);

    //check theme then change border color var accorading to theme
  }

  restoreDataFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _avatar = prefs.getStringList('avatar');
    _kidsName = prefs.getStringList('kidsName');
    _kidsAge = prefs.getStringList('kidsAge');
    _displayName = prefs.getStringList('displayName');
    _kidsStar =
        prefs.getStringList('kidsStar').map((i) => int.parse(i)).toList();
    _kidsContentLevel = prefs
        .getStringList('kidsContentLevel')
        .map((i) => int.parse(i))
        .toList();
    _theme = prefs.getStringList('theme').map((i) => int.parse(i)).toList();
    _theme1Visibility = prefs.getBool('theme1Visibility');
    _theme1Visibility = prefs.getBool('theme2Visibility');
    _theme1Visibility = prefs.getBool('theme3Visibility');
    _theme1Visibility = prefs.getBool('theme4Visibility');
    _theme1Visibility = prefs.getBool('theme5Visibility');

    _bookStatistic =
        List<Map>.from(jsonDecode(prefs.getString('bookStatistic')));
    //////////// update theme after retrive data
    chooseTheme(_theme[_currentKids]);
    print('Restore local data successfully');
  }

  ///////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////// UnityARPage Subtitle Logic
  setInputSubtitle(String subtitle) {
    _inputSubtitle = subtitle;
  }

  resetSubtitleState() {
    _inputSubtitle = 'Todd likes to eat dessert. Candy is his favourite.';
  }

  subtitleData() {
    _subtitleItems = [];
    _textSelected = [];

    // variable
    var textDisplayString = _inputSubtitle.split(" ");
    var wordCount = 0;
    var textSpeakString =
        inputSubtitle.replaceAll(new RegExp(r'(?:_|[^\w\s])+'), '').split(" ");

    // init textSelected List

    for (var i in textDisplayString) {
      _textSelected.add(false);
    }

    // Generate Widget
    for (var word in textDisplayString) {
      _subtitleItems.add(SubtitleSpeakable(
        word: word,
        //textSelectedList: provider.textSelected,
        id: wordCount,
      ));

      wordCount++;
    }
  }

  onTextSelected(int id) {
    var textDisplayString = inputSubtitle.split(" ");
    _textSelected = [];
    for (var i in textDisplayString) {
      textSelected.add(false);
    }
    textSelected[id] = true;
    
    notifyListeners();
  }

  onTextSelectedFinished(){
    var textDisplayString = inputSubtitle.split(" ");
    _textSelected = [];
    for (var i in textDisplayString) {
      textSelected.add(false);
    }
    notifyListeners();
  }

  disableTab(){
    _allowTab = false;
  }
  enableTab(){
    _allowTab = true;
  }
  //////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////

}
