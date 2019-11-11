import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../models/notification.dart' as app;
import '../../models/service_category.dart';
import '../../services/notification.dart';
import '../../utils/dummy_data.dart';

class NotificationTab extends StatefulWidget {
  @override
  _NotificationTabState createState() => _NotificationTabState();
}

class _NotificationTabState extends State<NotificationTab> {
  List<app.Notification> _notifications = List();
  @override
  void initState() {
    super.initState();
    _getNotification();
  }

  void _getNotification() async {
    final res = await NotificationService.getNotification();
    if (res['isValid'] && mounted) {
      setState(() {
        _notifications.addAll(res['data']);
      });
    } else {
      throw Exception('Failed to load notification');
    }
  }

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
        child: _notifications.isEmpty
            ? Container(
                color: Colors.white,
                margin: EdgeInsets.symmetric(
                  vertical: ScreenUtil.instance.setHeight(2.0),
                  horizontal: ScreenUtil.instance.setWidth(5.0),
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/not_found.jpg',
                      width: MediaQuery.of(context).size.width * 0.5,
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20.0),
                      child:
                          Text(AppLocalizations.of(context).tr('no_content')),
                    )
                  ],
                ),
              )
            : ListView(
                children: _notifications.map((notification) {
                  ServiceCategory service = categoriesData.firstWhere(
                      (category) =>
                          notification.service.category == category.id);
                  return Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 2.0, horizontal: 5.0),
                    padding: EdgeInsets.symmetric(
                      vertical: ScreenUtil.instance.setHeight(15.0),
                    ),
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
                              height: MediaQuery.of(context).size.width / 6,
                            ),
                            Flexible(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: RichText(
                                      text: TextSpan(
                                        style: new TextStyle(
                                          fontSize:
                                              ScreenUtil.instance.setSp(15.0),
                                          color: Colors.black,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: notification.fromUser,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                AppLocalizations.of(context).tr(
                                              notification.message,
                                              args: [
                                                "",
                                                AppLocalizations.of(context).tr(
                                                    categoriesData
                                                        .firstWhere(
                                                            (category) =>
                                                                category.id ==
                                                                notification
                                                                    .service
                                                                    .category)
                                                        .serviceName),
                                              ],
                                            ),
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
                                              .format(notification.createdAt),
                                          style: TextStyle(
                                            fontSize:
                                                ScreenUtil.instance.setSp(14.0),
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
                }).toList(),
                // itemCount: _notifications.length,
                // itemBuilder: (BuildContext context, int index) {
                // ServiceCategory service = categoriesData.firstWhere((category) =>
                //     _notifications[index].service.category == category.id);
                // return Container(
                //   margin: EdgeInsets.symmetric(vertical: 2.0, horizontal: 5.0),
                //   padding: EdgeInsets.symmetric(
                //     vertical: ScreenUtil.instance.setHeight(15.0),
                //   ),
                //   decoration: BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: BorderRadius.circular(10.0)),
                //   child: InkWell(
                //     child: Container(
                //       child: Row(
                //         children: <Widget>[
                //           Image.asset(
                //             service.imgURL,
                //             width: MediaQuery.of(context).size.width / 4,
                //             height: MediaQuery.of(context).size.width / 6,
                //           ),
                //           Flexible(
                //             child: Column(
                //               mainAxisAlignment: MainAxisAlignment.center,
                //               children: <Widget>[
                //                 Container(
                //                   alignment: Alignment.centerLeft,
                //                   child: RichText(
                //                     text: TextSpan(
                //                       style: new TextStyle(
                //                         fontSize: ScreenUtil.instance.setSp(15.0),
                //                         color: Colors.black,
                //                       ),
                //                       children: [
                //                         TextSpan(
                //                           text: AppLocalizations.of(context)
                //                               .tr('service '),
                //                         ),
                //                         TextSpan(
                //                           text: AppLocalizations.of(context)
                //                               .tr(service.serviceName),
                //                           style: TextStyle(
                //                             fontWeight: FontWeight.w700,
                //                           ),
                //                         ),
                //                         TextSpan(
                //                           text: AppLocalizations.of(context)
                //                               .tr(' will-be-done'),
                //                         ),
                //                       ],
                //                     ),
                //                   ),
                //                 ),
                //                 SizedBox(height: 10),
                //                 Row(
                //                   children: <Widget>[
                //                     Icon(
                //                       Icons.date_range,
                //                       size: 13,
                //                       color: Colors.blueGrey[300],
                //                     ),
                //                     SizedBox(width: 3),
                //                     Container(
                //                       alignment: Alignment.centerLeft,
                //                       child: Text(
                //                         DateFormat('dd/MM/yyyy hh:mm')
                //                             .format(DateTime.now()),
                //                         style: TextStyle(
                //                           fontSize: ScreenUtil.instance.setSp(14.0),
                //                           color: Colors.blueGrey[300],
                //                         ),
                //                         maxLines: 1,
                //                         textAlign: TextAlign.left,
                //                       ),
                //                     ),
                //                   ],
                //                 ),
                //               ],
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //     onTap: () {},
                //   ),
                // );
                // },
              ),
      ),
    );
  }
}
