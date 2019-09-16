import 'dart:core';
import 'package:flutter/foundation.dart';

import '../utils/constants.dart';

// Maid model
class Maid {
  String intro = '';
  LITERACY_TYPE literacyType = LITERACY_TYPE.other;
  String exp = '';
  SALARY_TYPE salaryType = SALARY_TYPE.less_one;
  List<JOB_TYPE> jobTypes = [];
  List<SUPPURT_AREA> supportAreas = [];

  Maid({
    @required this.intro,
    @required this.literacyType,
    @required this.exp,
    @required this.salaryType,
    @required this.jobTypes,
    @required this.supportAreas
  });
}