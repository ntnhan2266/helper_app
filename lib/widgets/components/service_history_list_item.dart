import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../models/service_category.dart';
import '../../models/service_details.dart';
import '../../utils/dummy_data.dart';

class ServiceHistoryListItem extends StatelessWidget {
  final ServiceDetails serviceDetail;

  const ServiceHistoryListItem(this.serviceDetail, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ServiceCategory _serviceCategory = categoriesData[serviceDetail.category];

    String _getDate() {
      if (serviceDetail.endDate.compareTo(serviceDetail.startDate) == 0) {
        return DateFormat('dd/MM/yyyy').format(serviceDetail.startDate);
      } else {
        return DateFormat('dd/MM/yyyy').format(serviceDetail.startDate) +
            " - " +
            DateFormat('dd/MM/yyyy').format(serviceDetail.endDate);
      }
    }

    String _getTime() {
      return DateFormat('HH:mm').format(serviceDetail.startTime) +
          " - " +
          DateFormat('HH:mm').format(serviceDetail.endTime);
    }

    Widget _iconAndText(IconData icon, String text) {
      return Row(
        children: <Widget>[
          Icon(
            icon,
            size: 13,
            color: Colors.blueGrey[300],
          ),
          Container(
            padding: EdgeInsets.only(left: 5.0),
            child: Text(
              text,
              style: TextStyle(
                fontSize: ScreenUtil.instance.setSp(14.0),
                color: Colors.blueGrey[300],
              ),
            ),
          ),
        ],
      );
    }

    Widget _flatButton(IconData icon, String text) {
      return Container(
        height: 35,
        child: FlatButton.icon(
          onPressed: () {},
          icon: Icon(
            icon,
            size: 15,
            color: Theme.of(context).primaryColor,
          ),
          label: Text(
            text,
            style: TextStyle(
              fontSize: ScreenUtil.instance.setSp(14.0),
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      );
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.0, horizontal: 5.0),
      padding: EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
      child: InkWell(
        child: Container(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Image.asset(
                    _serviceCategory.imgURL,
                    width: MediaQuery.of(context).size.width / 4,
                    height: MediaQuery.of(context).size.width / 4,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 3 / 4 - 30,
                    padding: EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context)
                              .tr(_serviceCategory.serviceName),
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 10),
                        _iconAndText(
                          Icons.location_on,
                          serviceDetail.address,
                        ),
                        _iconAndText(
                          Icons.date_range,
                          _getDate(),
                        ),
                        _iconAndText(
                          Icons.timer,
                          _getTime(),
                        ),
                        _iconAndText(
                          Icons.attach_money,
                          NumberFormat.currency(locale: "vi-vn")
                              .format(serviceDetail.amount),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _flatButton(
                    Icons.history,
                    AppLocalizations.of(context).tr("repick"),
                  ),
                  _flatButton(
                    Icons.details,
                    AppLocalizations.of(context).tr("view"),
                  ),
                ],
              ),
            ],
          ),
        ),
        onTap: () {},
      ),
    );
  }
}
