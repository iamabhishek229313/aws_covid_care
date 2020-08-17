import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class Authentication {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  // To Sign In with email and password.
  Future<FirebaseUser> handleSignInEmail(String userid, String password) async {
    print(userid);
    print(password);
    AuthResult result;
    try {
      result = await _firebaseAuth.signInWithEmailAndPassword(email: userid, password: password);
    } on PlatformException catch (e) {
      print(e);
    }
    final FirebaseUser user = result.user;

    assert(user != null);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _firebaseAuth.currentUser();
    assert(user.uid == currentUser.uid);

    log('signInEmail succeeded: $user');

    return user;
  }

  // To Sign up with email and Password.
  Future<FirebaseUser> handleSignUp(String userid, String password) async {
    print(userid);
    print(password);
    AuthResult result;

    try {
      result = await _firebaseAuth.createUserWithEmailAndPassword(email: userid, password: password);
    } catch (e) {
      print(e);
    }

    final FirebaseUser user = result.user;

    assert(user != null);
    assert(await user.getIdToken() != null);

    return user;
  }

  // Sign out from Fireabase.
  handleSignOut() async {
    if (_firebaseAuth.currentUser() != null) {
      await _firebaseAuth.signOut().then((value) {
        log("User is Signed out");
      }).catchError((e) => print(e));
    } else if (_firebaseAuth.currentUser() == null) {
      log("User is not there.");
    }
  }
}
