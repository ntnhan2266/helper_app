import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/service_details.dart';
import '../configs/api.dart';
import './api.dart';

class BookingService {
  static const String _bookingRouter = APIConfig.baseURL + '/booking';
  static const String _getBookingByIdRouter =
      APIConfig.baseURL + '/booking?id=';
  static const String _getBookingByStatus =
      APIConfig.baseURL + '/bookings?status=';
  static const String _getHostBookingByStatus =
      APIConfig.baseURL + '/bookings/host?status=';

  static Future<Map<String, dynamic>> booking(ServiceDetails booking) async {
    var completer = new Completer<Map<String, dynamic>>();
    var headers = await API.getAuthToken();
    var response = await http.post(
      _bookingRouter,
      headers: headers,
      body: jsonEncode(booking),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['errorCode'] != null) {
        completer.complete({'isValid': false, 'data': null});
      } else {
        final booking = data['booking'];
        var documentReference = Firestore.instance
            .collection('conversations')
            .document(booking['_id'])
            .collection(booking['_id'])
            .document(DateTime.now().millisecondsSinceEpoch.toString());
        Firestore.instance.runTransaction((transaction) async {
          await transaction.set(documentReference, 
            {
              'from': booking['maid'],
              'to': booking['createdBy'],
              'content':
                  'Cảm ơn bạn đã chọn dịch vụ của chúng tôi, dịch vụ của bạn đang được xác nhận',
              'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
          });
        });
        completer.complete({'isValid': true, 'data': booking});
      }
    }
    return completer.future;
  }

  static Future<Map<String, dynamic>> getBookingById(String id) async {
    var completer = new Completer<Map<String, dynamic>>();
    var headers = await API.getAuthToken();
    var response = await http.get(
      _getBookingByIdRouter + id,
      headers: headers,
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['errorCode'] != null) {
        completer.complete({'isValid': false, 'data': null});
      } else {
        final booking = data['booking'];
        completer.complete({'isValid': true, 'data': booking});
      }
    } else {
      completer.complete({'isValid': false, 'data': null});
    }
    return completer.future;
  }

  static Future<Map<String, dynamic>> getBookingsByStatus(int status,
      {int pageSize = 10, int pageIndex = 1}) async {
    var completer = new Completer<Map<String, dynamic>>();
    var headers = await API.getAuthToken();
    var response = await http.get(
      _getBookingByStatus + status.toString(),
      headers: headers,
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['errorCode'] != null) {
        completer.complete({'isValid': false, 'data': null});
      } else {
        final json = data['bookings'];
        final List<ServiceDetails> bookings = [];
        for (var i = 0; i < json.length; i++) {
          bookings.add(ServiceDetails.fromJson(json[i]));
        }
        final total = data['total'];
        completer.complete({'isValid': true, 'data': bookings, 'total': total});
      }
    } else {
      completer.complete({'isValid': false, 'data': null});
    }
    return completer.future;
  }

  static Future<Map<String, dynamic>> getHostBookingsByStatus(int status,
      {int pageSize = 10, int pageIndex = 1}) async {
    var completer = new Completer<Map<String, dynamic>>();
    var headers = await API.getAuthToken();
    var response = await http.get(
      _getHostBookingByStatus + status.toString(),
      headers: headers,
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['errorCode'] != null) {
        completer.complete({'isValid': false, 'data': null});
      } else {
        final json = data['bookings'];
        final List<ServiceDetails> bookings = [];
        for (var i = 0; i < json.length; i++) {
          bookings.add(ServiceDetails.fromJson(json[i]));
        }
        final total = data['total'];
        completer.complete({'isValid': true, 'data': bookings, 'total': total});
      }
    } else {
      completer.complete({'isValid': false, 'data': null});
    }
    return completer.future;
  }
}
