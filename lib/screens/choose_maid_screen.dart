import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/booking_step_title.dart';
import '../utils/route_names.dart';

class ChooseMaidScreen extends StatefulWidget {
  @override
  _ChooseMaidScreenState createState() => _ChooseMaidScreenState();
}

class _ChooseMaidScreenState extends State<ChooseMaidScreen> {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;

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
        body: Column(
          children: <Widget>[
            BookingStepTitle(currentStep: 1,),
            SizedBox(height: 10,),
            Text('2'),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: RaisedButton(
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text('Next'),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, verifyBookingRoute);
                },
              ),
            ),
          ],
        )
      ),
    );
  }
} 
