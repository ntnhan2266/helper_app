import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingStepTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;

    double defaultScreenWidth = 400.0;
    double defaultScreenHeight = 810.0;
    ScreenUtil.instance = ScreenUtil(
      width: defaultScreenWidth,
      height: defaultScreenHeight,
      allowFontScaling: true,
    )..init(context);

    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              height: 100.0,
              decoration: const BoxDecoration(color: Colors.red,),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              height: 100.0,
              decoration: const BoxDecoration(color: Colors.blue,),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              height: 100.0,
              decoration: const BoxDecoration(color: Colors.green),
            ),
          ),
        ],
      ),
    );
  }
}
