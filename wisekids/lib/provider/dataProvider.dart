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
import '../provider/audioProvider.dart';
import '../provider/ttsProvider.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class DataProvider extends ChangeNotifier {
  /// Internal, private state
  int _displayNameLength = 10;
  int _kidsLimit = 4;
  BuildContext _parentalKidsCenterContext;
  BuildContext _selectKidsPopupContext;
  BuildContext _kidsProfileContext;
  BuildContext _unityArBookContext;
  double _deviceHeight;
  double _deviceWidth;

  /// use to create function showAddKids Dialog that required context in provider
  //////////////////

  String _parentAreaLanguage = "TH";
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
  ///////////////// TTS
  bool _ttsSwitch = true;

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
  List<int> _kidsReadingTime = [0];

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

  ////////////////// Edit Kids Profile
  String _cacheEditKidsProfileAvatar;
  int _cacheEditKidsProfileTheme;
  bool _cacheEditKidsTheme1Visibility;
  bool _cacheEditKidsTheme2Visibility;
  bool _cacheEditKidsTheme3Visibility;
  bool _cacheEditKidsTheme4Visibility;
  bool _cacheEditKidsTheme5Visibility;

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
  bool _arMode = true;
  bool _disableSpeakWhenSwitchMode = true;

  ///////////////// An unmodifiable view
  bool get disableSpeakWhenSwitchMode => _disableSpeakWhenSwitchMode;
  bool get ttsSwitch => _ttsSwitch;
  bool get arMode => _arMode;
  String get parentAreaLanguage => _parentAreaLanguage;
  double get deviceHeight => _deviceHeight;
  double get deviceWidth => _deviceWidth;
  BuildContext get kidsProfileContext => _kidsProfileContext;
  BuildContext get unityArBookContext => _unityArBookContext;
  List<Widget> get kidsProfileReadBookWidget => _kidsProfileReadBookWidget;
  BuildContext get selectKidsPopupContext => _selectKidsPopupContext;
  List<Widget> get selectKidsPopupWidget => _selectKidsPopupWidget;
  BuildContext get parentalKidsCenterContext => _parentalKidsCenterContext;
  List<Widget> get kidsProfileWidget => _kidsProfileWidget;
  List<int> get kidsContentLevel => _kidsContentLevel;
  List<Map> get bookStatistic => _bookStatistic;
  int get appOpen => _appOpen;
  List<int> get kidsReadingTime => _kidsReadingTime;
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

  ///////////////////// Edit & delete Kids unmodifiable view + function

  String get cacheEditKidsProfileAvatar => _cacheEditKidsProfileAvatar;
  int get cacheEditKidsProfileTheme => _cacheEditKidsProfileTheme;

  bool get cacheEditKidsTheme1Visibility => _cacheEditKidsTheme1Visibility;
  bool get cacheEditKidsTheme2Visibility => _cacheEditKidsTheme2Visibility;
  bool get cacheEditKidsTheme3Visibility => _cacheEditKidsTheme3Visibility;
  bool get cacheEditKidsTheme4Visibility => _cacheEditKidsTheme4Visibility;
  bool get cacheEditKidsTheme5Visibility => _cacheEditKidsTheme5Visibility;

  deleteKidsProfile(int whichKids) async {
    _kidsName.removeAt(whichKids);
    _displayName.removeAt(whichKids);
    _kidsAge.removeAt(whichKids);
    _kidsContentLevel.removeAt(whichKids);
    _kidsStar.removeAt(whichKids);
    _avatar.removeAt(whichKids);
    _theme.removeAt(whichKids);
    _bookStatistic.removeAt(whichKids);
    _kidsReadingTime.removeAt(whichKids);
    _currentKids = 0;

    notifyListeners();
    /////////////////////////////////// update data to database
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
        'kidsReadingTime': _kidsReadingTime,
      }, /* merge: true */
    );

    !bool.fromEnvironment("dart.vm.product")
        ? print('Remove kids Profile successfully')
        : null;
    kidsProfileWidgetBuilder();
  }

  saveEditKidsProfile({
    int whichKids,
    String kidsAgeInput,
    String kidsAvatarInput,
    String kidsNameInput,
    int kidsThemeInput,
  }) async {
    print('save edited data');
    /////////////////////////////////// edit kid data in local provider
    _kidsName[whichKids] = kidsNameInput;
    _displayName[whichKids] = kidsNameInput;
    _kidsAge[whichKids] = kidsAgeInput;
    _avatar[whichKids] = kidsAvatarInput;
    _theme[whichKids] = kidsThemeInput;

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
      }, /* merge: true */
    );
    kidsProfileWidgetBuilder();
    !bool.fromEnvironment("dart.vm.product")
        ? print('edit kids: "$kidsNameInput" successfully')
        : null;
  }

  chooseThemeEditKidsProfile(int theme) {
    _cacheEditKidsProfileTheme = theme;
    if (theme == 1) {
      _cacheEditKidsTheme1Visibility = true;
      _cacheEditKidsTheme2Visibility = false;
      _cacheEditKidsTheme3Visibility = false;
      _cacheEditKidsTheme4Visibility = false;
      _cacheEditKidsTheme5Visibility = false;
    } else if (theme == 2) {
      _cacheEditKidsTheme1Visibility = false;
      _cacheEditKidsTheme2Visibility = true;
      _cacheEditKidsTheme3Visibility = false;
      _cacheEditKidsTheme4Visibility = false;
      _cacheEditKidsTheme5Visibility = false;
    } else if (theme == 3) {
      _cacheEditKidsTheme1Visibility = false;
      _cacheEditKidsTheme2Visibility = false;
      _cacheEditKidsTheme3Visibility = true;
      _cacheEditKidsTheme4Visibility = false;
      _cacheEditKidsTheme5Visibility = false;
    } else if (theme == 4) {
      _cacheEditKidsTheme1Visibility = false;
      _cacheEditKidsTheme2Visibility = false;
      _cacheEditKidsTheme3Visibility = false;
      _cacheEditKidsTheme4Visibility = true;
      _cacheEditKidsTheme5Visibility = false;
    } else if (theme == 5) {
      _cacheEditKidsTheme1Visibility = false;
      _cacheEditKidsTheme2Visibility = false;
      _cacheEditKidsTheme3Visibility = false;
      _cacheEditKidsTheme4Visibility = false;
      _cacheEditKidsTheme5Visibility = true;
    }
    notifyListeners();
  }

  initEditKidsProfileCacheVar(int whichKids) {
    _cacheEditKidsProfileAvatar = _avatar[whichKids];
    _cacheEditKidsProfileTheme = _theme[whichKids];

    if (_theme[whichKids] == 1) {
      _cacheEditKidsTheme1Visibility = true;
      _cacheEditKidsTheme2Visibility = false;
      _cacheEditKidsTheme3Visibility = false;
      _cacheEditKidsTheme4Visibility = false;
      _cacheEditKidsTheme5Visibility = false;
    } else if (_theme[whichKids] == 2) {
      _cacheEditKidsTheme1Visibility = false;
      _cacheEditKidsTheme2Visibility = true;
      _cacheEditKidsTheme3Visibility = false;
      _cacheEditKidsTheme4Visibility = false;
      _cacheEditKidsTheme5Visibility = false;
    } else if (_theme[whichKids] == 3) {
      _cacheEditKidsTheme1Visibility = false;
      _cacheEditKidsTheme2Visibility = false;
      _cacheEditKidsTheme3Visibility = true;
      _cacheEditKidsTheme4Visibility = false;
      _cacheEditKidsTheme5Visibility = false;
    } else if (_theme[whichKids] == 4) {
      _cacheEditKidsTheme1Visibility = false;
      _cacheEditKidsTheme2Visibility = false;
      _cacheEditKidsTheme3Visibility = false;
      _cacheEditKidsTheme4Visibility = true;
      _cacheEditKidsTheme5Visibility = false;
    } else if (_theme[whichKids] == 5) {
      _cacheEditKidsTheme1Visibility = false;
      _cacheEditKidsTheme2Visibility = false;
      _cacheEditKidsTheme3Visibility = false;
      _cacheEditKidsTheme4Visibility = false;
      _cacheEditKidsTheme5Visibility = true;
    }

    notifyListeners();
  }

  selectAvatarSwiperIndexEditKids(String avatar) {
    if (avatar == 'boy') {
      return 0;
    } else if (avatar == 'girl') {
      return 1;
    } else if (avatar == 'cat') {
      return 2;
    }
  }

  editProfileAvatar(int whichKid, int avatarIndex) {
    if (avatarIndex == 0) {
      _cacheEditKidsProfileAvatar = 'boy';
    } else if (avatarIndex == 1) {
      _cacheEditKidsProfileAvatar = 'girl';
    } else if (avatarIndex == 2) {
      _cacheEditKidsProfileAvatar = 'cat';
    }
    notifyListeners();
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
      popUpMode: 'createProfile',
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
            Provider.of<AudioProvider>(_parentalKidsCenterContext,
                    listen: false)
                .playSoundEffect("select", 1.0);
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
            child:
                /* Hero(
              tag: i.toString() + 'Profile',
              child: */
                Material(
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
            /* ), */
          ),
        ),
      );
    }
    _kidsProfileWidget
        .add(///////////////////////////////////// Add more kids Btn
            _avatar.length < _kidsLimit
                ? GestureDetector(
                    onTap: () {
                      Provider.of<AudioProvider>(_parentalKidsCenterContext,
                              listen: false)
                          .playSoundEffect("select", 1.0);
                      _showAddMoreKisDialog();
                    },
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
    _displayName.add(kidsNameInput);
    _kidsAge.add(kidsAgeInput);
    _kidsContentLevel.add(1);
    _kidsStar.add(0);
    _avatar.add(kidsAvatarInput);
    _theme.add(kidsThemeInput);
    _bookStatistic.add({'readBook': []});
    _kidsReadingTime.add(0);
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
        'kidsReadingTime': _kidsReadingTime,
      }, /* merge: true */
    );

    !bool.fromEnvironment("dart.vm.product")
        ? print('add kid "$kidsNameInput" successfully')
        : null;
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
          'kidsReadingTime': _kidsReadingTime,
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
              'kidsReadingTime': _kidsReadingTime,
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
    _kidsReadingTime = List<int>.from(userData['kidsReadingTime']);
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

    ///////////// compare timeStamp data if readTime is in the same day so, we can use this as [Reading Time Today]
    ///if not in the same day then reset readTime
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('readedTime_TimeStamp') != null) {
      if (DateTime.now()
              .difference(
                  DateTime.parse(prefs.getString('readedTime_TimeStamp')))
              .inDays >
          0) {
        for (var i in _kidsReadingTime) {
          _kidsReadingTime[i] = 0;
        }
      } else {
        ///////// restore reading time today
        _kidsReadingTime =
            prefs.getStringList('readingTime').map(int.parse).toList();
      }
    }

    //print(_bookStatistic);

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
    !bool.fromEnvironment("dart.vm.product")
        ? print(
            '\n----------Restored user data----------\nAccount name == $_userName\nKids in this profile == $_kidsName\nBookStatistic == $_bookStatistic')
        : null;

    print('\n--------------------------------------\n\n');
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
    _kidsReadingTime = [0];
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
              Provider.of<AudioProvider>(context, listen: false)
                  .playSoundEffect("click3", 1.0);
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
              Navigator.pop(context);
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
          Provider.of<AudioProvider>(context, listen: false)
              .playSoundEffect("select", 1.0);

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

    if (_bookStatistic[whichKids]['readBook'].length != 0) {
      print('pass');
      print('whichKids==' + whichKids.toString());
      for (var i in _bookStatistic[whichKids]['readBook']) {
        _kidsProfileReadBookWidget.add(
          GestureDetector(
            onTap: _deviceHeight > 500
                ? () {
                    Provider.of<AudioProvider>(_kidsProfileContext,
                            listen: false)
                        .playSoundEffect("select", 1.0);
                    kidsStatistic.showSlideDialog(
                      context: _kidsProfileContext,
                      book: i,
                      totalTimeRead: _bookStatistic[whichKids]
                              [/* 'book' + */ i.toString()]
                          ['timeMinuteReadTotal'] /* [whichKids] */,
                      ///////////////////////////////////////////////// order score by lasted => oldest (1=>3 button in kidsStatistic)
                      firstExerciseScore: _bookStatistic[whichKids]
                              [/* 'book' +  */ i.toString()]
                          ['kidsExerciseScore'][2],
                      secondExerciseScore: _bookStatistic[whichKids]
                          [/* 'book' + */ i.toString()]['kidsExerciseScore'][1],
                      thirdExerciseScore: _bookStatistic[whichKids]
                          [/* 'book' + */ i.toString()]['kidsExerciseScore'][0],
                      kidsReview: _bookStatistic[whichKids]
                          [/* 'book' + */ i.toString()]['kidsReview'],
                    );
                  }
                : () {
                    Provider.of<AudioProvider>(_kidsProfileContext,
                            listen: false)
                        .playSoundEffect("select", 1.0);
                    Navigator.of(_kidsProfileContext).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return KidsStatisticPhoneSize(
                            book: i,
                            totalTimeRead: _bookStatistic[whichKids]
                                    [/* 'book' + */ i.toString()]
                                ['timeMinuteReadTotal'] /* [whichKids] */,
                            firstExerciseScore: _bookStatistic[whichKids]
                                    [/* 'book' + */ i.toString()]
                                ['kidsExerciseScore'][0],
                            secondExerciseScore: _bookStatistic[whichKids]
                                    [/* 'book' + */ i.toString()]
                                ['kidsExerciseScore'][1],
                            thirdExerciseScore: _bookStatistic[whichKids]
                                    [/* 'book' + */ i.toString()]
                                ['kidsExerciseScore'][2],
                            kidsReview: _bookStatistic[whichKids]
                                [/* 'book' + */ i.toString()]['kidsReview'],
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
                //width: (deviceHeight * (250 / 495)) * (1258 / 1638),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                      'assets/images/kidsProfile/' + i.toString() + '.png'),
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

    List<String> readingTimeListString =
        _kidsReadingTime.map((i) => i.toString()).toList();
    prefs.setStringList('readingTime', readingTimeListString);

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
    _kidsReadingTime =
        prefs.getStringList('readingTime').map((i) => int.parse(i)).toList();
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

    ///////////// compare timeStamp data if readTime is in the same day so, we can use this as [Reading Time Today]
    ///if not in the same day then reset readTime

    if (prefs.getString('readedTime_TimeStamp') != null) {
      if (DateTime.now()
              .difference(
                  DateTime.parse(prefs.getString('readedTime_TimeStamp')))
              .inDays >
          0) {
        for (var i in _kidsReadingTime) {
          _kidsReadingTime[i] = 0;
        }
      } else {
        ///////// restore reading time today
        _kidsReadingTime =
            prefs.getStringList('readingTime').map(int.parse).toList();
      }
    }
    print('readedTime_Today == ' + _kidsReadingTime.toString());
    print('Restore local data successfully');
  }

  ///////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////

  getUnityARBookContext(BuildContext context) {
    _unityArBookContext = context;
  }

  //////////////////////////////////////////////////////////////////////
  disableSpeakWhenSwitchModeFunc() {
    _disableSpeakWhenSwitchMode = false;
    notifyListeners();
  }

  enableSpeakWhenSwitchModeFunc() {
    _disableSpeakWhenSwitchMode = true;
    notifyListeners();
  }

  //////////////////////////////////////////// UnityARPage Subtitle Logic
  setInputSubtitle(String subtitle, bool speak) {
    _inputSubtitle = subtitle;
    if (_ttsSwitch) {
      if (speak) {
        if (_disableSpeakWhenSwitchMode) {
          Future.delayed(const Duration(milliseconds: 100), () {
            Provider.of<TTSProvider>(_unityArBookContext, listen: false)
                .speak(subtitle);
          });
        }
      }
    }
  }

  speakAfterPlayInteractive() {
    String kids = _kidsName[_currentKids];
    if (_kidsContentLevel[_currentKids] == 1) {
      if (_avatar[_currentKids] == "girl") {
        Provider.of<TTSProvider>(_unityArBookContext, listen: false)
            .speak('Ten candy monsters left, but her teeth decayed.');
      } else {
        Provider.of<TTSProvider>(_unityArBookContext, listen: false)
            .speak('Ten candy monsters left, but his teeth decayed.');
      }
    } else if (_kidsContentLevel[_currentKids] == 2) {
      Provider.of<TTSProvider>(_unityArBookContext, listen: false)
          .speak('There were ten candy monsters in $kids\'s mouth.');
    } else if (_kidsContentLevel[_currentKids] == 3) {
      Provider.of<TTSProvider>(_unityArBookContext, listen: false)
          .speak('There are ten candy monsters in $kids\'s mouth.');
    } else if (_kidsContentLevel[_currentKids] == 4) {
      Provider.of<TTSProvider>(_unityArBookContext, listen: false).speak(
          '$kids found that there were ten candy monsters in $kids\'s mouth.');
    }
  }

  void toggleArMode() {
    _arMode = !arMode;
    notifyListeners();
  }

  void resetToArMode() {
    _arMode = true;
    notifyListeners();
  }

  void toggleTtsSwitch() {
    _ttsSwitch = !_ttsSwitch;
    notifyListeners();
  }

  resetSubtitleState() {
    String _name = _kidsName[_currentKids].capitalize();
    if (avatar[currentKids] == 'girl') {
      if (kidsContentLevel[currentKids] == 1) {
        _inputSubtitle = '$_name ate candy every day.';
        /* if (_ttsSwitch) {
          Future.delayed(const Duration(milliseconds: 500), () {
            Provider.of<TTSProvider>(_unityArBookContext, listen: false)
                .speak('$_name ate candy every day.');
          });
        } */
      } else if (kidsContentLevel[currentKids] == 2) {
        _inputSubtitle = '$_name likes to eat dessert everyday.';
        /* if (_ttsSwitch) {
          Future.delayed(const Duration(milliseconds: 500), () {
            Provider.of<TTSProvider>(_unityArBookContext, listen: false)
                .speak('$_name likes to eat dessert everyday.');
          });
        } */
      } else if (kidsContentLevel[currentKids] == 3) {
        _inputSubtitle =
            '$_name likes to eat dessert everyday. Candy was her favourite.';
        /*  if (_ttsSwitch) {
          Future.delayed(const Duration(milliseconds: 500), () {
            Provider.of<TTSProvider>(_unityArBookContext, listen: false).speak(
                '$_name likes to eat dessert everyday. Candy was her favourite.');
          });
        } */
      } else if (kidsContentLevel[currentKids] == 4) {
        _inputSubtitle =
            'There was a little girl named $_name, she likes to eat dessert everyday. Candy was one of her favourites.';
        /* if (_ttsSwitch) {
          Future.delayed(const Duration(milliseconds: 500), () {
            Provider.of<TTSProvider>(_unityArBookContext, listen: false).speak(
                'There was a little girl named $_name, she likes to eat dessert everyday. Candy was one of her favourites.');
          });
        } */
      }
    } else {
      if (kidsContentLevel[currentKids] == 1) {
        _inputSubtitle = '$_name ate candy every day.';
        /*  if (_ttsSwitch) {
          Future.delayed(const Duration(milliseconds: 500), () {
            Provider.of<TTSProvider>(_unityArBookContext, listen: false)
                .speak('$_name ate candy every day.');
          });
        } */
      } else if (kidsContentLevel[currentKids] == 2) {
        _inputSubtitle = '$_name likes to eat dessert everyday.';
        /* if (_ttsSwitch) {
          Future.delayed(const Duration(milliseconds: 500), () {
            Provider.of<TTSProvider>(_unityArBookContext, listen: false)
                .speak('$_name likes to eat dessert everyday.');
          });
        } */
      } else if (kidsContentLevel[currentKids] == 3) {
        _inputSubtitle =
            '$_name likes to eat dessert everyday. Candy was his favourite.';
        /*  if (_ttsSwitch) {
          Future.delayed(const Duration(milliseconds: 500), () {
            Provider.of<TTSProvider>(_unityArBookContext, listen: false).speak(
                '$_name likes to eat dessert everyday. Candy was his favourite.');
          });
        } */
      } else if (kidsContentLevel[currentKids] == 4) {
        _inputSubtitle =
            'There was a little boy named $_name, he likes to eat dessert everyday. Candy was one of his favourites.';
        /* if (_ttsSwitch) {
          Future.delayed(const Duration(milliseconds: 500), () {
            Provider.of<TTSProvider>(_unityArBookContext, listen: false).speak(
                'There was a little boy named $_name, he likes to eat dessert everyday. Candy was one of his favourites.');
          });
        } */
      }
    }
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
        word: word, borderMode: _arMode ? false : true,
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

  onTextSelectedFinished() {
    var textDisplayString = inputSubtitle.split(" ");
    _textSelected = [];
    for (var i in textDisplayString) {
      textSelected.add(false);
    }
    notifyListeners();
  }

  disableTab() {
    _allowTab = false;
  }

  enableTab() {
    _allowTab = true;
  }

  ///////////////////////////////////////////////////
  ///////////////////////////////////////////////////

  /////////////////////////////////////////////////// finishedReading function
  /// 1.) add star locally
  /// 2.) add bookStatistic {readtime, vocabSticker, amountRead} locally
  /// 3.) add firstExercise Score (arInteractive)
  /// 4.) save data to sharePreferenced
  /// 5.) save data to database
  /// [note : use _kidsReadingTime as reading Time today]
  finishedReading(int timeReadSecond, String whichBook) async {
    print('kidsReadingTime' + _kidsReadingTime.toString());

    //////// update local reading time
    _kidsReadingTime[_currentKids] += (timeReadSecond / 60).round();

    notifyListeners();

    ////// check if bookStatistic have data, update and push data
    if (_bookStatistic[_currentKids]['readBook'].length > 0) {
      // update time in _bookStatistic
      _bookStatistic[_currentKids][whichBook]['timeMinuteReadTotal'] +=
          (timeReadSecond / 60).round();

      // update amount read
      _bookStatistic[_currentKids][whichBook]['amountRead'] += 1;

      // add(Replace) lasted firstExerciseScore and step back the other score 1 index

      int _lastedTimeDonefirstExerciseScore = _bookStatistic[_currentKids]
          [whichBook]['kidsExerciseScore'][0]['firstExercise'];
      int _oldTimeDonefirstExerciseScore = _bookStatistic[_currentKids]
          [whichBook]['kidsExerciseScore'][1]['firstExercise'];
      int _oldestTimeDonefirstExerciseScore = _bookStatistic[_currentKids]
          [whichBook]['kidsExerciseScore'][2]['firstExercise'];
      _bookStatistic[_currentKids][whichBook]['kidsExerciseScore'][0]
          ['firstExercise'] = 10;
      _bookStatistic[_currentKids][whichBook]['kidsExerciseScore'][1]
          ['firstExercise'] = _lastedTimeDonefirstExerciseScore;
      _bookStatistic[_currentKids][whichBook]['kidsExerciseScore'][2]
          ['firstExercise'] = _oldTimeDonefirstExerciseScore;
    }
    ////// check if bookStatistic doesn't have data yet then create new one
    else {
      _bookStatistic[_currentKids] = {
        whichBook: {
          'amountRead': 1,
          'amountDoneExcercise': 0,
          'kidsExerciseScore': [
            {'firstExercise': 10, 'secondExercise': 0},
            {'firstExercise': 0, 'secondExercise': 0},
            {'firstExercise': 0, 'secondExercise': 0}
          ],
          'kidsReview': '',
          // add all sticker after finish reading monster candy
          'kidsStickerCollection': [
            'candy',
            'mirror',
            'toothBrush',
            'tooth',
            'monster'
          ],
          'timeMinuteReadTotal': _kidsReadingTime[_currentKids]
        },
        'readBook': [whichBook]
      };

      //////////////////////// add reward star to currentkids for finished reading first time
      _kidsStar[_currentKids] += 3;
    }
    ////// save data to local device
    saveDataToSharedPreferences();

    /// create timestamp to compare when restore local data if readed time data
    /// is in the same day *** use this to make time read today feature
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('readedTime_TimeStamp', DateTime.now().toIso8601String());

    /////  save data to database if user logged in
    if (_status == Status.Authenticated) {
      final FirebaseUser currentUser = await _auth.currentUser();
      await Firestore.instance
          .collection('WiseKidsUser')
          .document(currentUser.uid)
          .updateData(
        {
          'bookStatistic': _bookStatistic,
          'kidsStar': _kidsStar,
        }, /* merge: true */
      );
    }
    print('finished reading press');
  }

  //////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////
  ///
  ///////////////////////////////////// function to select ContentLevel and update local and push todatabase
  chooseContentLevel(int level) {
    _kidsContentLevel[_currentKids] = level;
    notifyListeners();
    saveDataToSharedPreferences();

    FirebaseAuth.instance.currentUser().then((currentUser) => {
          if (currentUser != null)
            {
              Firestore.instance
                  .collection('WiseKidsUser')
                  .document(currentUser.uid)
                  .setData({'kidsContentLevel': _kidsContentLevel}, merge: true)
            }
        });
  }
  /////////////////////////////////////////////////// finished play function
  /// 1.) add star locally
  /// 2.) add bookStatistic {lasted ExerciseScore} locally then remove the last one of the array
  /// 3.) save data to sharePreferenced
  /// 4.) save data to database

  finishedPlay() async {
    //////////////////////// add reward star to currentkids
    if (_bookStatistic[_currentKids]['book1']['amountDoneExcercise'] != 0) {
    }
    ///////// add star only if done Exercise at the first time
    else {
      _kidsStar[_currentKids] += 3;
    }

    // increase amountDoneExcercise
    _bookStatistic[_currentKids]['book1']['amountDoneExcercise'] += 1;

    print('finished 2nd Exercise for : ' +
        _bookStatistic[_currentKids]['book1']['amountDoneExcercise']
            .toString() +
        ' time');

    notifyListeners();

    // add(Replace) lasted firstScore of Exercise and step back the other score 1 index

    int _lastedTimeDonefirstExerciseScore = _bookStatistic[_currentKids]
        ['book1']['kidsExerciseScore'][0]['secondExercise'];
    int _oldTimeDonefirstExerciseScore = _bookStatistic[_currentKids]['book1']
        ['kidsExerciseScore'][1]['secondExercise'];
    int _oldestTimeDonefirstExerciseScore = _bookStatistic[_currentKids]
        ['book1']['kidsExerciseScore'][2]['secondExercise'];
    _bookStatistic[_currentKids]['book1']['kidsExerciseScore'][0]
        ['secondExercise'] = 10;
    _bookStatistic[_currentKids]['book1']['kidsExerciseScore'][1]
        ['secondExercise'] = _lastedTimeDonefirstExerciseScore;
    _bookStatistic[_currentKids]['book1']['kidsExerciseScore'][2]
        ['secondExercise'] = _oldTimeDonefirstExerciseScore;

    ////// save data to local device
    saveDataToSharedPreferences();

    /////  save data to database if user logged in
    if (_status == Status.Authenticated) {
      final FirebaseUser currentUser = await _auth.currentUser();
      await Firestore.instance
          .collection('WiseKidsUser')
          .document(currentUser.uid)
          .updateData(
        {
          'bookStatistic': _bookStatistic,
          'kidsStar': _kidsStar,
        }, /* merge: true */
      );
    }
    print('finished reading press');
  }

  //////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////

}
