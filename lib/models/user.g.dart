// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars

mixin _$User on _User, Store {
  final _$idAtom = Atom(name: '_User.id');

  @override
  String get id {
    _$idAtom.context.enforceReadPolicy(_$idAtom);
    _$idAtom.reportObserved();
    return super.id;
  }

  @override
  set id(String value) {
    _$idAtom.context.conditionallyRunInAction(() {
      super.id = value;
      _$idAtom.reportChanged();
    }, _$idAtom, name: '${_$idAtom.name}_set');
  }

  final _$uidAtom = Atom(name: '_User.uid');

  @override
  String get uid {
    _$uidAtom.context.enforceReadPolicy(_$uidAtom);
    _$uidAtom.reportObserved();
    return super.uid;
  }

  @override
  set uid(String value) {
    _$uidAtom.context.conditionallyRunInAction(() {
      super.uid = value;
      _$uidAtom.reportChanged();
    }, _$uidAtom, name: '${_$uidAtom.name}_set');
  }

  final _$nameAtom = Atom(name: '_User.name');

  @override
  String get name {
    _$nameAtom.context.enforceReadPolicy(_$nameAtom);
    _$nameAtom.reportObserved();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.context.conditionallyRunInAction(() {
      super.name = value;
      _$nameAtom.reportChanged();
    }, _$nameAtom, name: '${_$nameAtom.name}_set');
  }

  final _$emailAtom = Atom(name: '_User.email');

  @override
  String get email {
    _$emailAtom.context.enforceReadPolicy(_$emailAtom);
    _$emailAtom.reportObserved();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.context.conditionallyRunInAction(() {
      super.email = value;
      _$emailAtom.reportChanged();
    }, _$emailAtom, name: '${_$emailAtom.name}_set');
  }

  final _$genderAtom = Atom(name: '_User.gender');

  @override
  int get gender {
    _$genderAtom.context.enforceReadPolicy(_$genderAtom);
    _$genderAtom.reportObserved();
    return super.gender;
  }

  @override
  set gender(int value) {
    _$genderAtom.context.conditionallyRunInAction(() {
      super.gender = value;
      _$genderAtom.reportChanged();
    }, _$genderAtom, name: '${_$genderAtom.name}_set');
  }

  final _$birthdayAtom = Atom(name: '_User.birthday');

  @override
  DateTime get birthday {
    _$birthdayAtom.context.enforceReadPolicy(_$birthdayAtom);
    _$birthdayAtom.reportObserved();
    return super.birthday;
  }

  @override
  set birthday(DateTime value) {
    _$birthdayAtom.context.conditionallyRunInAction(() {
      super.birthday = value;
      _$birthdayAtom.reportChanged();
    }, _$birthdayAtom, name: '${_$birthdayAtom.name}_set');
  }

  final _$phoneNumberAtom = Atom(name: '_User.phoneNumber');

  @override
  String get phoneNumber {
    _$phoneNumberAtom.context.enforceReadPolicy(_$phoneNumberAtom);
    _$phoneNumberAtom.reportObserved();
    return super.phoneNumber;
  }

  @override
  set phoneNumber(String value) {
    _$phoneNumberAtom.context.conditionallyRunInAction(() {
      super.phoneNumber = value;
      _$phoneNumberAtom.reportChanged();
    }, _$phoneNumberAtom, name: '${_$phoneNumberAtom.name}_set');
  }

  final _$longAtom = Atom(name: '_User.long');

  @override
  double get long {
    _$longAtom.context.enforceReadPolicy(_$longAtom);
    _$longAtom.reportObserved();
    return super.long;
  }

  @override
  set long(double value) {
    _$longAtom.context.conditionallyRunInAction(() {
      super.long = value;
      _$longAtom.reportChanged();
    }, _$longAtom, name: '${_$longAtom.name}_set');
  }

  final _$latAtom = Atom(name: '_User.lat');

  @override
  double get lat {
    _$latAtom.context.enforceReadPolicy(_$latAtom);
    _$latAtom.reportObserved();
    return super.lat;
  }

  @override
  set lat(double value) {
    _$latAtom.context.conditionallyRunInAction(() {
      super.lat = value;
      _$latAtom.reportChanged();
    }, _$latAtom, name: '${_$latAtom.name}_set');
  }

  final _$addressAtom = Atom(name: '_User.address');

  @override
  String get address {
    _$addressAtom.context.enforceReadPolicy(_$addressAtom);
    _$addressAtom.reportObserved();
    return super.address;
  }

  @override
  set address(String value) {
    _$addressAtom.context.conditionallyRunInAction(() {
      super.address = value;
      _$addressAtom.reportChanged();
    }, _$addressAtom, name: '${_$addressAtom.name}_set');
  }

  final _$_UserActionController = ActionController(name: '_User');

  @override
  void fromJson(Map<String, dynamic> json) {
    final _$actionInfo = _$_UserActionController.startAction();
    try {
      return super.fromJson(json);
    } finally {
      _$_UserActionController.endAction(_$actionInfo);
    }
  }

  @override
  Map<String, dynamic> toJson() {
    final _$actionInfo = _$_UserActionController.startAction();
    try {
      return super.toJson();
    } finally {
      _$_UserActionController.endAction(_$actionInfo);
    }
  }
}
