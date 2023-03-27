import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuth {
  static final _googleSignIn = GoogleSignIn(scopes: [
    "https://www.googleapis.com/auth/userinfo.email",
    "https://www.googleapis.com/auth/userinfo.profile"
  ]);

  static Future<Map<String, dynamic>> signIn(BuildContext context) async {
    try {
      if (await _googleSignIn.isSignedIn()) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Already Signed In')));
        return <String, dynamic>{};
      }

      final _userData = await _googleSignIn.signIn();

      if (_userData == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Google Signin Failed as user data not found')));
        return <String, dynamic>{};
      }

      final _authData = await _userData.authentication;

      final _authCred = GoogleAuthProvider.credential(
        idToken: _authData.idToken,
        accessToken: _authData.accessToken,
      );

      final UserCredential _userCred =
          await FirebaseAuth.instance.signInWithCredential(_authCred);

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Google Signin Successful')));

      return <String, dynamic>{
        'name': _userCred.user?.displayName ?? '',
        'email': _userCred.user?.email ?? '',
        'profile_pic': _userCred.user?.photoURL ?? '',
      };
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error in Google sign in: $e')));

      return <String, dynamic>{};
    }
  }

  static logout(BuildContext context) async {
    try {
      await _googleSignIn.disconnect();
      await _googleSignIn.signOut();
      await FirebaseAuth.instance.signOut();

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Google Logout Successful')));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Google Logout Error: $e')));
    }
  }
}
