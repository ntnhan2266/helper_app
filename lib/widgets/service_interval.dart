import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

class ServiceInterval extends StatelessWidget {
  final Map<String, bool> data;
  final Function handleClick;
  ServiceInterval({this.data, this.handleClick});

  Widget _buildStep(String title, bool isActive, Function handleClick) {
    return Expanded(
      flex: 1,
      child: FlatButton(
        onPressed: handleClick,
        child: Text(title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double defaultScreenWidth = 400.0;
    double defaultScreenHeight = 810.0;
    ScreenUtil.instance = ScreenUtil(
      width: defaultScreenWidth,
      height: defaultScreenHeight,
      allowFontScaling: true,
    )..init(context);

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: ScreenUtil.instance.setWidth(10),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              
            ],
          ),
        ],
      ),
    );
  }
}