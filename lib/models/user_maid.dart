import 'package:flutter/foundation.dart';

class UserMaid {
  String id;
  String intro = '';
  int literacyType = 1; // LITERACY_TYPE
  String exp = '';
  int salary = 1; // SALARY_TYPE
  List<int> jobTypes = []; // JOB_TYPE
  List<int> supportAreas = []; // SUPPORT_AREA
  String name;
  String email;
  int gender;
  DateTime birthday;
  String phoneNumber;
  String address;
  String avatar;
  DateTime createdAt;
  double rating;

  UserMaid({
    @required this.intro,
    @required this.literacyType,
    @required this.exp,
    @required this.salary,
    @required this.jobTypes,
    @required this.supportAreas,
    @required this.id,
    @required this.name,
    @required this.email,
    @required this.gender,
    @required this.birthday,
    @required this.phoneNumber,
    @required this.address,
    @required this.avatar,
    @required this.createdAt,
    this.rating = 0,
  });

  factory UserMaid.fromJson(Map<String, dynamic> json) {
    return UserMaid(
      intro: json['intro'],
      id: json['_id'],
      literacyType: json['literacyType'],
      exp: json['exp'],
      salary: json['salary'],
      jobTypes: json['jobTypes'].cast<int>(),
      supportAreas: json['supportAreas'].cast<int>(),
      name: json['user']['name'],
      email: json['user']['email'],
      gender: json['user']['gender'],
      birthday: DateTime.parse(json['user']['birthday']).toLocal(),
      phoneNumber: json['user']['phoneNumber'],
      address: json['user']['address'],
      createdAt: DateTime.parse(json['createdAt']),
      avatar: json['user']['avatar'],
      rating: json['rating'] != null ? json['rating'] : 0,
    );
  }

  static UserMaid getMaid(Map<String, dynamic> json) {
    return UserMaid(
      intro: json['intro'],
      id: json['_id'],
      literacyType: json['literacyType'],
      exp: json['exp'],
      salary: json['salary'],
      jobTypes: json['jobTypes'].cast<int>(),
      supportAreas: json['supportAreas'].cast<int>(),
      name: json['user']['name'],
      email: json['user']['email'],
      gender: json['user']['gender'],
      birthday: DateTime.parse(json['user']['birthday']).toLocal(),
      phoneNumber: json['user']['phoneNumber'],
      address: json['user']['address'],
      createdAt: DateTime.parse(json['createdAt']),
      avatar: json['user']['avatar'],
      rating: json['rating'] != null ? json['rating'] : 0,
    );
  }
}
