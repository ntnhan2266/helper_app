import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingBottomBar extends StatelessWidget {
  final Function onSubmit;
  BookingBottomBar({
    @required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(blurRadius: 10, color: Color.fromRGBO(0, 0, 0, 0.4))
      ]),
      padding: EdgeInsets.all(ScreenUtil.instance.setWidth(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            AppLocalizations.of(context).tr('service_fee'),
          ),
          Container(
            width: double.infinity,
            child: RaisedButton(
              child: Text(
                AppLocalizations.of(context).tr('next').toUpperCase(),
                style: TextStyle(
                  fontSize: ScreenUtil.instance.setSp(13),
                ),
              ),
              color: Color.fromRGBO(42, 77, 108, 1),
              textColor: Colors.white,
              onPressed: () {
                onSubmit();
              },
            ),
          ),
        ],
      ),
    );
  }
}
