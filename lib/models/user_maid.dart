import 'package:flutter/foundation.dart';

class UserMaid {
  String id;
  String intro = '';
  int literacyType = 1; // LITERACY_TYPE
  String exp = '';
  int salary = 1;   // SALARY_TYPE
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
  });
}