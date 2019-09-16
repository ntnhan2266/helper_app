import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/form/form_datepicker.dart';
import '../widgets/form/form_dropdown.dart';
import '../widgets/form/form_input.dart';
import '../models/form_select_item.dart';
import '../models/user.dart';
import '../utils/constants.dart';
import '../services/permission.dart';
import '../screens/choose_address_screen.dart';
import '../services/user.dart';
import '../widgets/form/form_label.dart';
import '../utils/route_names.dart';

class UserDetailScreen extends StatefulWidget {
  @override
  _UserDetailScreenState createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  TextEditingController _addressController = TextEditingController();
  User _data = User();

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
              uid : user['uid'],
              name : user['name'],
              email : user['email'],
              gender : user['gender'],
              birthday : DateTime.parse(user['birthday']),
              phoneNumber : user['phoneNumber'],
              long : user['long'],
              lat : user['lat'],
              address : user['address'],
            );
          });
        }
      });
    } else {
      Navigator.of(context).pushReplacementNamed(authScreenRoute);
    }
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

  @override
  Widget build(BuildContext context) {
    print(_data.name);
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
    // Focus Node
    final FocusNode _nameFocus = FocusNode();
    final FocusNode _emailFocus = FocusNode();
    // Build slide list
    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text(
            AppLocalizations.of(context).tr('account_info'),
          ),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {},
            ),
          ],
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
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
                                Container(
                                  width: ScreenUtil.instance.setWidth(70),
                                  height: ScreenUtil.instance.setWidth(70),
                                  child: CircleAvatar(
                                    backgroundImage: AssetImage(
                                        "assets/images/female_user.jpg"),
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
                                FormInput(
                                  label: AppLocalizations.of(context)
                                      .tr('fullname'),
                                  initialValue:
                                      _data.name != null ? _data.name : '',
                                  hasNext: true,
                                  focusNode: _nameFocus,
                                  nextNode: _emailFocus,
                                ),
                                FormInput(
                                  label: "Email",
                                  initialValue:
                                      _data.email != null ? _data.email : '',
                                  hasNext: true,
                                  focusNode: _emailFocus,
                                  nextNode: null,
                                ),
                                FormDropdown(
                                  label:
                                      AppLocalizations.of(context).tr('gender'),
                                  values: [
                                    FormSelectItem(
                                        label: AppLocalizations.of(context)
                                            .tr('male'),
                                        value: GENDER.male),
                                    FormSelectItem(
                                      value: GENDER.female,
                                      label: AppLocalizations.of(context)
                                          .tr('female'),
                                    ),
                                    FormSelectItem(
                                      value: GENDER.other,
                                      label: AppLocalizations.of(context)
                                          .tr('other'),
                                    ),
                                  ],
                                  hasNext: true,
                                ),
                                FormDatePicker(
                                  label: AppLocalizations.of(context)
                                      .tr('birthday'),
                                  value: _data.birthday,
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
                            child: FormInput(
                              label: AppLocalizations.of(context).tr('phone'),
                              initialValue: _data.phoneNumber != null
                                  ? _data.phoneNumber
                                  : '',
                              hasNext: false,
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                FormLabel(
                                    AppLocalizations.of(context).tr('address')),
                                TextFormField(
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return AppLocalizations.of(context)
                                          .tr('location_required');
                                    }
                                    return null;
                                  },
                                  initialValue: _data.name,
                                  style: TextStyle(
                                    fontSize: ScreenUtil.instance.setSp(12.0),
                                    color: Colors.black,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: AppLocalizations.of(context)
                                        .tr('choose_address'),
                                    hintStyle: TextStyle(),
                                    enabledBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                        top: ScreenUtil.instance.setHeight(10),
                                        bottom:
                                            ScreenUtil.instance.setHeight(10)),
                                  ),
                                ),
                                SizedBox(
                                    height: ScreenUtil.instance.setHeight(20)),
                              ],
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
