import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/constants.dart';

class BookingStatus extends StatelessWidget {
  final int status;

  BookingStatus({this.status});

  Widget _buildTitle(BuildContext context) {
    switch (status) {
      case WAITING_APPROVE:
        return Text(
          AppLocalizations.of(context).tr('waiting_for_approve'),
          style: TextStyle(
            color: Color.fromRGBO(15, 92, 17, 1),
            fontSize: ScreenUtil.instance.setSp(16),
            fontWeight: FontWeight.w600,
          ),
        );
      case APPROVED:
        return Text(
          AppLocalizations.of(context).tr('approved'),
          style: TextStyle(
            color: Color.fromRGBO(15, 92, 17, 1),
            fontSize: ScreenUtil.instance.setSp(16),
            fontWeight: FontWeight.w600,
          ),
        );
      case COMPLETED:
        return Text(
          AppLocalizations.of(context).tr('completed'),
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: ScreenUtil.instance.setSp(16),
            fontWeight: FontWeight.w600,
          ),
        );
      case REJECTED:
        return Text(
          AppLocalizations.of(context).tr('rejected'),
          style: TextStyle(
            color: Color.fromRGBO(165, 0, 0, 1),
            fontSize: ScreenUtil.instance.setSp(16),
            fontWeight: FontWeight.w600,
          ),
        );
      case CANCELLED:
        return Text(
          AppLocalizations.of(context).tr('cancelled'),
          style: TextStyle(
            color: Color.fromRGBO(165, 0, 0, 1),
            fontSize: ScreenUtil.instance.setSp(16),
            fontWeight: FontWeight.w600,
          ),
        );
      default:
        return Text(
          AppLocalizations.of(context).tr('updating'),
          style: TextStyle(
            color: Colors.greenAccent,
            fontSize: ScreenUtil.instance.setSp(16),
            fontWeight: FontWeight.w600,
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil.instance.setWidth(18),
      ),
      child: Row(
        children: <Widget>[
          _buildTitle(context),
        ],
      ),
    );
  }
}
