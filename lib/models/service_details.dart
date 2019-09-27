import 'package:intl/intl.dart';
import 'package:smart_rabbit/utils/utils.dart';

import '../models/user_maid.dart';

class ServiceDetails {
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
  DateTime startDate;
  DateTime endDate;
  UserMaid maid;

  ServiceDetails({
    this.type = 1,
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
    this.maid
  });

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'address': address,
      'houseNumber': houseNumber,
      'startTime': startTime.toString(),
      'endTime': endTime.toString(),
      'note': note,
      'lat': lat,
      'long': long,
      'interval': type == 2 ? Utils.getIntervalDayList(startDate, endDate, interval) : null,
      'startDate': DateFormat('dd-MM-yyyy').format(startDate),
      'endDate': endDate != null ? DateFormat('dd-MM-yyyy').format(endDate) : null,
      'maid': maid.id,
    };
  }


}
