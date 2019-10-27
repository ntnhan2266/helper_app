import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:flutter/material.dart';

import '../widgets/dialogs/cancel_booking_dialog.dart';
import '../services/booking.dart';
import '../utils/route_names.dart';
import '../utils/utils.dart';
import '../widgets/components/color_loader.dart';

class Booking {
  static void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: ColorLoader(),
        );
      },
    );
  }

  static void cancelBooking(BuildContext context, String id,
      {Function callback, bool isHelper = false}) {
    showDialog(
      context: context,
      builder: (context) {
        return CancelBookingDialog(
          isHelper: isHelper,
          handleCancel: (reason, content) async {
            var res = await BookingService.cancel(
              id,
              reason,
              content,
              isHelper,
            );
            if (res['isValid']) {
              Utils.showSuccessDialog(
                context,
                'cancel_successfully',
                newScreen: callback == null ? helperManagementRoute : null,
                callback: callback,
              );
            } else {
              Utils.showErrorDialog(context, 'something_went_wrong');
            }
          },
        );
      },
    );
  }

  static void approveBooking(BuildContext context, String id,
      {Function callback}) async {
    var res = await BookingService.approve(id);
    if (res['isValid']) {
      Utils.showSuccessDialog(
        context,
        'approved_successfully',
        newScreen: callback == null ? helperManagementRoute : null,
        callback: callback,
      );
    } else {
      Utils.showErrorDialog(context, 'something_went_wrong');
    }
  }

  static void doneBooking(BuildContext context, String id,
      {Function callback}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context).tr('confirm')),
          content:
              Text(AppLocalizations.of(context).tr('complete_confirm_hint')),
          actions: <Widget>[
            FlatButton(
              child: Text(AppLocalizations.of(context).tr('close')),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(AppLocalizations.of(context).tr('confirm')),
              onPressed: () async {
                Navigator.of(context).pop();
                var res = await BookingService.complete(id);
                if (res['isValid']) {
                  Utils.showSuccessDialog(
                    context,
                    'complete_successfully',
                    newScreen: callback == null ? helperManagementRoute : null,
                    callback: callback,
                  );
                } else {
                  Utils.showErrorDialog(context, 'something_went_wrong');
                }
              },
            ),
          ],
        );
      },
    );
  }
}
