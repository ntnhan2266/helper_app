import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_rabbit/models/service_category.dart';

import '../../utils/route_names.dart';

class ServiceCategoryItem extends StatelessWidget {
  final int id;
  final String imgURL;
  final String serviceName;

  const ServiceCategoryItem(
      {@required this.id, @required this.serviceName, this.imgURL});

  @override
  Widget build(BuildContext context) {
    double defaultScreenWidth = 400.0;
    double defaultScreenHeight = 810.0;
    ScreenUtil.instance = ScreenUtil(
      width: defaultScreenWidth,
      height: defaultScreenHeight,
      allowFontScaling: true,
    )..init(context);

    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            serviceDetailRoute,
            arguments: {
              'serviceCategory': ServiceCategory(
                  id: id, serviceName: serviceName, imgURL: imgURL),
            },
          );
        },
        child: new Card(
          elevation: 5.0,
          child: new Container(
            padding: EdgeInsets.all(
              ScreenUtil.instance.setWidth(5.0),
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  imgURL,
                  width: ScreenUtil.instance.setWidth(100.0),
                  height: ScreenUtil.instance.setWidth(100.0),
                ),
                SizedBox(
                  height: ScreenUtil.instance.setHeight(5.0),
                ),
                Text(
                  AppLocalizations.of(context).tr(serviceName).toUpperCase(),
                  style: TextStyle(
                    fontSize: ScreenUtil.instance.setSp(16.0),
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(42, 77, 108, 1),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
