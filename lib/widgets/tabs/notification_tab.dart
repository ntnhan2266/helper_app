import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/notification.dart' as app;
import '../../models/category_list.dart';
import '../../models/category.dart';
import '../../services/notification.dart';
import '../../configs/api.dart';

class NotificationTab extends StatefulWidget {
  final Function countNotification;

  const NotificationTab({this.countNotification});

  @override
  _NotificationTabState createState() => _NotificationTabState();
}

class _NotificationTabState extends State<NotificationTab> {
  List<app.Notification> _notifications = List();
  int _pageIndex = 0;
  bool _isLoading = true;
  bool _canLoadMore = true;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _getNotification();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getNotification();
      }
    });
  }

  void _getNotification() async {
    if (!_canLoadMore || !mounted) {
      return;
    }
    setState(() {
      _isLoading = true;
    });
    // await Future.delayed(Duration(milliseconds: 1500));
    final res = await NotificationService.getNotification(
      pageIndex: _pageIndex,
      pageSize: 12,
    );
    if (res['isValid'] && mounted) {
      setState(() {
        _notifications..addAll(res['data']);
        _pageIndex++;
        _isLoading = false;
      });
    } else if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _getLoading() {
    return _isLoading
        ? Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20.0,
                    horizontal: 10.0,
                  ),
                  child: Text(AppLocalizations.of(context).tr("loading")),
                ),
              ],
            ),
          )
        : Container();
  }

  void _markAsRead() async {
    final res = await NotificationService.markAsRead();
    if (res['isValid'] && mounted) {
      setState(() {
        _notifications = List();
        _isLoading = true;
        _pageIndex = 1;
      });
      widget.countNotification();
      _getNotification();
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoryListProvider =
        Provider.of<CategoryList>(context, listen: false);
    final categoriesData = categoryListProvider.categories;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context).tr('notification'),
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.done_all,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: _markAsRead,
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 5.0),
        color: Colors.blueGrey[50],
        child: _notifications.isEmpty && !_isLoading
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
                controller: _scrollController,
                children: _notifications.map((notification) {
                  Category service = categoriesData.firstWhere((category) =>
                      notification.service.category == category.id);
                  return Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 2.0, horizontal: 5.0),
                    padding: EdgeInsets.symmetric(
                      vertical: ScreenUtil.instance.setHeight(15.0),
                      horizontal: ScreenUtil.instance.setHeight(5.0),
                    ),
                    decoration: BoxDecoration(
                        color: notification.isRead
                            ? Colors.white
                            : Colors.grey[100],
                        borderRadius: BorderRadius.circular(10.0)),
                    child: InkWell(
                      child: Container(
                        child: Row(
                          children: <Widget>[
                            service.icon != null
                                ? Image.network(
                                    APIConfig.hostURL + service.icon,
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    height:
                                        MediaQuery.of(context).size.width / 6,
                                  )
                                : Image.asset(
                                    'assets/images/category.png',
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    height:
                                        MediaQuery.of(context).size.width / 6,
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
                                                        .nameVi),
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
                }).toList()
                  ..add(_getLoading()),
              ),
      ),
    );
  }
}
