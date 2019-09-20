import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

import '../utils/constants.dart';
import '../utils/utils.dart';


/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
/// // Maid model

@JsonSerializable()
class Maid {
  String intro = '';
  int literacyType = 1; // LITERACY_TYPE
  String exp = '';
  int salaryType = 1;   // SALARY_TYPE
  List<int> jobTypes = []; // JOB_TYPE
  List<int> supportAreas = []; // SUPPORT_AREA

  Maid({
    this.intro = '',
    this.literacyType = 1,
    this.exp = '',
    this.salaryType = 1,
    this.jobTypes,
    this.supportAreas
  });

  void fromJson(Map<String, dynamic> json) {
    this.intro = json['intro'];
    this.literacyType = json['literacyType'];
    this.exp = json['exp'];
    this.salaryType = json['salaryType'];
    this.jobTypes = json['jobTypes'];
    this.supportAreas = json['supportAreas'];
  }

  Map<String, dynamic> toJson() {
    return {
      'intro': intro,
      'literacyType': literacyType,
      'exp': exp,
      'salaryType': salaryType,
      'jobTypes': 1
    };
  }
}