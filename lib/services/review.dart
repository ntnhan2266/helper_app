import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/maid_review.dart';
import '../configs/api.dart';
import './api.dart';

class ReviewService {
  static const String _reviewRoute = APIConfig.baseURL + '/review';
  static const String _getReviewsByMaidId = APIConfig.baseURL + '/reviews';

  static Future<Map<String, dynamic>> review(
      {double rating, String content, String maidId, String bookingId}) async {
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

  static Future<Map<String, dynamic>> getReviewsByMaidId(String maidId,
      {int pageSize = 10, int pageIndex = 1}) async {
    var completer = new Completer<Map<String, dynamic>>();
    var headers = await API.getAuthToken();
    var response = await http.get(
      _getReviewsByMaidId + maidId + '&pageSize=$pageSize&pageIndex=$pageIndex',
      headers: headers,
    );
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
