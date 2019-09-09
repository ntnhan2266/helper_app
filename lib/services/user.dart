import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../configs/api.dart';

class UserService {
  static const String _getUserRoute = APIConfig.baseURL + '/auth/me';

  static Future<Map<String, dynamic>> getUser(String token) async {
    var completer = new Completer<Map<String, dynamic>>();
    print(token);
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json", // or whatever
      HttpHeaders.authorizationHeader: "Bearer $token",
    };
    var response = await http.get(_getUserRoute, headers: headers);
    final data = jsonDecode(response.body);
    final user = data['user'];
    if (user != null) {
      completer.complete({
        'user': user,
        'isValid': true
      });
    } else {
      completer.complete({
        'user': null,
        'isValid': false
      });
    }
    return completer.future;
  }
}
