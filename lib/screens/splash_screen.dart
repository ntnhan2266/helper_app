import 'dart:async';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_rabbit/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import '../utils/route_names.dart';
import '../services/user.dart';
import '../models/user.dart';
import '../services/auth.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    // Wait 2 seconds after navigate to home page
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() async {
    // If user first login show intro screen
    // Else if user logged navigate to home
    // Else navigatate to sign up/sign in page
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final isFirstLogin = prefs.getBool(IS_FIRST_LOGIN) ?? true;
    if (isFirstLogin) {
      Navigator.of(context).pushReplacementNamed(introScreenRoute);
    } else {
      final token = prefs.getString(X_TOKEN);
      if (token != null) {
        UserService.getUser().then((res) {
          if (res['isValid']) {
            final user = res['user'];
            final userProvider = Provider.of<User>(context, listen: false);
            userProvider.fromJson(user);
            Navigator.of(context).pushReplacementNamed(homeScreenRoute);
          } else {
            AuthService.logout(context);
          }
        });
      } else {
        Navigator.of(context).pushReplacementNamed(authScreenRoute);
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
                  'assets/images/logo_x5.png',
                  fit: BoxFit.fill,
                  height: ScreenUtil.instance.setWidth(90.0),
                  width: ScreenUtil.instance.setWidth(90.0),
                ),
                SizedBox(height: ScreenUtil.instance.setHeight(5.0),),
                Text(APP_NAME, 
                  style: Theme.of(context).textTheme.title.copyWith(
                    fontSize: ScreenUtil.instance.setSp(28),
                    fontFamily: 'Pacifico-Regular'
                  ),
                )
              ],
            )
          ),
        )
      )
    );
  }
}