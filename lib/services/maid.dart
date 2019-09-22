import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../configs/api.dart';
import '../utils/constants.dart';
import '../models/maid.dart';

class MaidService {
  static const String _getMaidRoute = APIConfig.baseURL + '/maid';
  static const String _registerMaidRoute = APIConfig.baseURL + '/maid';
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

  static Future<Map<String, dynamic>> registerHost(Maid maid) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(X_TOKEN);
    var completer = new Completer<Map<String, dynamic>>();
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json", // or whatever
      HttpHeaders.authorizationHeader: "Bearer $token",
    };
    var response = await http.post(_registerMaidRoute, headers: headers, body: jsonEncode(maid));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['errorCode'] != null) {
        completer.complete({
          'isValid': false,
          'maid': null
        });
      } else {
        final maid = data['maid'];        
        completer.complete({
          'isValid': true,
          'maid': maid
        });
      }
    } else {
      completer.complete({
        'isValid': false,
        'maid': null
      });
    }
    return completer.future;
  }

  static Future<Map<String, dynamic>> editHostInfo(Maid maid) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(X_TOKEN);
    var completer = new Completer<Map<String, dynamic>>();
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json", // or whatever
      HttpHeaders.authorizationHeader: "Bearer $token",
    };
    var response = await http.post(_editMaidRoute, headers: headers, body: jsonEncode(maid));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['errorCode'] != null) {
        completer.complete({
          'isValid': false,
          'maid': null
        });
      } else {
        final maid = data['maid'];        
        completer.complete({
          'isValid': true,
          'maid': maid
        });
      }
    } else {
      completer.complete({
        'isValid': false,
        'maid': null
      });
    }
    return completer.future;
  }

}
