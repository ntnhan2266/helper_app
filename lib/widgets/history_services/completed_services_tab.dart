import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import '../../models/service_details.dart';
import '../../widgets/service_history_list.dart';
import '../../services/booking.dart';
import '../../utils/constants.dart';

Future<List<ServiceDetails>> fetchService() async {
  var completer = new Completer<List<ServiceDetails>>();
  final res = await BookingService.getBookingsByStatus(WAITING_APPROVE);
  if (res['isValid']) {
    print(res['data'][0]);
    completer.complete(res['data']);
  } else {
    completer.complete([]);
  }
  return completer.future;
}

class CompletedServicesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CompletedService(
      services: fetchService(),
    );
  }
}

class CompletedService extends StatelessWidget {
  final Future<List<ServiceDetails>> services;

  CompletedService({this.services});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ServiceDetails>>(
      future: services,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ServiceHistoryList(
            serviceHistoty: snapshot.data,
          );
        } else if (snapshot.hasError) {
          return Center(child: Text("${snapshot.error}"));
        }
        // By default, show a loading spinner.
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
