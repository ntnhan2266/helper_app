import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../utils/booking.dart';
import '../models/service_category.dart';
import '../models/service_details.dart';
import '../utils/dummy_data.dart';
import '../utils/utils.dart';
import '../utils/route_names.dart';

class ServiceHistoryListItem extends StatelessWidget {
  final ServiceDetails serviceDetail;
  final bool isHelper;
  final Function callback;

  const ServiceHistoryListItem(this.serviceDetail,
      {this.isHelper = false, this.callback});

  @override
  Widget build(BuildContext context) {
    ServiceCategory _serviceCategory = categoriesData[serviceDetail.category];

    Widget _iconAndText(IconData icon, String text) {
      return Row(
        children: <Widget>[
          Icon(
            icon,
            size: ScreenUtil.instance.setSp(13.0),
            color: Colors.blueGrey[300],
          ),
          Flexible(
            child: Container(
              padding: EdgeInsets.only(
                left: ScreenUtil.instance.setWidth(5),
                top: ScreenUtil.instance.setWidth(2),
                bottom: ScreenUtil.instance.setWidth(2),
              ),
              child: Text(
                text,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: ScreenUtil.instance.setSp(14.0),
                  color: Colors.blueGrey[300],
                ),
              ),
            ),
          ),
        ],
      );
    }

    Widget _flatButton({IconData icon, String text, Function onPressed}) {
      return Container(
        child: FlatButton.icon(
          padding: EdgeInsets.all(ScreenUtil.instance.setWidth(5)),
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

    Widget _buildHelperAction() {
      if (serviceDetail.status == 1) {
        return Row(
          children: <Widget>[
            _flatButton(
                icon: Icons.check,
                text: AppLocalizations.of(context).tr("accept"),
                onPressed: () {
                  Booking.approveBooking(context, serviceDetail.id,
                      callback: callback);
                }),
            _flatButton(
                icon: Icons.close,
                text: AppLocalizations.of(context).tr("deny"),
                onPressed: () {
                  Booking.denyBooking(context, serviceDetail.id,
                      callback: callback);
                }),
          ],
        );
      } else {
        return Container();
      }
    }

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: ScreenUtil.instance.setHeight(2.0),
        horizontal: ScreenUtil.instance.setWidth(5.0),
      ),
      padding: EdgeInsets.only(
        top: ScreenUtil.instance.setHeight(5),
        left: ScreenUtil.instance.setHeight(5),
        right: ScreenUtil.instance.setHeight(5),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.blueGrey[50]),
      ),
      child: InkWell(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: ScreenUtil.instance.setHeight(10),
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
                      Utils.getServiceDate(serviceDetail.type,
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
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _iconAndText(
                          Icons.location_on,
                          serviceDetail.address,
                        ),
                        _iconAndText(
                          Icons.date_range,
                          Utils.getServiceType(serviceDetail.type, context) +
                              ": " +
                              Utils.getServiceTime(serviceDetail.startTime,
                                  serviceDetail.endTime),
                        ),
                        _iconAndText(
                          Icons.person,
                          isHelper
                              ? serviceDetail.createdBy.name
                              : serviceDetail.maid.name,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Divider(),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil.instance.setWidth(12)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding:
                          EdgeInsets.all(ScreenUtil.instance.setWidth(8.0)),
                      child: Text(
                        NumberFormat.currency(locale: "vi-vn")
                            .format(serviceDetail.amount),
                        style: TextStyle(
                          fontSize: ScreenUtil.instance.setSp(14.0),
                        ),
                      ),
                    ),
                    isHelper
                        ? _buildHelperAction()
                        : Row(
                            children: <Widget>[
                              _flatButton(
                                  icon: Icons.history,
                                  text: AppLocalizations.of(context)
                                      .tr("repick")),
                            ],
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            serviceStatusRoute,
            arguments: {
              'id': serviceDetail.id,
              'isHelper': isHelper,
            },
          );
        },
      ),
    );
  }
}
