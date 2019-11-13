import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/easy_localization_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/service_details.dart';
import '../services/booking.dart';
import '../widgets/service_detail_info.dart';
import '../widgets/booking_status.dart';
import '../utils/constants.dart';
import '../utils/booking.dart';

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

  Widget _flatButton(
      {String text,
      Function onTap,
      Color backgroundColor,
      Color borderColor,
      Color textColor}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(ScreenUtil.instance.setWidth(10)),
        margin:
            EdgeInsets.symmetric(horizontal: ScreenUtil.instance.setWidth(12)),
        width: double.infinity,
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.white,
          border: Border.all(
            width: 1,
            color: borderColor ?? Color.fromRGBO(165, 0, 0, 1),
          ),
          borderRadius: BorderRadius.circular(3),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor ?? Color.fromRGBO(165, 0, 0, 1),
          ),
        ),
      ),
    );
  }

  Widget _buildHelperAction(BuildContext context, int status) {
    if (status == 1) {
      return Column(
        children: <Widget>[
          _flatButton(
            text: AppLocalizations.of(context).tr("accept"),
            backgroundColor: Theme.of(context).primaryColor,
            borderColor: Theme.of(context).primaryColor,
            textColor: Colors.white,
            onTap: () {
              Booking.approveBooking(context, id,
                  callback: () => Navigator.pop(context));
            },
          ),
          SizedBox(height: 5.0),
          _flatButton(
            text: AppLocalizations.of(context).tr("deny"),
            onTap: () {
              Booking.cancelBooking(context, id,
                  isHelper: true, callback: () => Navigator.pop(context));
            },
          ),
        ],
      );
    } else if (status == 2) {
      return Column(
        children: <Widget>[
          _flatButton(
            text: AppLocalizations.of(context).tr("completed"),
            backgroundColor: Theme.of(context).primaryColor,
            borderColor: Theme.of(context).primaryColor,
            textColor: Colors.white,
            onTap: () {
              Booking.doneBooking(context, id,
                  callback: () => Navigator.pop(context));
            },
          ),
          SizedBox(height: 5.0),
          _flatButton(
            text: AppLocalizations.of(context).tr("cancel"),
            onTap: () {
              Booking.cancelBooking(context, id,
                  isHelper: true, callback: () => Navigator.pop(context));
            },
          ),
        ],
      );
    } else {
      return Container();
    }
  }

  Widget _buildUserAction(BuildContext context, int status) {
    if (status == 1 || status == 2) {
      return Column(
        children: <Widget>[
          _flatButton(
            text: AppLocalizations.of(context).tr("cancel"),
            onTap: () {
              Booking.cancelBooking(context, id,
                  isHelper: false, callback: () => Navigator.pop(context));
            },
          ),
        ],
      );
    } else {
      return Container();
    }
  }

  Widget _buildAction(BuildContext context, int status) {
    // if (status == WAITING_APPROVE) {
    //   return _buildWatingApproveAction(context, status);
    // } else if (status == APPROVED) {
    //   return _buildApproveAction(context, status);
    // } else {
    //   return Container();
    // }
    if (isHelper)
      return _buildHelperAction(context, status);
    else
      return _buildUserAction(context, status);
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
