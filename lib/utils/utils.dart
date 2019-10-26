import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flushbar/flushbar.dart';
import 'package:intl/intl.dart';

import '../widgets/components/color_loader.dart';
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

  static String intToGender(int gender) {
    switch (gender) {
      case 1:
        return "male";
      case 2:
        return "female";
      default:
        return "other";
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

  static String intToLiteracy(int literacyType) {
    switch (literacyType) {
      case 1:
        return "other";
      case 2:
        return "highschool";
      case 3:
        return "university";
      case 4:
        return "college";
      case 5:
        return "post_graduate";
      default:
        return "other";
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

  static String intToSalary(int salary) {
    switch (salary) {
      case 1:
        return "less_one";
      case 2:
        return "one_to_three";
      case 3:
        return "three_to_five";
      case 4:
        return "five_to_seven";
      case 5:
        return "more_seven";
      default:
        return "less_one";
    }
  }

  static String intToJob(int salary) {
    switch (salary) {
      case 1:
        return "house_cleaning";
      case 2:
        return "garden";
      case 3:
        return "go_to_market";
      case 4:
        return "child_care";
      case 5:
        return "laundry";
      default:
        return "other";
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

  static String intToSupportArea(int supportArea) {
    switch (supportArea) {
      case 1:
        return "district_1";
      case 2:
        return "district_2";
      case 3:
        return "district_3";
      case 4:
        return "district_4";
      case 5:
        return "district_5";
      case 6:
        return "district_6";
      case 7:
        return "district_7";
      case 8:
        return "district_8";
      case 9:
        return "district_9";
      case 10:
        return "district_10";
      case 11:
        return "district_11";
      case 12:
        return "district_12";
      case 13:
        return "district_binh_thanh";
      case 14:
        return "district_go_vap";
      case 15:
        return "district_phu_nhuan";
      case 16:
        return "district_tan_binh";
      case 17:
        return "district_thu_duc";
      case 18:
        return "district_binh_chanh";
      case 19:
        return "district_can_gio";
      case 20:
        return "district_cu_chi";
      case 21:
        return "district_hooc_mon";
      case 22:
        return "district_nha_be";
      default:
        return "district_1";
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

  static int calculateIntervalDays(
      DateTime startDate, DateTime endDate, Map<String, bool> interval) {
    int days = 0;
    startDate = new DateTime(
        startDate.year, startDate.month, startDate.day, 0, 0, 0, 0, 0);
    endDate =
        new DateTime(endDate.year, endDate.month, endDate.day, 23, 0, 0, 0, 0);
    if (endDate != null) {
      while (startDate.compareTo(endDate) <= 0) {
        final currentDay = startDate;
        // Check every weekday
        bool isPickedDay =
            (currentDay.weekday == DateTime.sunday && interval['sun']) ||
                (currentDay.weekday == DateTime.monday && interval['mon']) ||
                (currentDay.weekday == DateTime.tuesday && interval['tue']) ||
                (currentDay.weekday == DateTime.wednesday && interval['wed']) ||
                (currentDay.weekday == DateTime.thursday && interval['thu']) ||
                (currentDay.weekday == DateTime.friday && interval['fri']) ||
                (currentDay.weekday == DateTime.saturday && interval['sat']);
        if (isPickedDay) {
          days += 1;
        }
        // Go to next day
        startDate = startDate.add(Duration(days: 1));
      }
    }
    return days;
  }

  static List<String> getIntervalDayList(
      DateTime startDate, DateTime endDate, Map<String, bool> interval) {
    final List<String> days = [];
    startDate = new DateTime(
        startDate.year, startDate.month, startDate.day, 0, 0, 0, 0, 0);
    endDate =
        new DateTime(endDate.year, endDate.month, endDate.day, 23, 0, 0, 0, 0);
    if (endDate != null) {
      while (startDate.compareTo(endDate) <= 0) {
        final currentDay = startDate;
        // Check every weekday
        bool isPickedDay =
            (currentDay.weekday == DateTime.sunday && interval['sun']) ||
                (currentDay.weekday == DateTime.monday && interval['mon']) ||
                (currentDay.weekday == DateTime.tuesday && interval['tue']) ||
                (currentDay.weekday == DateTime.wednesday && interval['wed']) ||
                (currentDay.weekday == DateTime.thursday && interval['thu']) ||
                (currentDay.weekday == DateTime.friday && interval['fri']) ||
                (currentDay.weekday == DateTime.saturday && interval['sat']);
        if (isPickedDay) {
          days.add(DateFormat('yyyy-MM-dd').format(startDate));
        }
        // Go to next day
        startDate = startDate.add(Duration(days: 1));
      }
    }
    return days;
  }

  static String getServiceDate(int type, DateTime startDate, DateTime endDate) {
    if (type == 1) {
      return DateFormat('dd/MM/yyyy').format(startDate);
    } else {
      return DateFormat('dd/MM/yyyy').format(startDate) +
          " - " +
          DateFormat('dd/MM/yyyy').format(endDate);
    }
  }

  static String getServiceTime(DateTime startTime, DateTime endTime) {
    return DateFormat('HH:mm').format(startTime) +
        " - " +
        DateFormat('HH:mm').format(endTime);
  }

  static String getServiceType(int type, BuildContext context) {
    if (type == 1)
      return AppLocalizations.of(context).tr("retail_use");
    else
      return AppLocalizations.of(context).tr("periodic");
  }

  static void showErrorDialog(BuildContext context, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context).tr('error')),
          content: Text(AppLocalizations.of(context).tr(content)),
          actions: <Widget>[
            FlatButton(
              child: Text(AppLocalizations.of(context).tr('ok')),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  static void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: ColorLoader(),
        );
      },
    );
  }
}
