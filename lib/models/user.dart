import 'package:json_annotation/json_annotation.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()

class User {
  String id = '';
  String uid = '';
  String name;
  String email;
  int gender;
  DateTime birthday;
  String phoneNumber;
  double long;
  double lat;
  String address;

  User({this.id, this.uid, this.name, this.email, this.gender, this.birthday, this.phoneNumber, this.long, this.lat, this.address});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
      birthday: DateTime.parse(json['birthday']),
      gender: json['gender'],
      phoneNumber: json['phoneNumber'],
      long: json['long'],
      lat: json['lat'],
      address: json['address']
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'uid': uid,
    'name': name,
    'email': email,
    'birthday': birthday.toString(),
    'gender': gender,
    'phoneNumber': phoneNumber,
    'long': long,
    'lat': lat,
    'address': address
  };
}
