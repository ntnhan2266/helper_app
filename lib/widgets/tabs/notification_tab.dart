import 'dart:math';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:smart_rabbit/models/service_category.dart';

import '../../utils/dummy_data.dart';

class NotificationTab extends StatefulWidget {
  @override
  _NotificationTabState createState() => _NotificationTabState();
}

class _NotificationTabState extends State<NotificationTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context).tr('notification'),
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 5.0),
        color: Colors.blueGrey[50],
        child: ListView.builder(
          primary: false,
          shrinkWrap: true,
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            ServiceCategory service =
                categoriesData[new Random().nextInt(categoriesData.length)];
            return Container(
              margin: EdgeInsets.symmetric(vertical: 2.0, horizontal: 5.0),
              padding: EdgeInsets.symmetric(vertical: 5.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0)),
              child: InkWell(
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Image.asset(
                        service.imgURL,
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
                              child: RichText(
                                text: TextSpan(
                                  style: new TextStyle(
                                    fontSize: ScreenUtil.instance.setSp(15.0),
                                    color: Colors.black,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: AppLocalizations.of(context)
                                          .tr('service '),
                                    ),
                                    TextSpan(
                                      text: AppLocalizations.of(context)
                                          .tr(service.serviceName),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    TextSpan(
                                      text: AppLocalizations.of(context)
                                          .tr(' will-be-done'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.date_range,
                                  size: 13,
                                  color: Colors.blueGrey[300],
                                ),
                                SizedBox(width: 3),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    DateFormat('dd/MM/yyyy hh:mm')
                                        .format(DateTime.now()),
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
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {},
              ),
            );
          },
        ),
      ),
    );
  }
}
