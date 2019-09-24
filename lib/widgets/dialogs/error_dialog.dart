import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ErrorDialog extends StatelessWidget {
  final String title;

  ErrorDialog(this.title);

  @override
  Widget build(BuildContext context) {
    double defaultScreenWidth = 400.0;
    double defaultScreenHeight = 810.0;
    ScreenUtil.instance = ScreenUtil(
      width: defaultScreenWidth,
      height: defaultScreenHeight,
      allowFontScaling: true,
    )..init(context);

    return AlertDialog(
      title: Row(
        children: <Widget>[
          Icon(
            Icons.error_outline,
            color: Colors.red,
          ),
          SizedBox(
            width: ScreenUtil.instance.setWidth(10),
          ),
          Text(
            AppLocalizations.of(context).tr('error'),
            style: TextStyle(
              fontSize: ScreenUtil.instance.setSp(14.0),
              color: Colors.red,
            ),
          ),
        ],
      ),
      content: Text(
        title,
        style: TextStyle(
          fontSize: ScreenUtil.instance.setSp(12.0),
          color: Colors.red,
        ),
      ),
      actions: <Widget>[
        // usually buttons at the bottom of the dialog
        FlatButton(
          color: Colors.red,
          child: Text(
            AppLocalizations.of(context).tr('ok'),
            style: TextStyle(
              color: Colors.white,
              fontSize: ScreenUtil.instance.setSp(12.0),
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
