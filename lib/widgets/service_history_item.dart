import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/service_details.dart';
import '../utils/dummy_data.dart';

class ServiceHistoryItem extends StatelessWidget {
  final ServiceDetails service;

  ServiceHistoryItem({this.service});

  @override
  Widget build(BuildContext context) {
    final int categoryIndex =
        categoriesData.indexWhere((item) => item.id == service.type);
    final category = categoriesData[categoryIndex];
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.0, horizontal: 5.0),
      padding: EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
      child: InkWell(
        child: Container(
          child: Row(
            children: <Widget>[
              Image.asset(
                category.imgURL,
                width: MediaQuery.of(context).size.width / 4,
                height: MediaQuery.of(context).size.width / 4,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 3 / 4 - 30,
                padding: EdgeInsets.only(left: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        AppLocalizations.of(context).tr(category.serviceName),
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: ScreenUtil.instance.setSp(15.0),
                        ),
                        maxLines: 2,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(height: 3),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.location_on,
                          size: 13,
                          color: Colors.blueGrey[300],
                        ),
                        SizedBox(width: 3),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Quận 5, HCM",
                            style: TextStyle(
                              fontSize: ScreenUtil.instance.setSp(14.0),
                              color: Colors.blueGrey[300],
                            ),
                            maxLines: 1,
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "100\$",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: ScreenUtil.instance.setSp(14.0),
                        ),
                        maxLines: 1,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        onTap: () {},
      ),
    );
  }
}
