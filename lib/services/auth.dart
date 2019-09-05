import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_rabbit/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../configs/api.dart';
import '../stores/user_store.dart';     // Import the user store

final userStore = UserStore();

class AuthService {
  // Config API routers
  static const Map<String, String> headers = {"Content-type": "application/json"};
  static const String _registerRoute = APIConfig.baseURL + '/register';
  static const String _loginRoute = APIConfig.baseURL + '/login';

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
}