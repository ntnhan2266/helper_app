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
                  AppLocalizations.of(context).tr('completed'),
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
                    
        },
      ),
    );
  }
}
