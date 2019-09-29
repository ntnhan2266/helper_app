import 'package:intl/intl.dart';
import 'package:smart_rabbit/utils/utils.dart';

import '../models/user_maid.dart';

class ServiceDetails {
  String id;
  int category = 1;
  int type = 1;
  int status = 0;
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
  DateTime startDate;
  DateTime endDate;
  UserMaid maid;
  List<DateTime> workingDates = [];
  int amount;

  ServiceDetails(
      {this.type = 1,
      this.category,
      this.id,
      this.workingDates,
      this.status = 0,
      this.address,
      this.houseNumber,
      this.startTime,
      this.endTime,
      this.note,
      this.lat,
      this.long,
      this.interval,
      this.startDate,
      this.endDate,
      this.maid,
      this.amount});

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'category': category,
      'status': status,
      'address': address,
      'houseNumber': houseNumber,
      'startTime': startTime.toString(),
      'endTime': endTime.toString(),
      'note': note,
      'lat': lat,
      'long': long,
      'interval': interval,
      'startDate': DateFormat('dd-MM-yyyy').format(startDate),
      'endDate':
          endDate != null ? DateFormat('dd-MM-yyyy').format(endDate) : null,
      'maid': maid.id,
      'workingDates': type == 2
          ? Utils.getIntervalDayList(startDate, endDate, interval)
          : null,
    };
  }

  factory ServiceDetails.fromJson(Map<String, dynamic> json) {
    return ServiceDetails(
      id: json['_id'],
      category: json['category'],
      type: json['type'],
      status: json['status'],
      address: json['address'],
      houseNumber: json['houseNumber'],
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
      note: json['note'],
      lat: json['lat'],
      long: json['long'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      maid: UserMaid.getMaid(json['maid']),
    );
  }

  static ServiceDetails getData(Map<String, dynamic> json) {
    return ServiceDetails(
      id: json['_id'],
      type: json['type'],
      category: json['category'],
      status: json['status'],
      address: json['address'],
      houseNumber: json['houseNumber'],
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
      note: json['note'],
      lat: json['lat'],
      long: json['long'],
      workingDates: json['interval']['days'].cast<DateTime>(),
      interval: Map<String, bool>.from(json['interval']['options']),
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      maid: UserMaid.getMaid(json['maid']),
    );
  }
}
