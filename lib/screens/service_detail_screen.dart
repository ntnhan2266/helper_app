import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';

import '../widgets/booking_step_title.dart';
import '../screens/choose_address_screen.dart';
import '../utils/constants.dart';
import '../services/permission.dart';
import '../models/service_details.dart';
import '../utils/route_names.dart';
import '../widgets/booking_bottom_bar.dart';
import '../widgets/service_interval.dart';
import '../widgets/form/text_form_field_configs.dart';

class ServiceDetailScreen extends StatefulWidget {
  @override
  _ServiceDetailScreenState createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen> {
  ServiceDetails _data = ServiceDetails();
  final _form = GlobalKey<FormState>();
  final _startTimeController = TextEditingController();
  final _endTimeController = TextEditingController();
  final _addressController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  bool intervalError = false;

  void _handleChangeType(int value) {
    setState(() {
      _data.type = value;
      _data.startDate = null;
      _data.endDate = null;
    });
    _startDateController.text = '';
    _endDateController.text = '';
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
    if (_form.currentState.validate()) {
      if (_data.type == 2 &&
          !_data.interval['mon'] &&
          !_data.interval['tue'] &&
          !_data.interval['wed'] &&
          !_data.interval['thu'] &&
          !_data.interval['fri'] &&
          !_data.interval['sat'] &&
          !_data.interval['sun']) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            // return object of type Dialog
            return AlertDialog(
              title: Text(
                AppLocalizations.of(context).tr('please_choose_interval'),
                style: TextStyle(
                  fontSize: ScreenUtil.instance.setSp(14.0),
                  color: Colors.red,
                ),
              ),
              actions: <Widget>[
                // usually buttons at the bottom of the dialog
                FlatButton(
                  color: Colors.red,
                  child: Text(
                    AppLocalizations.of(context).tr('ok'),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: ScreenUtil.instance.setSp(12.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
        setState(() {
          intervalError = true;
        });
        return;
      }
      setState(() {
        intervalError = false;
      });

      // Form is valid
      _form.currentState.save();
      Navigator.pushNamed(
        context,
        chooseMaidRoute,
        arguments: _data,
      );
    }
  }

  Widget _buildLabel(IconData icon, String labelText) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(
        bottom: ScreenUtil.instance.setHeight(LABEL_MARGIN),
      ),
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            size: ScreenUtil.instance.setSp(16),
            color: Color.fromRGBO(42, 77, 108, 1),
          ),
          SizedBox(
            width: ScreenUtil.instance.setHeight(LABEL_MARGIN),
          ),
          Text(
            labelText,
            style: TextStyle(
              fontSize: ScreenUtil.instance.setSp(12.0),
            ),
          ),
        ],
      ),
    );
  }

  Future<Null> _selectStartDate() async {
    var now = DateTime.now();
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _data.startDate != null ? _data.startDate : DateTime.now(),
        firstDate: DateTime.parse(DateFormat('yyyy-MM-dd').format(now)),
        lastDate: DateTime(2100));
    print(picked);
    if (picked != null && picked != _data.startDate) {
      setState(() {
        _data.startDate = picked;
      });
      _startDateController.text = DateFormat('dd-MM-yyyy').format(picked);
    }
  }

  Future<Null> _selectEndDate() async {
    var now = DateTime.now();
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _data.startDate != null ? _data.startDate : DateTime.now(),
        firstDate: DateTime.parse(DateFormat('yyyy-MM-dd').format(now)),
        lastDate: DateTime(2100));
    if (picked != null && picked != _data.startDate) {
      setState(() {
        _data.endDate = picked;
      });
      _endDateController.text = DateFormat('dd-MM-yyyy').format(picked);
    }
  }

  Widget _buildFixedTimeSelector() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: ScreenUtil.instance.setHeight(20.0),
        ),
        _buildLabel(
          Icons.date_range,
          AppLocalizations.of(context).tr('working_date'),
        ),
        InkWell(
          onTap: _selectStartDate,
          child: TextFormField(
            controller: _startDateController,
            enabled: false,
            decoration: textFormFieldConfig(
              AppLocalizations.of(context).tr('choose_date'),
            ),
            style: TextStyle(
              fontSize: ScreenUtil.instance.setSp(12.0),
              color: Colors.black,
            ),
            validator: (String value) {
              if (value.isEmpty) {
                return AppLocalizations.of(context).tr('date_required');
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildIntervalSelector() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: ScreenUtil.instance.setHeight(20.0),
        ),
        _buildLabel(
          Icons.date_range,
          AppLocalizations.of(context).tr('weeky_interval'),
        ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil.instance.setWidth(5.0),
            vertical: ScreenUtil.instance.setWidth(10.0),
          ),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: intervalError ? Colors.red : Color.fromRGBO(0, 0, 0, 0.05),
            ),
            borderRadius: BorderRadius.circular(5.0),
            color: Color.fromRGBO(0, 0, 0, 0.05),
          ),
          child: Column(
            children: <Widget>[
              ServiceInterval(
                data: _data.interval,
                handleClick: _handleChangeInterval,
              ),
              SizedBox(
                height: ScreenUtil.instance.setHeight(8.0),
              ),
              InkWell(
                onTap: _selectStartDate,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil.instance.setWidth(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        AppLocalizations.of(context).tr('start_date'),
                        style: TextStyle(
                          fontSize: ScreenUtil.instance.setSp(12.0),
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil.instance.setHeight(8.0),
                      ),
                      TextFormField(
                        controller: _startDateController,
                        enabled: false,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(0),
                          errorStyle: TextStyle(color: Colors.red),
                          border: InputBorder.none,
                          hintText:
                              AppLocalizations.of(context).tr('choose_date'),
                          hintStyle: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                        style: TextStyle(
                            fontSize: ScreenUtil.instance.setSp(12.0),
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return AppLocalizations.of(context)
                                .tr('date_required');
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: ScreenUtil.instance.setHeight(20.0),
              ),
              InkWell(
                onTap: _selectEndDate,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil.instance.setWidth(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        AppLocalizations.of(context).tr('end_date'),
                        style: TextStyle(
                          fontSize: ScreenUtil.instance.setSp(12.0),
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil.instance.setHeight(8.0),
                      ),
                      TextFormField(
                        controller: _endDateController,
                        enabled: false,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(0),
                          errorStyle: TextStyle(color: Colors.red),
                          border: InputBorder.none,
                          hintText:
                              AppLocalizations.of(context).tr('choose_date'),
                          hintStyle: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                        style: TextStyle(
                            fontSize: ScreenUtil.instance.setSp(12.0),
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return AppLocalizations.of(context)
                                .tr('date_required');
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
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
                      _buildLabel(
                        Icons.location_on,
                        AppLocalizations.of(context).tr('work_location'),
                      ),
                      InkWell(
                        onTap: () {
                          _getCurrentLocation();
                        },
                        child: TextFormField(
                          controller: _addressController,
                          enabled: false,
                          decoration: textFormFieldConfig(
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
                      _buildLabel(
                        Icons.home,
                        AppLocalizations.of(context).tr('house_number'),
                      ),
                      TextFormField(
                        enabled: true,
                        decoration: textFormFieldConfig(
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
                      _data.type == 1
                          // Fixed time
                          ? _buildFixedTimeSelector()
                          // Interval
                          : _buildIntervalSelector(),

                      SizedBox(
                        height: ScreenUtil.instance.setHeight(20.0),
                      ),
                      _buildLabel(
                        Icons.timer,
                        AppLocalizations.of(context).tr('start_time'),
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
                          decoration: textFormFieldConfig(
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
                      _buildLabel(
                        Icons.timer_off,
                        AppLocalizations.of(context).tr('end_time'),
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
                          decoration: textFormFieldConfig(
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
                      _buildLabel(
                        Icons.edit,
                        AppLocalizations.of(context).tr('note'),
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
                          decoration: textFormFieldConfig(
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
        bottomNavigationBar: BookingBottomBar(
          onSubmit: _onSubmit,
        ),
      ),
    );
  }
}
