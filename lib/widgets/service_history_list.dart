import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../models/service_details.dart';
import '../widgets/service_history_list_item.dart';
import '../services/booking.dart';

class ServiceHistoryList extends StatefulWidget {
  final int status;
  final bool isHelper;

  ServiceHistoryList(this.status, {this.isHelper = false});

  @override
  _ServiceHistoryListState createState() => _ServiceHistoryListState();
}

class _ServiceHistoryListState extends State<ServiceHistoryList> {
  List<ServiceDetails> serviceHistoty = [];
  int pageIndex = 0;
  bool isLoading = true;
  bool canLoadMore = true;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Set event
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _fetchService(widget.status, isHelper: widget.isHelper);
      }
    });
    _fetchService(widget.status, isHelper: widget.isHelper);
  }

  void _itemCallback() {
    setState(() {
      isLoading = true;
      serviceHistoty = [];
      pageIndex = 1;
      canLoadMore = true;
    });
    _fetchService(widget.status, isHelper: widget.isHelper);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _fetchService(int status, {bool isHelper = false}) async {
    if (!canLoadMore) {
      return;
    }
    var res;
    if (isHelper) {
      res = await BookingService.getHostBookingsByStatus(
        status,
        pageIndex: pageIndex,
      );
    } else {
      res = await BookingService.getBookingsByStatus(
        status,
        pageIndex: pageIndex,
      );
    }
    if (res['isValid']) {
      if (mounted) {
        setState(() {
          serviceHistoty..addAll(res['data']);
          if (serviceHistoty.length == res['total']) {
            canLoadMore = false;
          }
          isLoading = false;
          pageIndex++;
        });
      }
    }
  }

  Widget _buildHistoryData() {
    return serviceHistoty.length > 0
        ? ListView.builder(
            primary: false,
            controller: _scrollController,
            shrinkWrap: true,
            itemCount: serviceHistoty.length,
            itemBuilder: (BuildContext context, int index) {
              ServiceDetails serviceDetail = serviceHistoty.toList()[index];
              return ServiceHistoryListItem(
                serviceDetail,
                isHelper: widget.isHelper,
                callback: _itemCallback,
              );
            },
          )
        : Center(
            child: Text(
              AppLocalizations.of(context).tr('no_data'),
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      color: Colors.blueGrey[50],
      child: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _buildHistoryData(),
    );
  }
}
