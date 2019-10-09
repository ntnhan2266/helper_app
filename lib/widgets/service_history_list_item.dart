import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/service_category.dart';
import '../models/service_details.dart';
import '../services/booking.dart';
import '../utils/dummy_data.dart';
import '../utils/utils.dart';
import '../utils/route_names.dart';
import '../widgets/dialogs/reject_booking_dialog.dart';

class ServiceHistoryListItem extends StatelessWidget {
  final ServiceDetails serviceDetail;
  final bool isHelper;
  final Function callback;

  const ServiceHistoryListItem(this.serviceDetail,
      {this.isHelper = false, this.callback});

  void _approveBooking(BuildContext context) async {
    var res = await BookingService.approve(serviceDetail.id);
    if (res['isValid']) {
      Fluttertoast.showToast(
        msg: AppLocalizations.of(context).tr('approved_successfully'),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Color.fromRGBO(75, 181, 67, 1),
        textColor: Colors.white,
        fontSize: ScreenUtil.instance.setSp(14),
      );
      callback();
    }
  }

  void _denyBooking(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return RejectBookingDialog((reason, content) async {
          var res =
              await BookingService.deny(serviceDetail.id, reason, content,);
          if (res['isValid']) {
            Fluttertoast.showToast(
              msg: AppLocalizations.of(context).tr('deny_successfully'),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
              backgroundColor: Color.fromRGBO(75, 181, 67, 1),
              textColor: Colors.white,
              fontSize: ScreenUtil.instance.setSp(14),
            );
            callback();
          }
        });
      },
    );
  }

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

    var textContainerWidth = MediaQuery.of(context).size.width -
        (MediaQuery.of(context).size.width / 4 +
            34 +
            ScreenUtil.instance.setWidth(10) * 2 +
            5 +
            20);

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: ScreenUtil.instance.setHeight(8),
        horizontal: ScreenUtil.instance.setWidth(12),
      ),
      padding: EdgeInsets.symmetric(vertical: ScreenUtil.instance.setHeight(5)),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
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
                          isHelper
                              ? serviceDetail.createdBy.name
                              : serviceDetail.maid.name,
                          textContainerWidth,
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
                                  icon: Icons.check,
                                  text:
                                      AppLocalizations.of(context).tr("accept"),
                                  onPressed: () {
                                    _approveBooking(context);
                                  }),
                              _flatButton(
                                  icon: Icons.close,
                                  text: AppLocalizations.of(context).tr("deny"),
                                  onPressed: () {
                                    _denyBooking(context);
                                  }),
                            ],
                          )
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
