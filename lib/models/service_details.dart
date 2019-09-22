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

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'address': address,
      'houseNumber': houseNumber,
      'startTime': startTime.toString(),
      'endTime': endTime.toString(),
      'note': note,
      'lat': lat,
      'long': long,
      'interval': interval,
      'startDate': startDate.toString(),
      'endDate': endDate.toString(),
      'maid': maid,
    };
  }
}