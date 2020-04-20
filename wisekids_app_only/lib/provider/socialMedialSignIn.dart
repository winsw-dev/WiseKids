import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class UserAuthentication extends ChangeNotifier {
  FirebaseAuth _auth;
  FirebaseUser _user;
  Status _status = Status.Uninitialized;

  UserAuthentication.instance() : _auth = FirebaseAuth.instance {
    _auth.onAuthStateChanged.listen(_onAuthStateChanged);
  }

  Status get status => _status;
  FirebaseUser get user => _user;

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

      if (googleSignInAccount != null) {
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

        assert(!googleUser.isAnonymous);
        assert(await googleUser.getIdToken() != null);

        final FirebaseUser currentUser = await _auth.currentUser();
        assert(googleUser.uid == currentUser.uid);

        ///// add user data to firestore database
        await Firestore.instance
            .collection('WiseKidsUser')
            .document(currentUser.uid)
            .setData({
          "uid": currentUser.uid,
          'name': name,
          'email': email,
          'signInWith': 'Google',
          "acceptedConsent": false
        });
      }
      return true;
      //final FirebaseUser user = authResult.user;

    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  void signOutGoogle() async {
    await googleSignIn.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    print("Google Sign Out");
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
          //print(profile.toString());
          final FirebaseUser currentUser = await _auth.currentUser();
          await Firestore.instance
              .collection('WiseKidsUser')
              .document(currentUser.uid)
              .setData({
            "uid": currentUser.uid,
            'name': profile['name'],
            'email': profile['email'],
            'signInWith': 'Facebook',
            "acceptedConsent": false
          });
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
    await facebookLogin.logOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    print("facebook Logged out");
  }
}
