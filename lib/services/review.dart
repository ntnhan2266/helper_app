import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../configs/api.dart';
import './api.dart';

class ReviewService {
  static const String _reviewRoute = APIConfig.baseURL + '/review';
  
  static Future<Map<String, dynamic>> review({double rating, String content, String maidId, String bookingId}) async {
    var completer = new Completer<Map<String, dynamic>>();
    var headers = await API.getAuthToken();
    var body = {
      'rating': rating,
      'content': content,
      'maidId': maidId,
      'bookingId': bookingId
    };
    var response = await http.post(
      _reviewRoute,
      headers: headers,
      body: jsonEncode(body),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['errorCode'] != null) {
        completer.complete({'isValid': false, 'data': null});
      } else {
        final review = data['data'];
        completer.complete({'isValid': true, 'data': review});
      }
    } else {
      completer.complete({'isValid': false, 'data': null});
    }
    return completer.future;
  }

}