import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/maid_review.dart';
import '../configs/api.dart';
import '../utils/constants.dart';
import '../models/maid.dart';

class MaidService {
  static const String _getMaidRoute = APIConfig.baseURL + '/maid';
  static const String _getMaidListRoute = APIConfig.baseURL + '/maids';
  static const String _registerMaidRoute = APIConfig.baseURL + '/maid';
  static const String _editMaidRoute = APIConfig.baseURL + '/maid/edit';
  static const String _getMaidReviewsRoute =
      APIConfig.baseURL + '/maid/reviews';

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
      completer.complete({'maid': maid, 'isHost': true});
    } else {
      completer.complete({'maid': null, 'isHost': false});
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
    var response = await http.post(_registerMaidRoute,
        headers: headers, body: jsonEncode(maid));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['errorCode'] != null) {
        completer.complete({'isValid': false, 'maid': null});
      } else {
        final maid = data['maid'];
        completer.complete({'isValid': true, 'maid': maid});
      }
    } else {
      completer.complete({'isValid': false, 'maid': null});
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
    var response = await http.post(_editMaidRoute,
        headers: headers, body: jsonEncode(maid));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['errorCode'] != null) {
        completer.complete({'isValid': false, 'maid': null});
      } else {
        final maid = data['maid'];
        completer.complete({'isValid': true, 'maid': maid});
      }
    } else {
      completer.complete({'isValid': false, 'maid': null});
    }
    return completer.future;
  }

  static Future<Map<String, dynamic>> getMaidList() async {
    var completer = new Completer<Map<String, dynamic>>();
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json", // or whatever
    };
    var response = await http.get(_getMaidListRoute, headers: headers);
    final data = jsonDecode(response.body);
    if (data['errorCode'] == null) {
      final maids = data['maids'];
      final total = data['total'];
      completer.complete({
        'maids': maids,
        'total': total,
        'hasError': false,
      });
    } else {
      completer.complete({
        'maids': null,
        'total': null,
        'hasError': true,
      });
    }
    return completer.future;
  }

  static Future<Map<String, dynamic>> getMaidReviews(
      String id, int page, int size) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(X_TOKEN);
    var completer = new Completer<Map<String, dynamic>>();
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json", // or whatever
      HttpHeaders.authorizationHeader: "Bearer $token",
      "page": page.toString(),
      "size": size.toString(),
    };
    var response = await http.get("$_getMaidReviewsRoute?page=$page&size=$size",
        headers: headers);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['errorCode'] != null) {
        completer.complete({'isValid': false, 'data': null});
      } else {
        final json = data['reviews'];
        final List<MaidReview> reviews = [];
        for (var i = 0; i < json.length; i++) {
          reviews.add(MaidReview.fromJson(json[i]));
        }
        final total = data['total'];
        completer.complete({'isValid': true, 'data': reviews, 'total': total});
      }
    } else {
      completer.complete({'isValid': false, 'data': null});
    }
    return completer.future;
  }
}
