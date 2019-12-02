import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import '../../widgets/components/service_history_tab.dart';

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
            isScrollable: true,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BubbleTabIndicator(
                indicatorHeight: 40.0,
                indicatorColor: Colors.blueGrey[50],
                tabBarIndicatorSize: TabBarIndicatorSize.tab,
                padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 0.0)),
            labelColor: Theme.of(context).primaryColor,
            labelStyle: TextStyle(fontWeight: FontWeight.w600),
            unselectedLabelColor: Colors.black.withOpacity(0.7),
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w400),
            tabs: [
              Tab(
                child: Text(
                  AppLocalizations.of(context).tr('waiting'),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13),
                ),
              ),
              Tab(
                child: Text(
                  AppLocalizations.of(context).tr('on-going'),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13),
                ),
              ),
              Tab(
                child: Text(
                  AppLocalizations.of(context).tr('completed'),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13),
                ),
              ),
              Tab(
                child: Text(
                  AppLocalizations.of(context).tr('canceled'),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13),
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
            ServiceHistoryData(WAITING_APPROVE),
            ServiceHistoryData(APPROVED),
            ServiceHistoryData(COMPLETED),
            ServiceHistoryData(CANCELLED),
          ],
        ),
      ),
    );
  }
}
