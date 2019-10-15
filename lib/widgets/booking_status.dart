import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../utils/constants.dart';
import '../utils/route_names.dart';
import '../models/service_details.dart';

class BookingStatus extends StatelessWidget {
  final ServiceDetails data;
  final bool isHelper;

  BookingStatus({this.data, this.isHelper = false});

  Widget _buildTitle(BuildContext context) {
    switch (data.status) {
      case WAITING_APPROVE:
        return Text(
          AppLocalizations.of(context).tr('waiting_for_approve').toUpperCase(),
          style: TextStyle(
            color: Color.fromRGBO(15, 92, 17, 1),
            fontSize: ScreenUtil.instance.setSp(16),
            fontWeight: FontWeight.w600,
          ),
        );
      case APPROVED:
        return Text(
          AppLocalizations.of(context).tr('approved').toUpperCase(),
          style: TextStyle(
            color: Color.fromRGBO(15, 92, 17, 1),
            fontSize: ScreenUtil.instance.setSp(16),
            fontWeight: FontWeight.w600,
          ),
        );
      case COMPLETED:
        return Text(
          AppLocalizations.of(context).tr('completed').toUpperCase(),
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: ScreenUtil.instance.setSp(16),
            fontWeight: FontWeight.w600,
          ),
        );
      case REJECTED:
        return Text(
          AppLocalizations.of(context).tr('rejected').toUpperCase(),
          style: TextStyle(
            color: Color.fromRGBO(165, 0, 0, 1),
            fontSize: ScreenUtil.instance.setSp(16),
            fontWeight: FontWeight.w600,
          ),
        );
      case CANCELLED:
        return Text(
          AppLocalizations.of(context).tr('cancelled').toUpperCase(),
          style: TextStyle(
            color: Color.fromRGBO(165, 0, 0, 1),
            fontSize: ScreenUtil.instance.setSp(16),
            fontWeight: FontWeight.w600,
          ),
        );
      default:
        return Text(
          AppLocalizations.of(context).tr('updating').toUpperCase(),
          style: TextStyle(
            color: Colors.greenAccent,
            fontSize: ScreenUtil.instance.setSp(16),
            fontWeight: FontWeight.w600,
          ),
        );
    }
  }

  Widget _buildCancelInfo(BuildContext context) {
    var reason = '';
    if (data.status == REJECTED) {
      reason = AppLocalizations.of(context)
          .tr('reject_reason_' + data.reason.toString());
    } else if (data.status == CANCELLED) {
      reason = AppLocalizations.of(context)
          .tr('cancel_reason_' + data.reason.toString());
    }
    if (data.status == REJECTED || data.status == CANCELLED) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: ScreenUtil.instance.setHeight(12),
          ),
          Text(
            AppLocalizations.of(context).tr('reason') + ': ' + reason,
          ),
          SizedBox(
            height: ScreenUtil.instance.setHeight(12),
          ),
          Text(
            AppLocalizations.of(context).tr('description') +
                ': ' +
                data.content,
          ),
          SizedBox(
            height: ScreenUtil.instance.setHeight(12),
          ),
        ],
      );
    } else {
      return Container();
    }
  }

  Widget _buildAction(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          data.status == COMPLETED
              ? InkWell(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil.instance.setWidth(10),
                      vertical: ScreenUtil.instance.setWidth(5),
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Icon(
                      Icons.rate_review,
                      size: ScreenUtil.instance.setSp(16),
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, helperRattingRoute, arguments: data);
                  },
                )
              : SizedBox(
                  width: 0,
                ),
          SizedBox(
            width: ScreenUtil.instance.setWidth(15),
          ),
          InkWell(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil.instance.setWidth(10),
                vertical: ScreenUtil.instance.setWidth(5),
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(3),
              ),
              child: Icon(
                Icons.message,
                size: ScreenUtil.instance.setSp(16),
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, messageRoute, arguments: data);
            },
          ),
          SizedBox(
            width: ScreenUtil.instance.setWidth(15),
          ),
          InkWell(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil.instance.setWidth(10),
                vertical: ScreenUtil.instance.setWidth(5),
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(3),
              ),
              child: Icon(
                Icons.call,
                color: Colors.white,
                size: ScreenUtil.instance.setSp(16),
              ),
            ),
            onTap: () {
              if (isHelper) {
                if (data.createdBy.phoneNumber != null) {
                  // Call customer
                  launch('tel://${data.createdBy.phoneNumber}');
                } else {
                  Fluttertoast.showToast(
                    msg: AppLocalizations.of(context).tr('no_phone_number'),
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIos: 1,
                    backgroundColor: Color.fromRGBO(165, 0, 0, 1),
                    textColor: Colors.white,
                    fontSize: 14.0,
                  );
                }
              } else {
                if (data.maid.phoneNumber != null) {
                  // Call customer
                  launch('tel://${data.maid.phoneNumber}');
                } else {
                  Fluttertoast.showToast(
                    msg: AppLocalizations.of(context).tr('no_phone_number'),
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIos: 1,
                    backgroundColor: Color.fromRGBO(165, 0, 0, 1),
                    textColor: Colors.white,
                    fontSize: 14.0,
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil.instance.setWidth(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _buildTitle(context),
              _buildAction(context),
            ],
          ),
          _buildCancelInfo(context),
        ],
      ),
    );
  }
}
