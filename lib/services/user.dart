import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../configs/api.dart';
import '../models/user.dart';
import '../utils/constants.dart';

class UserService {
  static const String _getUserRoute = APIConfig.baseURL + '/auth/me';
  static const String _editUserRoute = APIConfig.baseURL + '/user/edit';

  static Future<Map<String, dynamic>> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(X_TOKEN);
    var completer = new Completer<Map<String, dynamic>>();
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json", // or whatever
      HttpHeaders.authorizationHeader: "Bearer $token",
    };
    
    try {
      var response = await http.get(_getUserRoute, headers: headers);
      final data = jsonDecode(response.body);
      final user = data['user'];
      if (user != null) {
        completer.complete({'user': user, 'isHost': data['isHost'], 'isValid': true});
      } else {
        completer.complete({'user': null, 'isHost': false, 'isValid': false});
      }
    } catch (e) {
      completer.complete({'user': null, 'isHost': false, 'isValid': false});
    }

    return completer.future;
  }

  static Future<Map<String, dynamic>> editUser(User data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(X_TOKEN);
    var completer = new Completer<Map<String, dynamic>>();
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json", // or whatever
      HttpHeaders.authorizationHeader: "Bearer $token",
    };
    var response = await http.post(_editUserRoute,
        headers: headers, body: jsonEncode(data));
    final body = jsonDecode(response.body);
    final user = body['user'];
    if (user != null) {
      completer.complete({'user': user, 'isValid': true});
    } else {
      completer.complete({'user': null, 'isValid': false});
    }
    return completer.future;
  }
}
