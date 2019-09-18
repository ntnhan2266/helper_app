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
