import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

Future<void> _verifyPhoneNumber(String phoneNumber) {
  // setState(() {
  //   _message = '';
  // });
  final PhoneVerificationCompleted verificationCompleted =
      (AuthCredential phoneAuthCredential) {
    _auth.signInWithCredential(phoneAuthCredential);
    print('Received phone auth credential: $phoneAuthCredential');
    // setState(() {
    //   _message = 'Received phone auth credential: $phoneAuthCredential';
    // });
  };

  final PhoneVerificationFailed verificationFailed =
      (AuthException authException) {
      print('Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');
    // setState(() {
    //   _message =
    //       'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}';
    // });
  };

  final PhoneCodeSent codeSent =
      (String verificationId, [int forceResendingToken]) async {
    // widget._scaffold.showSnackBar(SnackBar(
    //   content:
    //       const Text('Please check your phone for the verification code.'),
    // ));
    // _verificationId = verificationId;
  };

  final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
      (String verificationId) {
    // _verificationId = verificationId;
  };

  return _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 60),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
}