import 'dart:async';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_rabbit/utils/constants.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  @override
  void initState() {
    super.initState();
    // startTime();
  }

  startTime() async {
    // Wait 2 seconds after navigate to home page
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
      Navigator.of(context).pushReplacementNamed('/home');
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

    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data, 
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: Colors.white 
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/images/logo_x1.png',
                  fit: BoxFit.fill,
                  height: ScreenUtil.instance.setWidth(70.0),
                  width: ScreenUtil.instance.setWidth(70.0),
                ),
                SizedBox(height: ScreenUtil.instance.setHeight(20.0),),
                Text(APP_NAME)
              ],
            )
          ),
        )
      )
    );
  }
}