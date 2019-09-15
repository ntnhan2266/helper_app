import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';

import '../widgets/booking_step_title.dart';
import '../screens/choose_address_screen.dart';
import '../utils/constants.dart';
import '../services/permission.dart';

class ServiceDetailScreen extends StatefulWidget {
  @override
  _ServiceDetailScreenState createState() => _ServiceDetailScreenState();
}

class ServiceDetailsData {
  int type = 1;
  String address = '';
  String houseNumber = '';
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now();
  String note = '';
  double lat = 0;
  double long = 0;
  Map<String, bool> interval = {
    'mon': false,
    'tue': false,
    'wed': false,
    'thu': false,
    'fri': false,
    'sat': false,
    'sun': false
  };
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen> {
  ServiceDetailsData _data = ServiceDetailsData();
  final _form = GlobalKey<FormState>();
  final _startTimeController = TextEditingController();
  final _endTimeController = TextEditingController();
  final _addressController = TextEditingController();

  void _handleChangeType(int value) {
    setState(() {
      _data.type = value;
    });
  }

  void _handleChangeInterval(String index) {
    bool currentState = _data.interval[index];
    setState(() {
      _data.interval[index] = !currentState;
    });
  }

  void _getCurrentLocation() async {
    try {
      double lat = 21.0048;
      double long = 105.8453;

      final isGrantedPermission = await PermissionsService()
          .requestLocationPermission(onPermissionDenied: () {
        print('Can not get permission');
      });
      if (isGrantedPermission) {
        Position position = await Geolocator()
            .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        lat = position.latitude;
        long = position.longitude;
      }
      Map<String, dynamic> returnedData =
          await Navigator.push(context, MaterialPageRoute(builder: (context) {
        return ChooseAddressScreen(
          lat: lat,
          long: long,
        );
      }));
      if (returnedData != null) {
        _data.address = returnedData['address'];
        _data.lat = returnedData['lat'];
        _data.long = returnedData['long'];
        _addressController.text = _data.address;
      }
    } catch (e) {
      print(e);
    }
  }

  void _onSubmit() {
    if (_form.currentState.validate()) {}
  }

  InputDecoration _textFormFieldConfig(String hintText) {
    return InputDecoration(
      errorStyle: TextStyle(color: Colors.red),
      hintText: hintText,
      border: OutlineInputBorder(
        borderSide: BorderSide(width: 1, color: Colors.grey),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 1, color: Colors.red),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 1, color: Colors.grey),
      ),
      fillColor: Color.fromRGBO(0, 0, 0, 0.05),
      filled: true,
      contentPadding: EdgeInsets.all(
        ScreenUtil.instance.setSp(14.0),
      ),
    );
  }

  Widget _buildFixedTimeSelector() {
    return Column(
      children: <Widget>[
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
                width: ScreenUtil.instance.setHeight(LABEL_MARGIN),
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
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;
    _data.type = args['id'];

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
          key: _form,
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
                        onTap: () {
                          _getCurrentLocation();
                        },
                        child: TextFormField(
                          controller: _addressController,
                          enabled: false,
                          decoration: _textFormFieldConfig(
                            AppLocalizations.of(context).tr('choose_address'),
                          ),
                          style: TextStyle(
                            fontSize: ScreenUtil.instance.setSp(12.0),
                            color: Colors.black,
                          ),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return AppLocalizations.of(context)
                                  .tr('location_required');
                            }
                            return null;
                          },
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
                        decoration: _textFormFieldConfig(
                          AppLocalizations.of(context)
                              .tr('house_number_example'),
                        ),
                        style: TextStyle(
                          fontSize: ScreenUtil.instance.setSp(12.0),
                          color: Colors.black,
                        ),
                        onSaved: (String value) {
                          _data.houseNumber = value;
                        },
                        validator: (String value) {
                          if (value.isEmpty) {
                            return AppLocalizations.of(context)
                                .tr('house_required');
                          }
                          return null;
                        },
                      ),
                      // Depend on type

                      // Fixed time

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
                            initialTime: TimeOfDay.fromDateTime(
                                _data.startTime ?? DateTime.now()),
                          );
                          if (time != null) {
                            final format = DateFormat("HH:mm");
                            final now = DateTime.now();
                            final currentTime = new DateTime(
                              now.year,
                              now.month,
                              now.day,
                              time.hour,
                              time.minute,
                              0,
                              0,
                              0,
                            );
                            _startTimeController.text =
                                format.format(currentTime);
                            _data.startTime = currentTime;
                          }
                        },
                        child: TextFormField(
                          controller: _startTimeController,
                          enabled: false,
                          decoration: _textFormFieldConfig(
                            AppLocalizations.of(context).tr('choose_time'),
                          ),
                          style: TextStyle(
                            fontSize: ScreenUtil.instance.setSp(12.0),
                            color: Colors.black,
                          ),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return AppLocalizations.of(context)
                                  .tr('start_time_required');
                            }
                            return null;
                          },
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
                              Icons.timer_off,
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
                            initialTime: TimeOfDay.fromDateTime(
                                _data.endTime ?? DateTime.now()),
                          );
                          if (time != null) {
                            final format = DateFormat("HH:mm");
                            final now = DateTime.now();
                            final currentTime = new DateTime(
                                now.year,
                                now.month,
                                now.day,
                                time.hour,
                                time.minute,
                                0,
                                0,
                                0);
                            _endTimeController.text =
                                format.format(currentTime);
                            _data.endTime = currentTime;
                          }
                        },
                        child: TextFormField(
                          controller: _endTimeController,
                          enabled: false,
                          decoration: _textFormFieldConfig(
                            AppLocalizations.of(context).tr('choose_time'),
                          ),
                          style: TextStyle(
                            fontSize: ScreenUtil.instance.setSp(12.0),
                            color: Colors.black,
                          ),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return AppLocalizations.of(context)
                                  .tr('end_time_required');
                            }
                            if (_data.endTime.compareTo(_data.startTime) < 0) {
                              return AppLocalizations.of(context)
                                  .tr('end_time_have_to_after_start_time');
                            }
                            if (_data.endTime
                                    .difference(_data.startTime)
                                    .inHours <
                                1) {
                              return AppLocalizations.of(context).tr(
                                  'end_time_have_to_more_than_start_time_one_hour');
                            }
                            return null;
                          },
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
                              Icons.edit,
                              size: ScreenUtil.instance.setSp(16),
                              color: Color.fromRGBO(42, 77, 108, 1),
                            ),
                            SizedBox(
                              width:
                                  ScreenUtil.instance.setHeight(LABEL_MARGIN),
                            ),
                            Text(
                              AppLocalizations.of(context).tr('note'),
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
                            initialTime: TimeOfDay.fromDateTime(
                                _data.endTime ?? DateTime.now()),
                          );
                          if (time != null) {
                            final format = DateFormat("HH:mm");
                            final now = DateTime.now();
                            final currentTime = new DateTime(
                                now.year,
                                now.month,
                                now.day,
                                time.hour,
                                time.minute,
                                now.second,
                                now.millisecond,
                                now.microsecond);
                            _endTimeController.text =
                                format.format(currentTime);
                          }
                        },
                        child: TextFormField(
                          minLines: 4,
                          maxLines: 4,
                          decoration: _textFormFieldConfig(
                            AppLocalizations.of(context).tr('note_example'),
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
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(blurRadius: 10, color: Color.fromRGBO(0, 0, 0, 0.4))
          ]),
          padding: EdgeInsets.all(ScreenUtil.instance.setWidth(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                AppLocalizations.of(context).tr('service_fee'),
              ),
              Container(
                width: double.infinity,
                child: RaisedButton(
                  child: Text(
                    AppLocalizations.of(context).tr('next').toUpperCase(),
                  ),
                  color: Color.fromRGBO(42, 77, 108, 1),
                  textColor: Colors.white,
                  onPressed: () {
                    _onSubmit();
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
