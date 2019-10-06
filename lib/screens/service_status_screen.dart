import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/easy_localization_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/service_detail_info.dart';
import '../models/service_details.dart';
import '../services/booking.dart';
import '../widgets/booking_status.dart';

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
    final String id = ModalRoute.of(context).settings.arguments;
    return ServiceStatus(
      service: fetchData(id),
      id: id,
    );
  }
}

class ServiceStatus extends StatelessWidget {
  final Future<ServiceDetails> service;
  final String id;

  ServiceStatus({Key key, this.service, this.id}) : super(key: key);

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
                    BookingStatus(data: snapshot.data),
                    SizedBox(
                      height: ScreenUtil.instance.setHeight(8.0),
                    ),
                    Divider(),
                    SizedBox(
                      height: ScreenUtil.instance.setHeight(8.0),
                    ),
                    ServiceDetailInfo(snapshot.data),
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
