import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:flushbar/flushbar.dart';
import 'package:image_picker_modern/image_picker_modern.dart';

import '../models/form_select_item.dart';
import '../models/user.dart';
import '../services/permission.dart';
import '../services/file.dart';
import '../services/user.dart';
import '../screens/choose_address_screen.dart';
import '../widgets/form/form_label.dart';
import '../widgets/user_avatar.dart';
import '../widgets/form/form_datepicker.dart';
import '../widgets/form/form_dropdown.dart';
import '../utils/route_names.dart';
import '../utils/utils.dart';
import '../utils/constants.dart';

class UserDetailScreen extends StatefulWidget {
  @override
  _UserDetailScreenState createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  TextEditingController _addressController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  PersistentBottomSheetController _controller;
  final _form = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  User _data = User();
  bool _open = false;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(X_TOKEN);
    if (token != null) {
      UserService.getUser(token).then((res) {
        if (res['isValid']) {
          final user = res['user'];
          setState(() {
            _data = User(
                id: user['id'],
                uid: user['uid'],
                name: user['name'],
                email: user['email'],
                gender: user['gender'],
                birthday: DateTime.parse(user['birthday']),
                phoneNumber: user['phoneNumber'],
                long: user['long'],
                lat: user['lat'],
                address: user['address'],
                avatar: user['avatar']);
            _addressController.text = _data.address;
            _emailController.text = _data.email;
            _phoneController.text = _data.phoneNumber;
            _nameController.text = _data.name;
          });
        }
      });
    } else {
      Navigator.of(context).pushReplacementNamed(authScreenRoute);
    }
  }

  void _handleChangeBirthday(DateTime birthday) {
    setState(() {
      _data.birthday = birthday;
    });
  }

  void _handleChangeGender(int value) {
    setState(() {
      _data.gender = value;
    });
  }

  Future _getImage(int source) async {
    var file = await ImagePicker.pickImage(source: source == 1 ? ImageSource.gallery : ImageSource.camera);

    _upload(file);
  }

  void _upload(File file) async {
    if (file == null) return;
    String base64Image = base64Encode(file.readAsBytesSync());
    String fileName = file.path.split("/").last;

    final res = await FileService.upload(base64Image, fileName);
 }

  void _handleChangeAvatar(context) async {
    if (!_open) {
      _controller = scaffoldKey.currentState.showBottomSheet(
        (context) => Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(blurRadius: 10, color: Color.fromRGBO(0, 0, 0, 0.4))
            ],
          ),
          width: double.infinity,
          padding: EdgeInsets.all(
            ScreenUtil.instance.setWidth(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                AppLocalizations.of(context).tr('choose_image'),
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: ScreenUtil.instance.setSp(12),
                ),
              ),
              Divider(),
              Container(
                child: InkWell(
                  onTap: () {
                    _getImage(1); // Choose from gallery
                  },
                  child: Text(
                    'Chon hinh anh',
                    style: TextStyle(
                      fontSize: ScreenUtil.instance.setSp(14),
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
              Divider(),
              Container(
                child: InkWell(
                  onTap: () {
                    _getImage(2); // Choose from gallery
                  },
                  child: Text(
                    'Chon hinh anh 2',
                    style: TextStyle(
                      fontSize: ScreenUtil.instance.setSp(14),
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      _controller.close();
    }
    setState(() => _open = !_open);
  }

  void _getCurrentLocation() async {
    try {
      double lat = 21.0048;
      double long = 105.8453;

      final isGrantedPermission = await PermissionsService()
          .requestLocationPermission(onPermissionDenied: () {
        print('Can not get permission');
      });
      if (isGrantedPermission) {
        Position position = await Geolocator()
            .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        lat = position.latitude;
        long = position.longitude;
      }
      Map<String, dynamic> returnedData =
          await Navigator.push(context, MaterialPageRoute(builder: (context) {
        return ChooseAddressScreen(
          lat: lat,
          long: long,
        );
      }));
      if (returnedData != null) {
        _data.address = returnedData['address'];
        _data.lat = returnedData['lat'];
        _data.long = returnedData['long'];
        _addressController.text = _data.address;
      }
    } catch (e) {
      print(e);
    }
  }

  void _onSubmit() async {
    if (_form.currentState.validate()) {
      _form.currentState.save();
      var res = await UserService.editUser(_data);
      if (res['isValid']) {
        final userProvider = Provider.of<User>(context, listen: false);
        userProvider.fromJson(res['user']);
        setState(() {
          _data.fromJson(res['user']);
        });
        Flushbar(
          titleText: Text(AppLocalizations.of(context).tr('success'),
              style: TextStyle(
                  fontSize: ScreenUtil.instance.setSp(14.0),
                  color: Colors.green)),
          messageText: Text(
            AppLocalizations.of(context).tr('update_profile_successfully'),
            style: TextStyle(
              fontSize: ScreenUtil.instance.setSp(12.0),
              color: Colors.green,
            ),
          ),
          icon: Icon(
            Icons.error,
            size: 22,
            color: Colors.green,
          ),
          backgroundColor: Colors.white,
          borderWidth: 1.0,
          borderColor: Colors.green,
          duration: Duration(seconds: 3),
        )..show(context);
      } else {
        Flushbar(
          titleText: Text(AppLocalizations.of(context).tr('error'),
              style: TextStyle(
                  fontSize: ScreenUtil.instance.setSp(14.0),
                  color: Colors.red)),
          messageText: Text(
            AppLocalizations.of(context).tr('something_went_wrong'),
            style: TextStyle(
              fontSize: ScreenUtil.instance.setSp(12.0),
              color: Colors.red,
            ),
          ),
          icon: Icon(
            Icons.error,
            size: 22,
            color: Colors.red,
          ),
          backgroundColor: Colors.white,
          borderWidth: 1.0,
          borderColor: Colors.red,
          duration: Duration(seconds: 3),
        )..show(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Responsive
    double defaultScreenWidth = 400.0;
    double defaultScreenHeight = 810.0;
    ScreenUtil.instance = ScreenUtil(
      width: defaultScreenWidth,
      height: defaultScreenHeight,
      allowFontScaling: true,
    )..init(context);
    // Localization
    var data = EasyLocalizationProvider.of(context).data;
    // Get screen width
    final screenWidth = MediaQuery.of(context).size.width;
    // Build slide list
    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          elevation: 0.0,
          title: Text(
            AppLocalizations.of(context).tr('account_info'),
          ),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              onPressed: _onSubmit,
            ),
          ],
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
            if (_open) {
              _controller.close();
              setState(() => _open = !_open);
            }
          },
          child: Container(
            color: Colors.blueGrey[50],
            height: double.infinity,
            width: double.infinity,
            child: ListView(
              children: <Widget>[
                Stack(
                  alignment: AlignmentDirectional.topCenter,
                  children: <Widget>[
                    Container(
                      height: ScreenUtil.instance.setHeight(130.0),
                      color: Theme.of(context).primaryColor,
                    ),
                    Form(
                      key: _form,
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: screenWidth * 0.8,
                            margin: EdgeInsets.only(
                                top: ScreenUtil.instance.setHeight(30)),
                            padding: EdgeInsets.symmetric(
                                vertical: ScreenUtil.instance.setHeight(35)),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Colors.white,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    _handleChangeAvatar(context);
                                  },
                                  child: Container(
                                    width: ScreenUtil.instance.setWidth(70),
                                    height: ScreenUtil.instance.setWidth(70),
                                    child: UserAvatar(_data.avatar),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: ScreenUtil.instance.setHeight(15)),
                                  child: Text(
                                    _data.name != null ? _data.name : '',
                                    style: TextStyle(
                                      fontSize: ScreenUtil.instance.setSp(18),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: ScreenUtil.instance.setHeight(5)),
                                  child: Text(
                                    _data.email != null ? _data.email : '',
                                    style: TextStyle(
                                      fontSize: ScreenUtil.instance.setSp(12),
                                      color: Colors.black45,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(top: 20),
                            padding: EdgeInsets.symmetric(
                              vertical: ScreenUtil.instance.setHeight(15),
                              horizontal: ScreenUtil.instance.setHeight(15),
                            ),
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    FormLabel(
                                      AppLocalizations.of(context)
                                          .tr('fullname'),
                                    ),
                                    TextFormField(
                                      validator: (String value) {
                                        if (value.isEmpty) {
                                          return AppLocalizations.of(context)
                                              .tr('please_enter_name');
                                        }
                                        return null;
                                      },
                                      controller: _nameController,
                                      style: TextStyle(
                                        fontSize:
                                            ScreenUtil.instance.setSp(12.0),
                                        color: Colors.black,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: AppLocalizations.of(context)
                                            .tr('name_example'),
                                        hintStyle: TextStyle(),
                                        enabledBorder: InputBorder.none,
                                        contentPadding: EdgeInsets.only(
                                            top: ScreenUtil.instance
                                                .setHeight(10),
                                            bottom: ScreenUtil.instance
                                                .setHeight(10)),
                                      ),
                                      onSaved: (String value) {
                                        _data.name = value;
                                      },
                                    ),
                                    SizedBox(
                                      height: ScreenUtil.instance.setHeight(20),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    FormLabel(
                                      AppLocalizations.of(context).tr('email'),
                                    ),
                                    TextFormField(
                                      validator: (String value) {
                                        RegExp regex =
                                            new RegExp(EMAIL_PATTERN);
                                        if (value.isEmpty) {
                                          return AppLocalizations.of(context)
                                              .tr('please_enter_email');
                                        } else if (!regex.hasMatch(value)) {
                                          return AppLocalizations.of(context)
                                              .tr('invalid_email');
                                        }
                                        return null;
                                      },
                                      controller: _emailController,
                                      style: TextStyle(
                                        fontSize:
                                            ScreenUtil.instance.setSp(12.0),
                                        color: Colors.black,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: AppLocalizations.of(context)
                                            .tr('email_example'),
                                        hintStyle: TextStyle(),
                                        enabledBorder: InputBorder.none,
                                        contentPadding: EdgeInsets.only(
                                            top: ScreenUtil.instance
                                                .setHeight(10),
                                            bottom: ScreenUtil.instance
                                                .setHeight(10)),
                                      ),
                                      onSaved: (String value) {
                                        _data.email = value;
                                      },
                                    ),
                                    SizedBox(
                                      height: ScreenUtil.instance.setHeight(20),
                                    ),
                                  ],
                                ),
                                FormDropdown(
                                  handleOnChange: _handleChangeGender,
                                  value: _data.gender != null
                                      ? _data.gender
                                      : Utils.genderToInt(GENDER.male),
                                  label:
                                      AppLocalizations.of(context).tr('gender'),
                                  values: [
                                    FormSelectItem(
                                      label: AppLocalizations.of(context)
                                          .tr('male'),
                                      value: Utils.genderToInt(GENDER.male),
                                    ),
                                    FormSelectItem(
                                      value: Utils.genderToInt(GENDER.female),
                                      label: AppLocalizations.of(context)
                                          .tr('female'),
                                    ),
                                    FormSelectItem(
                                      value: Utils.genderToInt(GENDER.other),
                                      label: AppLocalizations.of(context)
                                          .tr('other'),
                                    ),
                                  ],
                                  hasNext: true,
                                ),
                                FormDatePicker(
                                  hanldeChange: _handleChangeBirthday,
                                  label: AppLocalizations.of(context)
                                      .tr('birthday'),
                                  value: _data.birthday != null
                                      ? _data.birthday
                                      : DateTime.parse('1990-01-01'),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(
                                top: ScreenUtil.instance.setHeight(20)),
                            padding: EdgeInsets.symmetric(
                              vertical: ScreenUtil.instance.setHeight(15),
                              horizontal: ScreenUtil.instance.setHeight(15),
                            ),
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                FormLabel(
                                  AppLocalizations.of(context).tr('phone'),
                                ),
                                TextFormField(
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return AppLocalizations.of(context)
                                          .tr('please_enter_phone_number');
                                    }
                                    return null;
                                  },
                                  controller: _phoneController,
                                  style: TextStyle(
                                    fontSize: ScreenUtil.instance.setSp(12.0),
                                    color: Colors.black,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: AppLocalizations.of(context)
                                        .tr('phone_number_example'),
                                    hintStyle: TextStyle(),
                                    enabledBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                        top: ScreenUtil.instance.setHeight(10),
                                        bottom:
                                            ScreenUtil.instance.setHeight(10)),
                                  ),
                                  onSaved: (String value) {
                                    _data.phoneNumber = value;
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: ScreenUtil.instance.setHeight(20),
                          ),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              vertical: ScreenUtil.instance.setHeight(15),
                              horizontal: ScreenUtil.instance.setHeight(15),
                            ),
                            color: Colors.white,
                            child: InkWell(
                              onTap: _getCurrentLocation,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  FormLabel(AppLocalizations.of(context)
                                      .tr('address')),
                                  TextFormField(
                                    enabled: false,
                                    validator: (String value) {
                                      if (value.isEmpty) {
                                        return AppLocalizations.of(context)
                                            .tr('location_required');
                                      }
                                      return null;
                                    },
                                    controller: _addressController,
                                    style: TextStyle(
                                      fontSize: ScreenUtil.instance.setSp(12.0),
                                      color: Colors.black,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: AppLocalizations.of(context)
                                          .tr('choose_address'),
                                      errorStyle: TextStyle(color: Colors.red),
                                      enabledBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      contentPadding: EdgeInsets.only(
                                          top:
                                              ScreenUtil.instance.setHeight(10),
                                          bottom: ScreenUtil.instance
                                              .setHeight(10)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: ScreenUtil.instance.setHeight(20),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
