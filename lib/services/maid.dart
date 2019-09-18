import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../configs/api.dart';
import '../utils/constants.dart';

class MaidService {
  static const String _getMaidRoute = APIConfig.baseURL + '/maid';
  static const String _editMaidRoute = APIConfig.baseURL + '/maid/edit';

  static Future<Map<String, dynamic>> getMaid() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(X_TOKEN);
    var completer = new Completer<Map<String, dynamic>>();
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json", // or whatever
      HttpHeaders.authorizationHeader: "Bearer $token",
    };
    var response = await http.get(_getMaidRoute, headers: headers);
    final data = jsonDecode(response.body);
    final maid = data['maid'];
    if (maid != null) {
      completer.complete({
        'maid': maid,
        'isHost': true
      });
    } else {
      completer.complete({
        'maid': null,
        'isHost': false
      });
    }
    return completer.future;
  }
}
