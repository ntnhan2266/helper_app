import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../configs/api.dart';
import './api.dart';

class SettingService {
  static const String _sendingEmailRouter = APIConfig.baseURL + '/invite/email';

  static Future<Map<String, dynamic>> sendEmail(String email) async {
    var completer = new Completer<Map<String, dynamic>>();
    var headers = await API.getAuthToken();
    try {
      var response = await http.post(
        _sendingEmailRouter,
        headers: headers,
        body: jsonEncode({'email': email}),
      );
      if (response.statusCode == 200) {
        completer.complete({'success': true});
      } else {
        completer.complete({'success': false});
      }
    } catch (e) {
      completer.complete({'success': false});
    }
    return completer.future;
  }
}
