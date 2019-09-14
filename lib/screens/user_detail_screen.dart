import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/form/form_datepicker.dart';
import '../widgets/form/form_dropdown.dart';
import '../widgets/form/form_input.dart';

class UserDetailScreen extends StatefulWidget {
  @override
  _UserDetailScreenState createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
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
            "Tai khoan",
            style: TextStyle(
              fontSize: ScreenUtil.instance.setSp(20.0),
            ),
          ),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {},
            ),
          ],
        ),
        body: Container(
          color: Colors.blueGrey[50],
          height: double.infinity,
          width: double.infinity,
          child: ListView(
            children: <Widget>[
              Stack(
                alignment: AlignmentDirectional.topCenter,
                children: <Widget>[
                  Container(
                    height: 130,
                    color: Theme.of(context).primaryColor,
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        width: screenWidth * 0.8,
                        margin: EdgeInsets.only(top: 30),
                        padding: EdgeInsets.symmetric(vertical: 35),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              width: 70,
                              height: 70,
                              child: CircleAvatar(
                                backgroundImage:
                                    AssetImage("assets/images/female_user.jpg"),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Text(
                                "Nhan Nguyen",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(
                                "nhan.nguyen@gmail.com",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black45),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 20),
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                        color: Colors.white,
                        child: Form(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              FormInput(
                                label: "Ten nguoi dung",
                                initialValue: "Nhan Nguyen",
                                hasNext: true,
                                focusNode: _nameFocus,
                                nextNode: _emailFocus,
                              ),
                              FormInput(
                                label: "Email",
                                initialValue: "nhan.nguyen@gmail.com",
                                hasNext: true,
                                focusNode: _emailFocus,
                                nextNode: null,
                              ),
                              FormDropdown(
                                label: "Gioi tinh",
                                values: ["Nam", "Nu"],
                                initialValue: "Nu",
                                hasNext: true,
                              ),
                              FormDatePicker(
                                label: "Ngay sinh",
                                value: DateTime.now(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 20),
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                        color: Colors.white,
                        child: Form(
                          child: FormInput(
                              label: "So dien thoai",
                              initialValue: "013456789",
                              hasNext: false),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 20),
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                        color: Colors.white,
                        child: Form(
                          child: FormInput(
                              label: "Dia chi",
                              initialValue: "13 To Hien Thanh, HCM",
                              hasNext: false),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
