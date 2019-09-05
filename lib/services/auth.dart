import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:smart_rabbit/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

import '../configs/api.dart';
import '../stores/user_store.dart';     // Import the user store

final userStore = UserStore();
final FirebaseAuth _auth = FirebaseAuth.instance;

class AuthService {
  // Config API routers
  static const Map<String, String> headers = {"Content-type": "application/json"};
  static const String _registerRoute = APIConfig.baseURL + '/register';
  static const String _loginRoute = APIConfig.baseURL + '/login';
  static const String _loginWithFbRoute = APIConfig.baseURL + '/login-with-fb';

  static Future<dynamic> register({token, phoneNumber, email, name}) async {
    Map<String, String> body = {
      'token': token,
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email
    };
    var response = await http.post(_registerRoute, headers: headers, body: jsonEncode(body));
    var completer = new Completer();
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['errorCode'] != null) {
        completer.complete(data['errorCode']);
      } else {
        final user = data['user'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString(USER_ID, user['_id']);
        await prefs.setString(X_TOKEN, data['token']);
        completer.complete(NO_ERROR);
      }
    }
    return completer.future;
  }

  static Future<dynamic> login({token, phoneNumber}) async {
    Map<String, String> body = {
      'token': token
    };
    var response = await http.post(_loginRoute, headers: headers, body: jsonEncode(body));
    var completer = new Completer();
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['errorCode'] != null) {
        completer.complete(data['errorCode']);
      } else {
        final user = data['user'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString(USER_ID, user['_id']);
        await prefs.setString(X_TOKEN, data['token']);
        completer.complete(NO_ERROR);
      }
    }
    return completer.future;
  }

  static Future<dynamic> loginWithFacebook() async {
    var completer = new Completer();
    final facebookLogin = FacebookLogin();
    final result = await facebookLogin.logInWithReadPermissions(['email', 'public_profile']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        // _sendTokenToServer(result.accessToken.token);
        // _showLoggedInUI();
        // Create user with access token
        final AuthCredential credential = FacebookAuthProvider.getCredential(
          accessToken: result.accessToken.token
        );
        final FirebaseUser user =
            (await _auth.signInWithCredential(credential)).user;
        final FirebaseUser currentUser = await _auth.currentUser();
        assert(user.uid == currentUser.uid);
        if (user != null) {
          // _message = 'Successfully signed in with Facebook. ' + user.uid;
          final IdTokenResult idTokenResult = await currentUser.getIdToken();
          final token = idTokenResult.token;
          final graphResponse = await http.get(
            'https://graph.facebook.com/v4.0/me?fields=name,email&access_token=${result.accessToken.token}');
          final profile = jsonDecode(graphResponse.body);
          Map<String, String> body = {
            'token': token,
            'name': profile['name'],
            'email': profile['email']
          };
          // Send token. and data fetch from FB to API
          var response = await http.post(_loginWithFbRoute, headers: headers, body: jsonEncode(body));
          if (response.statusCode == 200) {
            final data = jsonDecode(response.body);
            if (data['errorCode'] != null) {
              completer.complete(data['errorCode']);
            } else {
              final user = data['user'];
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setString(USER_ID, user['_id']);
              await prefs.setString(X_TOKEN, data['token']);
              completer.complete(NO_ERROR);
            }
          }
        }
        break;
      case FacebookLoginStatus.cancelledByUser:
        completer.complete(FB_LOGIN_FAILED);
        print('Cancel message');
        break;
      case FacebookLoginStatus.error:
        completer.complete(FB_LOGIN_FAILED);
        print('Error');
        break;
    }
    return completer.future;
  }
}