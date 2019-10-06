import 'package:flutter/material.dart';

import '../../widgets/service_history_list.dart';

class ServiceHistoryData extends StatelessWidget {
  final int status;
  final bool isHelper;

  ServiceHistoryData(this.status, {this.isHelper = false});

  @override
  Widget build(BuildContext context) {
    return ServiceHistoryList(
      status,
      isHelper: isHelper,
    );
  }
}
