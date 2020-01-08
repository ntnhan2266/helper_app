import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

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
  static const String _approveBooking =
      APIConfig.baseURL + '/booking/approve?id=';
  static const String _rejectBooking = APIConfig.baseURL + '/booking/reject';
  static const String _cancelBooking = APIConfig.baseURL + '/booking/cancel';
  static const String _completeBooking =
      APIConfig.baseURL + '/booking/complete?id=';
  static const String _reportHelperRoute = APIConfig.baseURL + '/report';
  static const String _bookingCalendarRouter =
      APIConfig.baseURL + '/bookings/calendar';

  static Future<Map<String, dynamic>> booking(ServiceDetails booking) async {
    var completer = new Completer<Map<String, dynamic>>();
    var headers = await API.getAuthToken();
    var response = await http.post(
      _bookingRouter,
      headers: headers,
      body: jsonEncode(booking),
    );
    if (response.statusCode == 200) {
      final res = jsonDecode(response.body);
      if (res['errorCode'] != null) {
        completer.complete({'isValid': false, 'data': null});
      } else {
        final data = res['booking'];
        var documentReference = Firestore.instance
            .collection('conversations')
            .document(data['_id'])
            .collection(data['_id'])
            .document(DateTime.now().millisecondsSinceEpoch.toString());
        Firestore.instance.runTransaction((transaction) async {
          await transaction.set(documentReference, {
            'from': booking.maid.id,
            'to': data['createdBy'],
            'content':
                'Cảm ơn bạn đã chọn dịch vụ của chúng tôi, dịch vụ của bạn đang được xác nhận',
            'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
          });
        });
        completer.complete({'isValid': true, 'data': data});
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
      {int pageSize = 10, int pageIndex = 0}) async {
    var completer = new Completer<Map<String, dynamic>>();
    var headers = await API.getAuthToken();
    var response = await http.get(
      _getBookingByStatus +
          status.toString() +
          '&pageSize=$pageSize&pageIndex=$pageIndex',
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

  static Future<Map<String, dynamic>> approve(String id) async {
    var completer = new Completer<Map<String, dynamic>>();
    var headers = await API.getAuthToken();
    var response = await http.put(
      _approveBooking + id,
      headers: headers,
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['completed']) {
        completer.complete({
          'isValid': true,
        });
      } else {
        completer.complete({
          'isValid': false,
        });
      }
    } else {
      completer.complete({
        'isValid': false,
      });
    }
    return completer.future;
  }

  static Future<Map<String, dynamic>> cancel(
      String id, int reason, String content, bool isHelper) async {
    var completer = new Completer<Map<String, dynamic>>();
    var headers = await API.getAuthToken();
    var body = {'id': id, 'reason': reason, 'content': content};
    var response = await http.post(isHelper ? _rejectBooking : _cancelBooking,
        headers: headers, body: jsonEncode(body));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['completed']) {
        completer.complete({
          'isValid': true,
        });
      } else {
        completer.complete({
          'isValid': false,
        });
      }
    } else {
      completer.complete({
        'isValid': false,
      });
    }
    return completer.future;
  }

  static Future<Map<String, dynamic>> complete(String id) async {
    var completer = new Completer<Map<String, dynamic>>();
    var headers = await API.getAuthToken();
    var response = await http.put(
      _completeBooking + id,
      headers: headers,
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['completed']) {
        completer.complete({
          'isValid': true,
        });
      } else {
        completer.complete({
          'isValid': false,
        });
      }
    } else {
      completer.complete({
        'isValid': false,
      });
    }
    return completer.future;
  }

  static Future<Map<String, dynamic>> report(
    String id,
    int reason,
    String description,
  ) async {
    var completer = new Completer<Map<String, dynamic>>();
    var headers = await API.getAuthToken();
    var body = {'id': id, 'reason': reason, 'description': description};
    var response = await http.post(
      _reportHelperRoute,
      headers: headers,
      body: jsonEncode(body),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['completed']) {
        completer.complete({
          'isValid': true,
        });
      } else {
        completer.complete({
          'isValid': false,
        });
      }
    } else {
      completer.complete({
        'isValid': false,
      });
    }
    return completer.future;
  }

  static Future<Map<String, dynamic>> getBookingByDate(
      DateTime from, DateTime to) async {
    var fromFormat = DateFormat('yyyy-MM-dd').format(from);
    var toFormat = DateFormat('yyyy-MM-dd').format(to);

    var completer = new Completer<Map<String, dynamic>>();
    var headers = await API.getAuthToken();
    try {
      var response = await http.get(
        _bookingCalendarRouter + '?from=$fromFormat&to=$toFormat',
        headers: headers,
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['errorCode'] != null) {
          completer.complete({'isValid': false, 'data': null});
        } else {
          completer.complete({'isValid': true, 'data': data['calendar']});
        }
      } else {
        completer.complete({'isValid': false, 'data': null});
      }
    } catch (e) {
      completer.complete({'isValid': false, 'data': null});
    }
    return completer.future;
  }
}
