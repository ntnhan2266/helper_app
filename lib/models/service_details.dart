import 'package:intl/intl.dart';
import 'package:smart_rabbit/utils/utils.dart';

import '../models/user_maid.dart';
import '../models/user.dart';

class ServiceDetails {
  String id;
  String category = '';
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
  User createdBy;
  int reason;
  String content = '';
  bool canReview = false;

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
      this.amount,
      this.createdBy,
      this.reason,
      this.content,
      this.canReview,
    });

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
      'startDate': DateFormat('MM-dd-yyyy').format(startDate),
      'endDate':
          endDate != null ? DateFormat('MM-dd-yyyy').format(endDate) : null,
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
      startTime: DateTime.parse(json['startTime']).toLocal(),
      endTime: DateTime.parse(json['endTime']).toLocal(),
      note: json['note'],
      lat: json['lat'],
      long: json['long'],
      startDate: DateTime.parse(json['startDate']).toLocal(),
      endDate: DateTime.parse(json['endDate']).toLocal(),
      maid: json['maid'] != null ? UserMaid.getMaid(json['maid']) : null,
      amount: json['amount'],
      createdBy: json['createdBy'] != null ? User().getData(json['createdBy']) : null,
      reason: json['reason'],
      content: json['content'],
      canReview: json['canReview']
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
      startTime: DateTime.parse(json['startTime']).toLocal(),
      endTime: DateTime.parse(json['endTime']).toLocal(),
      note: json['note'],
      lat: json['lat'],
      long: json['long'],
      workingDates: json['interval'] != null ? json['interval']['days'].cast<DateTime>() : [],
      interval: json['interval'] != null ? Map<String, bool>.from(json['interval']['options']) : null,
      startDate: DateTime.parse(json['startDate']).toLocal(),
      endDate: DateTime.parse(json['endDate']).toLocal(),
      maid: UserMaid.getMaid(json['maid']),
      amount: json['amount'],
      createdBy: User().getData(json['createdBy']),
      reason: json['reason'],
      content: json['content'],
      canReview: json['canReview']
    );
  }
}
