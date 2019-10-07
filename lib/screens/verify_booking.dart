import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/booking_step_title.dart';
import '../widgets/booking_bottom_bar.dart';
import '../models/service_details.dart';
import '../utils/utils.dart';
import '../services/booking.dart';
import '../utils/route_names.dart';
import '../widgets/service_detail_info.dart';

class VerifyBookingScreen extends StatefulWidget {
  @override
  _VerifyBookingScreenState createState() => _VerifyBookingScreenState();
}

class _VerifyBookingScreenState extends State<VerifyBookingScreen> {
  void _onSubmit(ServiceDetails data) async {
    var res = await BookingService.booking(data);
    if (res['isValid']) {
      Navigator.of(context).pushNamedAndRemoveUntil(homeScreenRoute, (Route<dynamic> route) => false);
      Navigator.pushNamed(context,
          serviceStatusRoute,
          arguments: res['data']['_id']);
      Utils.showSuccessSnackbar(
        context,
        AppLocalizations.of(context).tr('booked_successfully'),
      );
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
              ServiceDetailInfo(_data, false),
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
