import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../utils/booking.dart';
import '../models/category.dart';
import '../models/category_list.dart';
import '../models/service_details.dart';
import '../utils/utils.dart';
import '../utils/route_names.dart';
import '../configs/api.dart';

class ServiceHistoryListItem extends StatelessWidget {
  final ServiceDetails serviceDetail;
  final bool isHelper;
  final Function callback;

  const ServiceHistoryListItem(this.serviceDetail,
      {this.isHelper = false, this.callback});

  @override
  Widget build(BuildContext context) {
    final categoryListProvider =
        Provider.of<CategoryList>(context, listen: false);
    final categoriesData = categoryListProvider.categories;
    Category _serviceCategory = categoriesData
        .firstWhere((category) => category.id == serviceDetail.category);

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
              },
            ),
            _flatButton(
              icon: Icons.close,
              text: AppLocalizations.of(context).tr("deny"),
              onPressed: () {
                Booking.cancelBooking(context, serviceDetail.id,
                    callback: callback, isHelper: true);
              },
            ),
          ],
        );
      } else if (serviceDetail.status == 2) {
        return Row(
          children: <Widget>[
            _flatButton(
              icon: Icons.check,
              text: AppLocalizations.of(context).tr("completed"),
              onPressed: () {
                Booking.doneBooking(context, serviceDetail.id,
                    callback: callback);
              },
            ),
            _flatButton(
              icon: Icons.close,
              text: AppLocalizations.of(context).tr("cancel"),
              onPressed: () {
                Booking.cancelBooking(context, serviceDetail.id,
                    callback: callback, isHelper: true);
              },
            ),
          ],
        );
      } else {
        return Container();
      }
    }

    Widget _buildUserAction() {
      if (serviceDetail.status == 1 || serviceDetail.status == 2) {
        return Row(
          children: <Widget>[
            _flatButton(
              icon: Icons.close,
              text: AppLocalizations.of(context).tr("cancel"),
              onPressed: () {
                Booking.cancelBooking(context, serviceDetail.id,
                    callback: callback, isHelper: false);
              },
            ),
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
                      Localizations.localeOf(context).languageCode == "en"
                          ? _serviceCategory.nameEn
                          : _serviceCategory.nameVi,
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
                  _serviceCategory.icon != null
                  ? Image.network(
                    APIConfig.hostURL + _serviceCategory.icon,
                    width: MediaQuery.of(context).size.width / 5,
                    height: MediaQuery.of(context).size.width / 5,
                  )
                  : Image.asset(
                    'assets/images/category.png',
                    width: MediaQuery.of(context).size.width / 5,
                    height: MediaQuery.of(context).size.width / 5,
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
                    isHelper ? _buildHelperAction() : _buildUserAction(),
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
