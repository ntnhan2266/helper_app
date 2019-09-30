import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../models/service_details.dart';
import '../widgets/service_history_list_item.dart';

class ServiceHistoryList extends StatelessWidget {
  final List<ServiceDetails> serviceHistoty;

  ServiceHistoryList({this.serviceHistoty});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      color: Colors.blueGrey[50],
      child: serviceHistoty.length > 0
          ? ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: serviceHistoty.length,
              itemBuilder: (BuildContext context, int index) {
                ServiceDetails serviceDetail = serviceHistoty.toList()[index];
                return ServiceHistoryListItem(
                  serviceDetail,
                );
              },
            )
          : Center(
              child: Text(
                AppLocalizations.of(context).tr('no_data'),
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
    );
  }
}
