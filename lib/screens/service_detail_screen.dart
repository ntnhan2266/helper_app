import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/booking_step_title.dart';
import '../utils/route_names.dart';

class ServiceDetailScreen extends StatefulWidget {
  @override
  _ServiceDetailScreenState createState() => _ServiceDetailScreenState();
}

class ServiceDetailsData {
  int type = 1;
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen> {
  ServiceDetailsData _data = ServiceDetailsData();

  void _handleChangeType(int value) {
    setState(() {
      _data.type = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;
    final serviceId = args['id'];

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
            BookingStepTitle(
              currentStep: 0,
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil.instance.setWidth(8.0),
              ),
              child: Form(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      RadioListTile(
                        title: Text(
                          AppLocalizations.of(context).tr('retail_use'),
                        ),
                        subtitle: Text(
                          AppLocalizations.of(context).tr('retail_use_content'),
                        ),
                        value: 1,
                        groupValue: _data.type,
                        onChanged: _handleChangeType,
                      ),
                      RadioListTile(
                        title: Text(
                          AppLocalizations.of(context).tr('periodic'),
                        ),
                        subtitle: Text(
                          AppLocalizations.of(context).tr('periodic_content'),
                        ),
                        value: 2,
                        groupValue: _data.type,
                        onChanged: _handleChangeType,
                      ),
                      // Build retail_use
                      
                      // End Build retail_use
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(ScreenUtil.instance.setWidth(10)),
          child: RaisedButton(
            child: Text(
              AppLocalizations.of(context).tr('next').toUpperCase(),
            ),
            color: Color.fromRGBO(42, 77, 108, 1),
            textColor: Colors.white,
            onPressed: () {
              Navigator.pushNamed(context, chooseMaidRoute);
            },
          ),
        ),
      ),
    );
  }
}
