import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flushbar/flushbar.dart';

import './constants.dart';

class Utils {
  static int genderToInt(GENDER gender) {
    switch (gender) {
      case GENDER.male:
        return 1;
      case GENDER.female:
        return 2;
      case GENDER.other:
        return 3;
      default:
        return 1;
    }
  }

  static int literacyToInt(LITERACY_TYPE literacyType) {
    switch (literacyType) {
      case LITERACY_TYPE.other:
        return 1;
      case LITERACY_TYPE.highschool:
        return 2;
      case LITERACY_TYPE.university:
        return 3;
      case LITERACY_TYPE.college:
        return 4;
      case LITERACY_TYPE.post_graduate:
        return 5;
      default:
        return 1;
    }
  }

  static int salaryToInt(SALARY_TYPE salary) {
    switch (salary) {
      case SALARY_TYPE.less_one:
        return 1;
      case SALARY_TYPE.one_to_three:
        return 2;
      case SALARY_TYPE.three_to_five:
        return 3;
      case SALARY_TYPE.five_to_seven:
        return 4;
      case SALARY_TYPE.more_seven:
        return 5;
      default:
        return 1;
    }
  }

  static int getSupportAreaCode(SUPPURT_AREA supportArea) {
    switch (supportArea) {
      case SUPPURT_AREA.district_1:
        return 1;
      case SUPPURT_AREA.district_2:
        return 2;
      case SUPPURT_AREA.district_3:
        return 3;
      case SUPPURT_AREA.district_4:
        return 4;
      case SUPPURT_AREA.district_5:
        return 5;
      case SUPPURT_AREA.district_6:
        return 6;
      case SUPPURT_AREA.district_7:
        return 7;
      case SUPPURT_AREA.district_8:
        return 8;
      case SUPPURT_AREA.district_9:
        return 9;
      case SUPPURT_AREA.district_10:
        return 10;
      case SUPPURT_AREA.district_11:
        return 11;
      case SUPPURT_AREA.district_12:
        return 12;
      case SUPPURT_AREA.district_binh_thanh:
        return 13;
      case SUPPURT_AREA.district_go_vap:
        return 14;
      case SUPPURT_AREA.district_phu_nhuan:
        return 15;
      case SUPPURT_AREA.district_tan_binh:
        return 16;
      case SUPPURT_AREA.district_thu_duc:
        return 17;
      case SUPPURT_AREA.district_binh_chanh:
        return 18;
      case SUPPURT_AREA.district_can_gio:
        return 19;
      case SUPPURT_AREA.district_cu_chi:
        return 20;
      case SUPPURT_AREA.district_hooc_mon:
        return 21;
      case SUPPURT_AREA.district_nha_be:
        return 22;
      default: 
        return 1;
    }
  }

  static List<int> listAr(List<SUPPURT_AREA> data) {
    final data = [];
  }

  static void showErrorSnackbar(BuildContext context) {
    Flushbar(
      titleText: Text(AppLocalizations.of(context).tr('error'),
          style: TextStyle(
              fontSize: ScreenUtil.instance.setSp(14.0), color: Colors.red)),
      messageText: Text(
        AppLocalizations.of(context).tr('something_went_wrong'),
        style: TextStyle(
          fontSize: ScreenUtil.instance.setSp(12.0),
          color: Colors.red,
        ),
      ),
      icon: Icon(
        Icons.error,
        size: 22,
        color: Colors.red,
      ),
      backgroundColor: Colors.white,
      borderWidth: 1.0,
      borderColor: Colors.red,
      duration: Duration(seconds: 3),
    )..show(context);
  }

  static void showSuccessSnackbar(BuildContext context, String title) {
    Flushbar(
      titleText: Text(AppLocalizations.of(context).tr('success'),
          style: TextStyle(
              fontSize: ScreenUtil.instance.setSp(14.0), color: Colors.green)),
      messageText: Text(
        title,
        style: TextStyle(
          fontSize: ScreenUtil.instance.setSp(12.0),
          color: Colors.green,
        ),
      ),
      icon: Icon(
        Icons.error,
        size: 22,
        color: Colors.green,
      ),
      backgroundColor: Colors.white,
      borderWidth: 1.0,
      borderColor: Colors.green,
      duration: Duration(seconds: 3),
    )..show(context);
  }
}
