import 'dart:math';

import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/service_category.dart';
import '../../utils/dummy_data.dart';

class ServiceHistoryTab extends StatefulWidget {
  @override
  _ServiceHistoryTabState createState() => _ServiceHistoryTabState();
}

class _ServiceHistoryTabState extends State<ServiceHistoryTab> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BubbleTabIndicator(
              indicatorHeight: 40.0,
              indicatorColor: Colors.blueGrey[50],
              tabBarIndicatorSize: TabBarIndicatorSize.tab,
            ),
            labelColor: Theme.of(context).primaryColor,
            labelStyle: TextStyle(fontWeight: FontWeight.w500),
            unselectedLabelColor: Colors.black,
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w400),
            tabs: [
              Tab(
                child: Text(
                  AppLocalizations.of(context).tr('all'),
                  textAlign: TextAlign.center,
                ),
              ),
              Tab(
                child: Text(
                  AppLocalizations.of(context).tr('on-going'),
                  textAlign: TextAlign.center,
                ),
              ),
              Tab(
                child: Text(
                  AppLocalizations.of(context).tr('done'),
                  textAlign: TextAlign.center,
                ),
              ),
              Tab(
                child: Text(
                  AppLocalizations.of(context).tr('canceled'),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          centerTitle: true,
          title: Text(
            AppLocalizations.of(context).tr('history'),
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: TabBarView(
          children: [
            _dumpData(),
            _dumpData(),
            _dumpData(),
            _dumpData(),
          ],
        ),
      ),
    );
  }

  Widget _dumpData() {
    return Container(
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
              borderRadius: BorderRadius.circular(10.0)
            ),
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
                            child: Text(
                              AppLocalizations.of(context)
                                  .tr(service.serviceName),
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
        },
      ),
    );
  }
}
