import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/service_details.dart';
import '../models/user_maid.dart';
import '../models/user.dart';
import '../widgets/user_avatar.dart';
import '../utils/utils.dart';
import '../utils/route_names.dart';
import '../models/category_list.dart';
import '../models/category.dart';

class ServiceDetailInfo extends StatelessWidget {
  final ServiceDetails _data;
  final bool isHelper;

  ServiceDetailInfo(this._data, this.isHelper);

  Widget _buildDetailItem(BuildContext context, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
        ),
        SizedBox(
          height: ScreenUtil.instance.setHeight(8),
        ),
        Text(
          value,
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: ScreenUtil.instance.setHeight(14),
        ),
      ],
    );
  }

  Widget _buildHostInfo(BuildContext context, UserMaid maid) {
    final numericFormatter = new NumberFormat("#,###", "en_US");
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(helperDetailRoute, arguments: maid.id);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            AppLocalizations.of(context).tr('maid'),
          ),
          SizedBox(
            height: ScreenUtil.instance.setHeight(10),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: ScreenUtil.instance.setWidth(50),
                height: ScreenUtil.instance.setWidth(50),
                child: UserAvatar(maid.avatar),
              ),
              SizedBox(
                width: ScreenUtil.instance.setWidth(20),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      maid.name,
                      style: TextStyle(fontSize: ScreenUtil.instance.setSp(14)),
                    ),
                    SizedBox(
                      height: ScreenUtil.instance.setHeight(12),
                    ),
                    Text(
                      numericFormatter.format(maid.salary) + ' VND/h',
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerInfo(BuildContext context, User user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          AppLocalizations.of(context).tr('customer'),
        ),
        SizedBox(
          height: ScreenUtil.instance.setHeight(10),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: ScreenUtil.instance.setWidth(50),
              height: ScreenUtil.instance.setWidth(50),
              child: UserAvatar(user.avatar),
            ),
            SizedBox(
              width: ScreenUtil.instance.setWidth(20),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    user.name,
                    style: TextStyle(fontSize: ScreenUtil.instance.setSp(14)),
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget _buildPriceBlock(BuildContext context, int price) {
    final numericFormatter = new NumberFormat("#,###", "en_US");

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          AppLocalizations.of(context).tr('service_price'),
        ),
        SizedBox(
          height: ScreenUtil.instance.setHeight(20),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              AppLocalizations.of(context).tr('work_fee'),
            ),
            Text(
              numericFormatter.format(price.round()),
            ),
          ],
        ),
        SizedBox(
          height: ScreenUtil.instance.setHeight(15),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              AppLocalizations.of(context).tr('service_fee'),
            ),
            Text(
              numericFormatter.format((price * 0.1).round()),
            ),
          ],
        ),
        SizedBox(
          height: ScreenUtil.instance.setHeight(15),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              AppLocalizations.of(context).tr('total'),
            ),
            Text(
              numericFormatter.format((price * 1.1).round()),
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: ScreenUtil.instance.setSp(14),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildIntervalInfo(
    BuildContext context,
    DateTime startDate,
    DateTime endDate,
    Map<String, bool> interval,
  ) {
    var intervalText = '';
    if (interval['mon']) {
      intervalText += AppLocalizations.of(context).tr('monday') + ', ';
    }
    if (interval['tue']) {
      intervalText += AppLocalizations.of(context).tr('tueday') + ', ';
    }
    if (interval['wed']) {
      intervalText += AppLocalizations.of(context).tr('wednesday') + ', ';
    }
    if (interval['thu']) {
      intervalText += AppLocalizations.of(context).tr('thursday') + ', ';
    }
    if (interval['fri']) {
      intervalText += AppLocalizations.of(context).tr('friday') + ', ';
    }
    if (interval['sat']) {
      intervalText += AppLocalizations.of(context).tr('saturday') + ', ';
    }
    if (interval['sun']) {
      intervalText += AppLocalizations.of(context).tr('sunday') + ', ';
    }
    intervalText = intervalText.substring(0, intervalText.length - 2);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          AppLocalizations.of(context).tr('start_date'),
        ),
        SizedBox(
          height: ScreenUtil.instance.setHeight(8),
        ),
        Text(
          DateFormat('dd-MM-yyyy').format(startDate),
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: ScreenUtil.instance.setHeight(14),
        ),
        Text(
          AppLocalizations.of(context).tr('end_date'),
        ),
        SizedBox(
          height: ScreenUtil.instance.setHeight(8),
        ),
        Text(
          DateFormat('dd-MM-yyyy').format(endDate),
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: ScreenUtil.instance.setHeight(14),
        ),
        Text(
          AppLocalizations.of(context).tr('interval_days'),
        ),
        SizedBox(
          height: ScreenUtil.instance.setHeight(8),
        ),
        Text(
          intervalText,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: ScreenUtil.instance.setHeight(14),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final categoryListProvider =
        Provider.of<CategoryList>(context, listen: false);
    final categoriesData = categoryListProvider.categories;
    var serviceFee = 0;
    if (_data.type == 1) {
      serviceFee = _data.maid != null
          ? (_data.endTime.difference(_data.startTime).inMinutes /
                  60 *
                  _data.maid.salary)
              .round()
          : 0;
    } else {
      final days = Utils.calculateIntervalDays(
          _data.startDate, _data.endDate, _data.interval);
      serviceFee = _data.maid != null
          ? (_data.endTime.difference(_data.startTime).inMinutes /
                  60 *
                  _data.maid.salary *
                  days)
              .round()
          : 0;
    }
    final int categoryIndex =
        categoriesData.indexWhere((item) => item.id == _data.category);
    final Category category = categoriesData[categoryIndex];

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil.instance.setWidth(18.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildDetailItem(
            context,
            AppLocalizations.of(context).tr('category'),
            Localizations.localeOf(context).languageCode == "en" ? category.nameEn : category.nameVi,
          ),
          _buildDetailItem(
            context,
            AppLocalizations.of(context).tr('work_location'),
            _data.address,
          ),
          _buildDetailItem(
            context,
            AppLocalizations.of(context).tr('house_number'),
            _data.houseNumber,
          ),
          _data.type == 1
              ? _buildDetailItem(
                  context,
                  AppLocalizations.of(context).tr('working_date'),
                  DateFormat('dd-MM-yyyy').format(_data.startDate),
                )
              : _buildIntervalInfo(
                  context, _data.startDate, _data.endDate, _data.interval),
          _buildDetailItem(
            context,
            AppLocalizations.of(context).tr('start_time'),
            DateFormat('HH:mm').format(_data.startTime),
          ),
          _buildDetailItem(
            context,
            AppLocalizations.of(context).tr('end_time'),
            DateFormat('HH:mm').format(_data.endTime),
          ),
          _buildDetailItem(
            context,
            AppLocalizations.of(context).tr('note'),
            _data.note != null ? _data.note : '--',
          ),
          isHelper
              ? _buildCustomerInfo(context, _data.createdBy)
              : _buildHostInfo(context, _data.maid),
          SizedBox(
            height: ScreenUtil.instance.setHeight(20),
          ),
          _buildPriceBlock(context, serviceFee),
          SizedBox(
            height: ScreenUtil.instance.setHeight(20),
          ),
        ],
      ),
    );
  }
}
