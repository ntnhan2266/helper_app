import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';

class BookingStatus extends StatelessWidget {
  final int status;

  BookingStatus({this.status});

  Widget _buildTitle(BuildContext context) {
    switch (status) {
      case WAITING_APPROVE:
        return Text(
          AppLocalizations.of(context).tr('waiting_for_approve')
        );
      default:
        return Text(
          AppLocalizations.of(context).tr('updating'),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        _buildTitle(context),
      ],
    );
  }
}
