import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:smart_rabbit/models/user_maid.dart';

import '../widgets/booking_step_title.dart';
import '../widgets/booking_bottom_bar.dart';
import '../widgets/user_avatar.dart';
import '../models/service_details.dart';
import '../utils/utils.dart';
import '../services/booking.dart';

class VerifyBookingScreen extends StatefulWidget {
  @override
  _VerifyBookingScreenState createState() => _VerifyBookingScreenState();
}

class _VerifyBookingScreenState extends State<VerifyBookingScreen> {
  void _onSubmit(ServiceDetails data) async {
    var res = await BookingService.booking(data);
    if (res['isValid']) {
      Navigator.pushAndRemoveUntil();
      Utils.showSuccessSnackbar(context, AppLocalizations.of(context).tr('booked_successfully'),);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ServiceDetails _data = ModalRoute.of(context).settings.arguments;
    var data = EasyLocalizationProvider.of(context).data;

    double defaultScreenWidth = 400.0;
    double defaultScreenHeight = 810.0;
    ScreenUtil.instance = ScreenUtil(
      width: defaultScreenWidth,
      height: defaultScreenHeight,
      allowFontScaling: true,
    )..init(context);

    var serviceFee = 0;
    if (_data.type == 1) {
      serviceFee = _data.maid != null
        ? (_data.endTime.difference(_data.startTime).inMinutes / 60 * _data.maid.salary).round()
        : 0;
    } else {
      final days = Utils.calculateIntervalDays(_data.startDate, _data.endDate, _data.interval);
      serviceFee = _data.maid != null
        ? (_data.endTime.difference(_data.startTime).inMinutes / 60 * _data.maid.salary * days).round()
        : 0;
    }

    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context).tr('service_details'),
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black, //change back button color
          ),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              BookingStepTitle(
                currentStep: 2,
              ),
              SizedBox(
                height: ScreenUtil.instance.setHeight(8.0),
              ),
              Divider(),
              SizedBox(
                height: ScreenUtil.instance.setHeight(8.0),
              ),
              
            ],
          ),
        ),
        bottomNavigationBar: BookingBottomBar(
          isVerify: true,
          onSubmit: () {
            _onSubmit(_data);
          },
        ),
      ),
    );
  }
}
