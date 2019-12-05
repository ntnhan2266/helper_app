import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../services/api.dart';
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
  static const String _getTopRatingMaids =
      APIConfig.baseURL + '/maids/top-rating';
  static const String _searchMaids = APIConfig.baseURL + '/maids/search';

  static Future<Map<String, dynamic>> getMaid({String id}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(X_TOKEN);
    var completer = new Completer<Map<String, dynamic>>();
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json", // or whatever
      HttpHeaders.authorizationHeader: "Bearer $token",
    };
    var query = _getMaidRoute;
    if (id != null) {
      query = _getMaidRoute + '?id=' + id;
    }
    var response = await http.get(query, headers: headers);
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
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(X_TOKEN);
    var completer = new Completer<Map<String, dynamic>>();
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json", // or whatever
      HttpHeaders.authorizationHeader: "Bearer $token",
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
        'maids': [],
        'total': 0,
        'hasError': true,
      });
    }
    return completer.future;
  }

  static Future<Map<String, dynamic>> getTopRatingMaids() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(X_TOKEN);
    var completer = new Completer<Map<String, dynamic>>();
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json", // or whatever
      HttpHeaders.authorizationHeader: "Bearer $token",
    };
    var response = await http.get(_getTopRatingMaids, headers: headers);
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

  static Future<Map<String, dynamic>> searchMaids({
    int pageSize = 10,
    int pageIndex = 0,
    String search,
    List<String> services,
    List<int> areas,
    int minSalary,
    int maxSalary,
    String sort,
  }) async {
    var completer = new Completer<Map<String, dynamic>>();
    try {
      var serviceString = services.join(",");
      var areaString = areas.join(",");
      var headers = await API.getAuthToken();
      var response = await http.get(
        _searchMaids +
            '?pageSize=$pageSize&pageIndex=$pageIndex&search=$search&services=$serviceString&areas=$areaString&minSalary=$minSalary&maxSalary=$maxSalary&sort=$sort',
        headers: headers,
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['errorCode'] != null) {
          completer.complete({'isValid': false, 'data': null});
        } else {
          completer.complete({'isValid': true, 'data': data['maids']});
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
}
