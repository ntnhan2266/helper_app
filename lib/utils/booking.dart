import 'package:flutter/material.dart';

import '../services/booking.dart';
import '../utils/route_names.dart';
import '../utils/utils.dart';
import '../widgets/dialogs/reject_booking_dialog.dart';
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

  static void denyBooking(BuildContext context, String id,
      {Function callback}) {
    showDialog(
      context: context,
      builder: (context) {
        return RejectBookingDialog((reason, content) async {
          var res = await BookingService.deny(
            id,
            reason,
            content,
          );
          if (res['isValid']) {
            Utils.showSuccessDialog(
              context,
              'deny_successfully',
              newScreen: callback == null ? helperManagementRoute : null,
              callback: callback,
            );
          } else {
            Utils.showSuccessDialog(context, 'something_went_wrong');
          }
        });
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
      Utils.showSuccessDialog(context, 'something_went_wrong');
    }
  }
}
