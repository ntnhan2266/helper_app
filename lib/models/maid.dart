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
  int salary = 1; // SALARY_TYPE
  List<String> jobTypes = []; // JOB_TYPE
  List<int> supportAreas = []; // SUPPORT_AREA
  double ratting = 0;

  Maid({
    this.intro = '',
    this.literacyType = 1,
    this.exp = '',
    this.salary = 1,
    this.jobTypes,
    this.supportAreas,
    this.ratting,
  });

  void fromJson(Map<String, dynamic> json) {
    this.intro = json['intro'];
    this.literacyType = json['literacyType'];
    this.exp = json['exp'];
    this.salary = json['salary'];
    this.jobTypes = json['jobTypes'].cast<String>();
    this.supportAreas = json['supportAreas'].cast<int>();
    this.ratting = json['ratting'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    return {
      'intro': intro,
      'literacyType': literacyType,
      'exp': exp,
      'salary': salary,
      'jobTypes': jobTypes,
      'supportAreas': supportAreas,
      'ratting': ratting,
    };
  }

  factory Maid.maidFromJson(Map<String, dynamic> json) {
    return Maid(
      intro: json['intro'],
      literacyType: json['literacyType'],
      exp: json['exp'],
      salary: json['salary'],
      jobTypes: json['jobTypes'].cast<String>(),
      supportAreas: json['supportAreas'].cast<int>(),
      ratting: json['ratting'].cast<double>(),
    );
  }
}
