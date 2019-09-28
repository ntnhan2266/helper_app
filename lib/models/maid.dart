import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
/// Maid model

@JsonSerializable()
class Maid {
  String intro = '';
  int literacyType = 1; // LITERACY_TYPE
  String exp = '';
  int salary = 1;   // SALARY_TYPE
  List<int> jobTypes = []; // JOB_TYPE
  List<int> supportAreas = []; // SUPPORT_AREA

  Maid({
    this.intro = '',
    this.literacyType = 1,
    this.exp = '',
    this.salary = 1,
    this.jobTypes,
    this.supportAreas
  });

  void fromJson(Map<String, dynamic> json) {
    this.intro = json['intro'];
    this.literacyType = json['literacyType'];
    this.exp = json['exp'];
    this.salary = json['salary'];
    this.jobTypes = json['jobTypes'].cast<int>();
    this.supportAreas = json['supportAreas'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    return {
      'intro': intro,
      'literacyType': literacyType,
      'exp': exp,
      'salary': salary,
      'jobTypes': jobTypes,
      'supportAreas': supportAreas
    };
  }

  factory Maid.maidFromJson(Map<String, dynamic> json) {
    return Maid(
    intro: json['intro'],
    literacyType: json['literacyType'],
    exp: json['exp'],
    salary: json['salary'],
    jobTypes: json['jobTypes'].cast<int>(),
    supportAreas: json['supportAreas'].cast<int>(),
    );
  }
}