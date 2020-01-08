import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../services/api.dart';
import '../configs/api.dart';
import '../utils/constants.dart';
import '../models/category.dart';

class CategoryService {
  static const String _getAvailableCategoriesRoute =
      APIConfig.baseURL + '/categories/available';
  static const String _getSuggestedCategoriesRoute =
      APIConfig.baseURL + '/categories/suggested';
      static const String _getStatisticCategoriesRoute =
      APIConfig.baseURL + '/categories/statistic';

  static Future<Map<String, dynamic>> getAvailableCategories() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(X_TOKEN);
    var completer = new Completer<Map<String, dynamic>>();
    try {
      Map<String, String> headers = {
        HttpHeaders.contentTypeHeader: "application/json", // or whatever
        HttpHeaders.authorizationHeader: "Bearer $token",
      };
      var response =
          await http.get(_getAvailableCategoriesRoute, headers: headers);
      final data = jsonDecode(response.body);
      if (data['errorCode'] == null) {
        final json = data['categories'];
        final List<Category> categories = [];
        for (var i = 0; i < json.length; i++) {
          categories.add(Category.fromJson(json[i]));
        }
        completer.complete({'categories': categories, 'isValid': true});
      } else {
        completer.complete({'categories': null, 'isValid': false});
      }
      return completer.future;
    } catch (e) {
      completer.complete({'categories': null, 'isValid': false});
      return completer.future;
    }
  }

  static Future<Map<String, dynamic>> getSuggestedCategories() async {
    var completer = new Completer<Map<String, dynamic>>();
    var headers = await API.getAuthToken();
    try {
      var response =
          await http.get(_getSuggestedCategoriesRoute, headers: headers);
      final data = jsonDecode(response.body);
      if (data['errorCode'] == null) {
        final json = data['categories'];
        final List<Category> categories = [];
        for (var i = 0; i < json.length && i < 4; i++) {
          categories.add(Category.fromJson(json[i]));
        }
        completer.complete({'categories': categories, 'isValid': true});
      } else {
        completer.complete({'categories': null, 'isValid': false});
      }
      return completer.future;
    } catch (e) {
      completer.complete({'categories': null, 'isValid': false});
      return completer.future;
    }
  }

  static Future<Map<String, dynamic>> getStatisticCategories() async {
    var completer = new Completer<Map<String, dynamic>>();
    var headers = await API.getAuthToken();
    try {
      var response =
          await http.get(_getStatisticCategoriesRoute, headers: headers);
      final data = jsonDecode(response.body);
      if (data['errorCode'] == null) {
        // final json = data['statistic'];
        // final List<Category> categories = [];
        // for (var i = 0; i < json.length && i < 4; i++) {
        //   categories.add(Category.fromJson(json[i]));
        // }
        completer.complete({'statistic': data['statistic'], 'isValid': true});
      } else {
        completer.complete({'statistic': null, 'isValid': false});
      }
      return completer.future;
    } catch (e) {
      completer.complete({'statistic': null, 'isValid': false});
      return completer.future;
    }
  }
}
