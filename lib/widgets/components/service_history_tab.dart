import 'package:flutter/material.dart';

import '../../widgets/service_history_list.dart';

class ServiceHistoryData extends StatelessWidget {
  final int status;

  ServiceHistoryData(this.status);

  @override
  Widget build(BuildContext context) {
    return ServiceHistoryList(status);
  }
}
