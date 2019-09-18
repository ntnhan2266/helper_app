import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../configs/api.dart';
import '../utils/constants.dart';

class FileService {
  static String uploadAvatarRoute = APIConfig.baseURL + '/file/upload';

  static Future<Map<String, dynamic>> uploadAvatar(
    String base64Image,
    String fileName,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(X_TOKEN);
    var completer = new Completer<Map<String, dynamic>>();
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json", // or whatever
      HttpHeaders.authorizationHeader: "Bearer $token",
    };
    final body = {
      "image": base64Image,
      "name": fileName,
    };
    final res = await http.post(uploadAvatarRoute,
        headers: headers, body: jsonEncode(body));
    if (res.statusCode == 200) {
      final body = jsonDecode(res.body);
      completer.complete({
        'isValid': true,
        'path': body['path'],
      });
    } else {
      completer.complete({
        'isValid': false,
        'path': null,
      });
    }
    return completer.future;
  }
}
