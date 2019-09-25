import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/service_details.dart';
import './api.dart';

class BookingService {
  static const String _bookingRouter = '/booking';

  static Future<Map<String, dynamic>> booking(ServiceDetails booking) async {
    var completer = new Completer<Map<String, dynamic>>();
    var headers = await API.getAuthToken();
    var response = await http.post(
      _bookingRouter,
      headers: headers,
      body: jsonEncode(booking),
    );
    print(response.body);
    completer.complete({'string': 'a'});
    return completer.future;
  }
}
