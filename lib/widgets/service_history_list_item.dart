import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../models/service_category.dart';
import '../models/service_details.dart';
import '../utils/dummy_data.dart';
import '../utils/utils.dart';
import '../utils/route_names.dart';

class ServiceHistoryListItem extends StatelessWidget {
  final ServiceDetails serviceDetail;
  final bool isHelper;

  const ServiceHistoryListItem(this.serviceDetail, {this.isHelper = false});

  @override
  Widget build(BuildContext context) {
    ServiceCategory _serviceCategory = categoriesData[serviceDetail.category];

    Widget _iconAndText(IconData icon, String text, double width) {
      return Row(
        children: <Widget>[
          Icon(
            icon,
            size: ScreenUtil.instance.setSp(13.0),
            color: Colors.blueGrey[300],
          ),
          Container(
            width: width,
            padding: EdgeInsets.only(
              left: ScreenUtil.instance.setWidth(5),
            ),
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

    Widget _flatButton({IconData icon, String text, Function onPressed}) {
      return Container(
        height: ScreenUtil.instance.setHeight(25),
        child: FlatButton.icon(
          onPressed: onPressed,
          icon: Icon(
            icon,
            size: ScreenUtil.instance.setSp(15),
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

    var textContainerWidth = MediaQuery.of(context).size.width -
        (MediaQuery.of(context).size.width / 4 +
            34 +
            ScreenUtil.instance.setWidth(10) * 2 +
            5 +
            20);

    return Container(
      margin: EdgeInsets.symmetric(
          vertical: ScreenUtil.instance.setHeight(8), horizontal: 12.0),
      padding: EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
      child: InkWell(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: ScreenUtil.instance.setHeight(25),
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil.instance.setWidth(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        AppLocalizations.of(context)
                            .tr(_serviceCategory.serviceName),
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        Utils.getServiceDate(
                            serviceDetail.startDate, serviceDetail.endDate),
                        style: TextStyle(
                          fontSize: ScreenUtil.instance.setSp(14.0),
                          color: Colors.blueGrey[300],
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),
                Row(
                  children: <Widget>[
                    Image.asset(
                      _serviceCategory.imgURL,
                      width: MediaQuery.of(context).size.width / 4,
                      height: MediaQuery.of(context).size.width / 6,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _iconAndText(
                            Icons.location_on,
                            serviceDetail.address,
                            textContainerWidth,
                          ),
                          SizedBox(
                            height: ScreenUtil.instance.setHeight(
                              10,
                            ),
                          ),
                          _iconAndText(
                            Icons.date_range,
                            Utils.getServiceType(serviceDetail.type, context) +
                                ": " +
                                Utils.getServiceTime(serviceDetail.startTime,
                                    serviceDetail.endTime),
                            textContainerWidth,
                          ),
                          SizedBox(
                            height: ScreenUtil.instance.setHeight(
                              10,
                            ),
                          ),
                          _iconAndText(
                            Icons.person,
                            serviceDetail.maid.name,
                            textContainerWidth,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(),
                Container(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        NumberFormat.currency(locale: "vi-vn")
                            .format(serviceDetail.amount),
                        style: TextStyle(
                          fontSize: ScreenUtil.instance.setSp(14.0),
                        ),
                      ),
                      isHelper
                          ? Row(
                              children: <Widget>[
                                _flatButton(
                                    icon: Icons.history,
                                    text: AppLocalizations.of(context)
                                        .tr("repick")),
                                _flatButton(
                                  icon: Icons.details,
                                  text: AppLocalizations.of(context).tr("view"),
                                  onPressed: () {
                                    print(serviceDetail.id);
                                    Navigator.pushNamed(
                                      context,
                                      serviceStatusRoute,
                                      arguments: serviceDetail.id,
                                    );
                                  },
                                ),
                              ],
                            )
                          : Row(
                              children: <Widget>[
                                _flatButton(
                                    icon: Icons.history,
                                    text: AppLocalizations.of(context)
                                        .tr("accept")),
                                _flatButton(
                                  icon: Icons.details,
                                  text: AppLocalizations.of(context).tr("deny"),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          onTap: () {}),
    );
  }
}
