import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/easy_localization_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../widgets/service_detail_info.dart';
import '../models/service_details.dart';
import '../services/booking.dart';
import '../widgets/booking_status.dart';
import '../widgets/dialogs/cancel_booking_dialog.dart';
import '../widgets/dialogs/reject_booking_dialog.dart';
import '../utils/constants.dart';
import '../utils/route_names.dart';

Future<ServiceDetails> fetchData(String id) async {
  final res = await BookingService.getBookingById(id);
  if (res['isValid']) {
    var service = ServiceDetails.getData(res['data']);
    return service;
  } else {
    throw Exception('Failed to load post');
  }
}

class ServiceStatusScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;
    final String id = args['id'];
    final bool isHelper = args['isHelper'];
    return ServiceStatus(service: fetchData(id), id: id, isHelper: isHelper);
  }
}

class ServiceStatus extends StatelessWidget {
  final Future<ServiceDetails> service;
  final String id;
  final bool isHelper;

  ServiceStatus({Key key, this.service, this.id, this.isHelper = false})
      : super(key: key);

  void _handleCancelBooking() {
    return;
  }

  void _handleCustomerCancel(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return CancelBookingDialog(_handleCancelBooking);
      },
    );
  }

  void _denyBooking(BuildContext context) {
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
            Fluttertoast.showToast(
              msg: AppLocalizations.of(context).tr('deny_successfully'),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
              backgroundColor: Color.fromRGBO(75, 181, 67, 1),
              textColor: Colors.white,
              fontSize: ScreenUtil.instance.setSp(14),
            );
            Navigator.of(context).pushReplacementNamed(helperManagementRoute);
          } else {
            Fluttertoast.showToast(
              msg: AppLocalizations.of(context).tr('error'),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
              backgroundColor: Color.fromRGBO(165, 0, 0, 1),
              textColor: Colors.white,
              fontSize: ScreenUtil.instance.setSp(14),
            );
          }
        });
      },
    );
  }

  void _approveBooking(BuildContext context) async {
    var res = await BookingService.approve(id);
    if (res['isValid']) {
      Fluttertoast.showToast(
        msg: AppLocalizations.of(context).tr('approved_successfully'),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Color.fromRGBO(75, 181, 67, 1),
        textColor: Colors.white,
        fontSize: ScreenUtil.instance.setSp(14),
      );
      Navigator.of(context).pushReplacementNamed(helperManagementRoute);
    } else {
      Fluttertoast.showToast(
        msg: AppLocalizations.of(context).tr('error'),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Color.fromRGBO(165, 0, 0, 1),
        textColor: Colors.white,
        fontSize: ScreenUtil.instance.setSp(14),
      );
    }
  }

  void _completeBooking(BuildContext context) async {
    var res = await BookingService.complete(id);
    if (res['isValid']) {
      Fluttertoast.showToast(
        msg: AppLocalizations.of(context).tr('complete_successfully'),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Color.fromRGBO(75, 181, 67, 1),
        textColor: Colors.white,
        fontSize: ScreenUtil.instance.setSp(14),
      );
      Navigator.of(context).pushReplacementNamed(helperManagementRoute);
    } else {
      Fluttertoast.showToast(
        msg: AppLocalizations.of(context).tr('error'),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Color.fromRGBO(165, 0, 0, 1),
        textColor: Colors.white,
        fontSize: ScreenUtil.instance.setSp(14),
      );
    }
  }

  Widget _buildWatingApproveAction(BuildContext context, int status) {
    // Customer
    if (!isHelper) {
      return InkWell(
        onTap: () {
          _handleCustomerCancel(context);
        },
        child: Container(
          padding: EdgeInsets.all(ScreenUtil.instance.setWidth(10)),
          margin: EdgeInsets.symmetric(
              horizontal: ScreenUtil.instance.setWidth(12)),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              width: 1,
              color: Color.fromRGBO(165, 0, 0, 1),
            ),
            borderRadius: BorderRadius.circular(3),
          ),
          child: Text(
            AppLocalizations.of(context).tr('cancel').toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color.fromRGBO(165, 0, 0, 1),
            ),
          ),
        ),
      );
    } else {
      return Column(
        children: <Widget>[
          InkWell(
            onTap: () {
              _approveBooking(context);
            },
            child: Container(
              padding: EdgeInsets.all(ScreenUtil.instance.setWidth(10)),
              margin: EdgeInsets.symmetric(
                  horizontal: ScreenUtil.instance.setWidth(12)),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color.fromRGBO(75, 181, 67, 1),
                border: Border.all(
                  width: 1,
                  color: Color.fromRGBO(75, 181, 67, 1),
                ),
                borderRadius: BorderRadius.circular(3),
              ),
              child: Text(
                AppLocalizations.of(context).tr('approve').toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(
            height: ScreenUtil.instance.setHeight(20),
          ),
          InkWell(
            onTap: () {
              _denyBooking(context);
            },
            child: Container(
              padding: EdgeInsets.all(ScreenUtil.instance.setWidth(10)),
              margin: EdgeInsets.symmetric(
                  horizontal: ScreenUtil.instance.setWidth(12)),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                border:
                    Border.all(width: 1, color: Color.fromRGBO(165, 0, 0, 1)),
                borderRadius: BorderRadius.circular(3),
              ),
              child: Text(
                AppLocalizations.of(context).tr('cancel').toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromRGBO(165, 0, 0, 1),
                ),
              ),
            ),
          ),
        ],
      );
    }
  }

  void _handlePaidConfirm(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            AppLocalizations.of(context).tr('confirm'),
          ),
          content: Text(
            AppLocalizations.of(context).tr('complete_confirm_hint'),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: Text(
                AppLocalizations.of(context).tr('close'),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(
                AppLocalizations.of(context).tr('confirm'),
              ),
              onPressed: () {
                _completeBooking(context);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildApproveAction(BuildContext context, int status) {
    if (isHelper) {
      return InkWell(
        onTap: () {
          _handlePaidConfirm(context);
        },
        child: Container(
          padding: EdgeInsets.all(ScreenUtil.instance.setWidth(10)),
          margin: EdgeInsets.symmetric(
              horizontal: ScreenUtil.instance.setWidth(12)),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color.fromRGBO(75, 181, 67, 1),
            borderRadius: BorderRadius.circular(3),
          ),
          child: Text(
            AppLocalizations.of(context).tr('complete_confirm').toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _buildAction(BuildContext context, int status) {
    if (status == WAITING_APPROVE) {
      return _buildWatingApproveAction(context, status);
    } else if (status == APPROVED) {
      return _buildApproveAction(context, status);
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
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
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w300,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black, //change back button color
          ),
          elevation: 0,
        ),
        body: FutureBuilder<ServiceDetails>(
          future: service,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Status
                    BookingStatus(data: snapshot.data, isHelper: isHelper),
                    SizedBox(
                      height: ScreenUtil.instance.setHeight(8.0),
                    ),
                    Divider(),
                    SizedBox(
                      height: ScreenUtil.instance.setHeight(8.0),
                    ),
                    ServiceDetailInfo(snapshot.data, isHelper),
                    _buildAction(context, snapshot.data.status),
                    SizedBox(
                      height: ScreenUtil.instance.setHeight(20),
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  AppLocalizations.of(context).tr('has_error_when_load_data'),
                ),
              );
            }
            // By default, show a loading spinner.
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
