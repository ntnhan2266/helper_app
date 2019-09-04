import 'dart:async';
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;

import '../configs/api.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()

class User {
  final String uid;
  final String firstName;
  final String lastName;
  final String email;
  final int gender;
  final DateTime birthday;
  final String phoneNumber;
  final double long;
  final double lat;
  final String address;

  // Config API routers
  static const Map<String, String> headers = {"Content-type": "application/json"};
  static const String _registerRoute = APIConfig.baseURL + '/register';

  User({
    this.uid,
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.birthday,
    this.phoneNumber,
    this.long,
    this.lat,
    this.address
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json['uid'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      gender: json['gender'],
      birthday: json['birthday'],
      phoneNumber: json['phoneNumber'],
      long: json['long'],
      lat: json['lat'],
      address: json['address']
    );
  }

  Map<String, dynamic> toJson() =>
    {
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'gender': gender,
      'birthday': birthday,
      'phoneNumber': phoneNumber,
      'long': long,
      'lat': lat,
      'address': address
    };

  static Future register({token, phoneNumber, email, name}) async {
    Map<String, String> body = {
      'token': token,
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email
    };
    var response = await http.post(_registerRoute, headers: headers, body: jsonEncode(body));
    print('Response code: ${response.statusCode}');
    print('Body: ${response.body}');
    var completer = new Completer();
    completer.complete(null);
    return completer.future;
  }
}