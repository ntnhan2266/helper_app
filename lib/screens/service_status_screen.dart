import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/easy_localization_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/service_detail_info.dart';
import '../models/service_details.dart';
import '../services/booking.dart';
import '../widgets/booking_status.dart';
import '../widgets/dialogs/cancel_booking_dialog.dart';
import '../utils/constants.dart';

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

  Widget _buildAction(BuildContext context, int status) {
    if (status == WAITING_APPROVE) {
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
