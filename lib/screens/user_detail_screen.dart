import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class UserDetailScreen extends StatefulWidget {
  @override
  _UserDetailScreenState createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  DateTime _birthday = DateTime.now();
  Future _selectDate() async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: _birthday,
        firstDate: new DateTime(2016),
        lastDate: new DateTime(2020));
    if (picked != null) setState(() => _birthday = picked);
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
        appBar: AppBar(
          elevation: 0.0,
          title: Text("Tai khoan"),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {},
            )
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
                              Text(
                                "Ten nguoi dung",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black45,
                                ),
                              ),
                              TextFormField(
                                // validator: (value) {
                                //   if (value.isEmpty || value == "") {
                                //     return 'Please enter some text';
                                //   }
                                //   return null;
                                // },
                                initialValue: "Nhan Nguyen",
                                keyboardType: TextInputType.text,
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: ScreenUtil.instance.setSp(16.0),
                                ),
                                decoration: InputDecoration(
                                  enabledBorder: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.only(top: 10, bottom: 5),
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                "Email",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black45,
                                ),
                              ),
                              TextFormField(
                                // validator: (value) {
                                //   if (value.isEmpty || value == "") {
                                //     return 'Please enter some text';
                                //   }
                                //   return null;
                                // },
                                initialValue: "nhan.nguyen@gmail.com",
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: ScreenUtil.instance.setSp(16.0),
                                ),
                                decoration: InputDecoration(
                                  enabledBorder: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.only(top: 10, bottom: 5),
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                "Gioi tinh",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black45,
                                ),
                              ),
                              DropdownButtonFormField(
                                decoration: InputDecoration(
                                  enabledBorder: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.only(top: 5, bottom: 0),
                                ),
                                items: <DropdownMenuItem>[
                                  DropdownMenuItem(
                                    child: Text(
                                      "Nam",
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize:
                                            ScreenUtil.instance.setSp(16.0),
                                      ),
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    child: Text(
                                      "Nu",
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize:
                                            ScreenUtil.instance.setSp(16.0),
                                      ),
                                    ),
                                  ),
                                ],
                                onChanged: (value) {},
                              ),
                              SizedBox(height: 20),
                              Text(
                                "Ngay sinh",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black45,
                                ),
                              ),
                              GestureDetector(
                                onTap: _selectDate,
                                child: Padding(
                                  padding: EdgeInsets.only(top: 10, bottom: 5),
                                  child: Text(
                                    DateFormat.yMd('vi_VN').format(_birthday),
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: ScreenUtil.instance.setSp(16.0),
                                    ),
                                  ),
                                ),
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "So dien thoai",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black45,
                                ),
                              ),
                              TextFormField(
                                // validator: (value) {
                                //   if (value.isEmpty || value == "") {
                                //     return 'Please enter some text';
                                //   }
                                //   return null;
                                // },
                                initialValue: "0123456789",
                                keyboardType: TextInputType.phone,
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: ScreenUtil.instance.setSp(16.0),
                                ),
                                decoration: InputDecoration(
                                  enabledBorder: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.only(top: 10, bottom: 5),
                                ),
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Dia chi",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black45,
                                ),
                              ),
                              TextFormField(
                                // validator: (value) {
                                //   if (value.isEmpty || value == "") {
                                //     return 'Please enter some text';
                                //   }
                                //   return null;
                                // },
                                initialValue: "123 To Hien Thanh, HCM",
                                keyboardType: TextInputType.text,
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: ScreenUtil.instance.setSp(16.0),
                                ),
                                decoration: InputDecoration(
                                  enabledBorder: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.only(top: 10, bottom: 5),
                                ),
                              ),
                            ],
                          ),
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
