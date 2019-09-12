import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

import '../widgets/booking_step_title.dart';
import '../utils/route_names.dart';
import '../utils/constants.dart';

class ServiceDetailScreen extends StatefulWidget {
  @override
  _ServiceDetailScreenState createState() => _ServiceDetailScreenState();
}

class ServiceDetailsData {
  int type = 1;
  String houseNumber = '';
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen> {
  ServiceDetailsData _data = ServiceDetailsData();
  final _startTimeController = TextEditingController();
  final _endTimeController = TextEditingController();

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
        body: Form(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                BookingStepTitle(
                  currentStep: 0,
                ),
                Divider(),
                Padding(
                  padding: EdgeInsets.all(14),
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
                      SizedBox(
                        height: ScreenUtil.instance.setHeight(LABEL_MARGIN),
                      ),
                      // -- Common
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(
                          bottom: ScreenUtil.instance.setHeight(LABEL_MARGIN),
                        ),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.location_on,
                              size: ScreenUtil.instance.setSp(16),
                              color: Color.fromRGBO(42, 77, 108, 1),
                            ),
                            SizedBox(
                              width:
                                  ScreenUtil.instance.setHeight(LABEL_MARGIN),
                            ),
                            Text(
                              AppLocalizations.of(context).tr('work_location'),
                              style: TextStyle(
                                fontSize: ScreenUtil.instance.setSp(12.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        child: TextFormField(
                          enabled: false,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.grey),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.grey),
                            ),
                            fillColor: Color.fromRGBO(0, 0, 0, 0.05),
                            filled: true,
                            contentPadding: EdgeInsets.all(
                              ScreenUtil.instance.setSp(14.0),
                            ),
                          ),
                          initialValue: 'KTX Khu A',
                          style: TextStyle(
                            fontSize: ScreenUtil.instance.setSp(12.0),
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil.instance.setHeight(20.0),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(
                          bottom: ScreenUtil.instance.setHeight(LABEL_MARGIN),
                        ),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.home,
                              size: ScreenUtil.instance.setSp(16),
                              color: Color.fromRGBO(42, 77, 108, 1),
                            ),
                            SizedBox(
                              width:
                                  ScreenUtil.instance.setHeight(LABEL_MARGIN),
                            ),
                            Text(
                              AppLocalizations.of(context).tr('house_number'),
                              style: TextStyle(
                                fontSize: ScreenUtil.instance.setSp(12.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextFormField(
                        enabled: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.grey),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.grey),
                          ),
                          fillColor: Color.fromRGBO(0, 0, 0, 0.05),
                          filled: true,
                          contentPadding: EdgeInsets.all(
                            ScreenUtil.instance.setSp(14.0),
                          ),
                        ),
                        style: TextStyle(
                          fontSize: ScreenUtil.instance.setSp(12.0),
                          color: Colors.black,
                        ),
                        onSaved: (String value) {
                          _data.houseNumber = value;
                        },
                      ),
                      SizedBox(
                        height: ScreenUtil.instance.setHeight(20.0),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(
                          bottom: ScreenUtil.instance.setHeight(LABEL_MARGIN),
                        ),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.timer,
                              size: ScreenUtil.instance.setSp(16),
                              color: Color.fromRGBO(42, 77, 108, 1),
                            ),
                            SizedBox(
                              width:
                                  ScreenUtil.instance.setHeight(LABEL_MARGIN),
                            ),
                            Text(
                              AppLocalizations.of(context).tr('start_time'),
                              style: TextStyle(
                                fontSize: ScreenUtil.instance.setSp(12.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          final time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(_data.startTime ?? DateTime.now()),
                          );
                          final format = DateFormat("HH:mm");
                          final now = DateTime.now();
                          final currentTime = new DateTime(now.year, now.month, now.day, time.hour, time.minute, now.second, now.millisecond, now.microsecond);
                          _startTimeController.text = format.format(currentTime);
                        },
                        child: TextFormField(
                          controller: _startTimeController,
                          enabled: false,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.grey),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.grey),
                            ),
                            fillColor: Color.fromRGBO(0, 0, 0, 0.05),
                            filled: true,
                            contentPadding: EdgeInsets.all(
                              ScreenUtil.instance.setSp(14.0),
                            ),
                          ),
                          style: TextStyle(
                            fontSize: ScreenUtil.instance.setSp(12.0),
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil.instance.setHeight(20.0),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(
                          bottom: ScreenUtil.instance.setHeight(LABEL_MARGIN),
                        ),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.timer,
                              size: ScreenUtil.instance.setSp(16),
                              color: Color.fromRGBO(42, 77, 108, 1),
                            ),
                            SizedBox(
                              width:
                                  ScreenUtil.instance.setHeight(LABEL_MARGIN),
                            ),
                            Text(
                              AppLocalizations.of(context).tr('end_time'),
                              style: TextStyle(
                                fontSize: ScreenUtil.instance.setSp(12.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          final time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(_data.endTime ?? DateTime.now()),
                          );
                          final format = DateFormat("HH:mm");
                          final now = DateTime.now();
                          final currentTime = new DateTime(now.year, now.month, now.day, time.hour, time.minute, now.second, now.millisecond, now.microsecond);
                          _endTimeController.text = format.format(currentTime);
                        },
                        child: TextFormField(
                          controller: _endTimeController,
                          enabled: false,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.grey),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.grey),
                            ),
                            fillColor: Color.fromRGBO(0, 0, 0, 0.05),
                            filled: true,
                            contentPadding: EdgeInsets.all(
                              ScreenUtil.instance.setSp(14.0),
                            ),
                          ),
                          style: TextStyle(
                            fontSize: ScreenUtil.instance.setSp(12.0),
                            color: Colors.black,
                          ),
                        ),
                      ),

                      SizedBox(
                        height: ScreenUtil.instance.setHeight(20.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(blurRadius: 10, color: Color.fromRGBO(0, 0, 0, 0.4))]
          ),
          padding: EdgeInsets.all(ScreenUtil.instance.setWidth(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Ghi chú'),
              Container(
                width: double.infinity,
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
            ],
          ),
        ),
      ),
    );
  }
}
