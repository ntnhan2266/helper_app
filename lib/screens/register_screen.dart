import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/route_names.dart';
import '../utils/constants.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Responsive
    double defaultScreenWidth = 400.0;
    double defaultScreenHeight = 810.0;
    double labelMargin = 5.0;

    ScreenUtil.instance = ScreenUtil(
      width: defaultScreenWidth,
      height: defaultScreenHeight,
      allowFontScaling: true,
    )..init(context);
    // Localization
    var data = EasyLocalizationProvider.of(context).data;
    // Build slide list
    return EasyLocalizationProvider(
      data: data, 
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
        ),
        body: Container(
          width: double.infinity,
          color: Colors.white,
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil.instance.setWidth(MAIN_MARGIN),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Form(
                key: _form,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(
                          vertical: ScreenUtil.instance.setWidth(MAIN_MARGIN),
                        ),
                        child: Text(
                          AppLocalizations.of(context).tr('please_fill_some_info'),
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: ScreenUtil.instance.setSp(16.0),
                          )
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          bottom: ScreenUtil.instance.setWidth(labelMargin),
                        ),
                        child: Text(
                          AppLocalizations.of(context).tr('full_name'),
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: ScreenUtil.instance.setSp(12.0),
                          )
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Ví dụ: Nguyễn Văn A',
                        ),
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: ScreenUtil.instance.setSp(12.0),
                          )
                      ),
                      SizedBox(height: ScreenUtil.instance.setHeight(20.0),),
                      Container(
                        margin: EdgeInsets.only(
                          bottom: ScreenUtil.instance.setWidth(labelMargin),
                        ),
                        child: Text(
                          AppLocalizations.of(context).tr('email'),
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: ScreenUtil.instance.setSp(12.0),
                          )
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Ví dụ: nguyenvana@email.com',
                        ),
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: ScreenUtil.instance.setSp(12.0),
                          )
                      ),
                    ],
                  )
                ),
              ),
            ]
          ),
        )
      )
    );
  }
}