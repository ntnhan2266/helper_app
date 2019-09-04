import 'package:mobx/mobx.dart';

part 'user.g.dart';

class User = _User with _$User;

abstract class _User with Store {
  @observable
  String id = '';

  @observable
  String uid = '';

  @observable
  String name;

  @observable
  String email;

  @observable
  int gender;

  @observable
  DateTime birthday;

  @observable
  String phoneNumber;

  @observable
  double long;

  @observable
  double lat;

  @observable
  String address;

  @action
  void fromJson(Map<String, dynamic> json) {
    print(json['uid']);
    id = json['id'];
    uid = json['uid'];
    name = json['name'];
    email = json['email'];
    gender = json['gender'];
    birthday = DateTime.parse(json['birthday']);
    phoneNumber = json['phoneNumber'];
    long = json['long'];
    lat = json['lat'];
    address = json['address'];
  }

  @action
  Map<String, dynamic> toJson() =>
    {
      'id': id,
      'uid': uid,
      'name': name,
      'email': email,
      'gender': gender,
      'birthday': birthday,
      'phoneNumber': phoneNumber,
      'long': long,
      'lat': lat,
      'address': address
    };
}
