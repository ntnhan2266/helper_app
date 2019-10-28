import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()

class User with ChangeNotifier {
  String id;
  String uid;
  String name;
  String email;
  int gender;
  DateTime birthday;
  String phoneNumber;
  double long;
  double lat;
  String address;
  String avatar;

  User({
    this.id,
    this.uid,
    this.name,
    this.email,
    this.gender,
    this.birthday,
    this.phoneNumber,
    this.long,
    this.lat,
    this.address,
    this.avatar
  });

  void changeName(String name) {
    this.name = name;
    notifyListeners();
  }

  void changeEmail(String email) {
    this.email = email;
    notifyListeners();
  }

  void changeGender(int gender) {
    this.gender = gender;
    notifyListeners();
  }

  void changeBirthday(String birthday) {
    this.birthday = DateTime.parse(birthday);
    notifyListeners();
  }

  void changePhoneNumber(String phoneNumber) {
    this.phoneNumber = phoneNumber;
    notifyListeners();
  }

  void changeLongtitute(double long) {
    this.long = long;
    notifyListeners();
  }

  void changeLatatute(double lat) {
    this.lat = lat;
    notifyListeners();
  }

  void changeAddress(String address) {
    this.address = address;
    notifyListeners();
  }

  void fromJson(Map<String, dynamic> json) {
    this.id = json['_id'];
    this.uid = json['uid'];
    this.name = json['name'];
    this.email = json['email'];
    this.gender = json['gender'];
    this.birthday = DateTime.parse(json['birthday']).toLocal();
    this.phoneNumber = json['phoneNumber'];
    this.long = json['long'];
    this.lat = json['lat'];
    this.address = json['address'];
    this.avatar = json['avatar'];
    notifyListeners();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uid': uid,
      'name': name,
      'email': email,
      'gender': gender,
      'birthday': birthday.toString(),
      'phoneNumber': phoneNumber,
      'long': long,
      'lat': lat,
      'address': address,
      'avatar': avatar
    };
  }

  void clear() {
    this.id = null;
    this.uid = null;
    this.name = null;
    this.email = null;
    this.gender = null;
    this.birthday = null;
    this.phoneNumber = null;
    this.long = null;
    this.lat = null;
    this.address = null;
    notifyListeners();
  }

  User getData(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
      gender: json['gender'],
      birthday: json['birthday'] == null ? null : DateTime.parse(json['birthday']).toLocal(),
      phoneNumber: json['phoneNumber'],
      long: json['long'],
      lat: json['lat'],
      address: json['address'],
      avatar: json['avatar']
    );
  }
}
