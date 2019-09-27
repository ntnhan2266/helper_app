import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/service_details.dart';
import '../configs/api.dart';
import './api.dart';

class BookingService {
  static const String _bookingRouter = APIConfig.baseURL + '/booking';

  static Future<Map<String, dynamic>> booking(ServiceDetails booking) async {
    var completer = new Completer<Map<String, dynamic>>();
    var headers = await API.getAuthToken();
    var response =  await http.post(
      _bookingRouter,
      headers: headers,
      body: jsonEncode(booking),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['errorCode'] != null) {
        completer.complete({'isValid': false, 'maid': null});
      } else {
        final booking = data['booking'];
        completer.complete({'isValid': true, 'data': booking});
      }
    }
    return completer.future;
  }
}
