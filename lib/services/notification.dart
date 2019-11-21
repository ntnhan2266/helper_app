import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/notification.dart';
import '../configs/api.dart';
import './api.dart';

class NotificationService {
  static const String _notificationRouter = APIConfig.baseURL + '/notification';
  static const String _markAsReadNotificationRouter =
      APIConfig.baseURL + '/notification/read';
  static const String _countNotificationRouter =
      APIConfig.baseURL + '/notification/count';

  static Future<Map<String, dynamic>> getNotification(
      {int pageSize = 10, int pageIndex = 0}) async {
    var completer = new Completer<Map<String, dynamic>>();
    try {
      var headers = await API.getAuthToken();
      var response = await http.get(
        _notificationRouter + '?pageSize=$pageSize&pageIndex=$pageIndex',
        headers: headers,
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['errorCode'] != null) {
          completer.complete({'isValid': false, 'data': null});
        } else {
          final json = data['notifications'];
          final List<Notification> notifications = [];
          for (var i = 0; i < json.length; i++) {
            notifications.add(Notification.fromJson(json[i]));
          }
          completer.complete({'isValid': true, 'data': notifications});
        }
      } else {
        completer.complete({'isValid': false, 'data': null});
      }
      return completer.future;
    } catch (e) {
      completer.complete({'isValid': false, 'data': null});
      return completer.future;
    }
  }

  static Future<Map<String, dynamic>> markAsRead() async {
    var completer = new Completer<Map<String, dynamic>>();
    try {
      var headers = await API.getAuthToken();
      var response = await http.get(
        _markAsReadNotificationRouter,
        headers: headers,
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['errorCode'] != null) {
          completer.complete({'isValid': false});
        } else {
          completer.complete({'isValid': true});
        }
      } else {
        completer.complete({'isValid': false});
      }
      return completer.future;
    } catch (e) {
      completer.complete({'isValid': false});
      return completer.future;
    }
  }

  static Future<Map<String, dynamic>> count() async {
    var completer = new Completer<Map<String, dynamic>>();
    try {
      var headers = await API.getAuthToken();
      var response = await http.get(
        _countNotificationRouter,
        headers: headers,
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['errorCode'] != null) {
          completer.complete({'isValid': false});
        } else {
          completer.complete({'isValid': true, 'count': data['count']});
        }
      } else {
        completer.complete({'isValid': false});
      }
      return completer.future;
    } catch (e) {
      completer.complete({'isValid': false});
      return completer.future;
    }
  }
}
