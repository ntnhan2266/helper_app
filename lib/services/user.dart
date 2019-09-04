import 'package:json_annotation/json_annotation.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()

class User {
  final String userId;
  final String firstName;
  final String lastName;
  final String email;
  final int gender;
  final DateTime birthday;
  final String phoneNumber;
  final double long;
  final double lat;
  final String address;

  User({
    this.userId,
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.birthday,
    this.phoneNumber,
    this.long,
    this.lat,
    this.address
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      gender: json['gender'],
      birthday: json['birthday'],
      phoneNumber: json['phoneNumber'],
      long: json['long'],
      lat: json['lat'],
      address: json['address']
    );
  }

  Map<String, dynamic> toJson() =>
    {
      'userId': userId,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'gender': gender,
      'birthday': birthday,
      'phoneNumber': phoneNumber,
      'long': long,
      'lat': lat,
      'address': address
    };
  
  
}