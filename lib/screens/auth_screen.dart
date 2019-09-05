import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_rabbit/services/auth.dart';
import 'package:flushbar/flushbar.dart';

import '../utils/constants.dart';
import '../utils/route_names.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  Widget _buildLogo(BuildContext context) {
    return Column(
      children: <Widget>[
        Image.asset(
          'assets/images/logo_x5.png',
          fit: BoxFit.fill,
          height: ScreenUtil.instance.setWidth(80.0),
          width: ScreenUtil.instance.setWidth(80.0),
        ),
        Text(APP_NAME, 
          style: Theme.of(context).textTheme.title.copyWith(
            fontSize: ScreenUtil.instance.setSp(26)
          ),
        )
      ],
    );
  }
  
  Widget _buildButton({
    @required double width,
    @required String label,
    @required Color backgroundColor,
    @required Color textColor,
    @required Function onTapHandler,
    @required Color borderColor
  }) {
    return InkWell(
      onTap: onTapHandler,
      child: Container(
        width: width,
        alignment: Alignment.center,
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(
            color: borderColor,
            width: 1.0
          )
        ),
        child: Text(
          label.toUpperCase(),
          style: TextStyle(
            color: textColor,
            fontFamily: 'Roboto',
            fontSize: ScreenUtil.instance.setSp(14)
          ),
        )
      ),
    );
  }

  void _navigateToRegisterScreen(BuildContext context) {
    Navigator.of(context).pushNamed(registerScreenRoute);
  }

  void _navigateToSigninScreen(BuildContext context) {
        Navigator.of(context).pushNamed(loginScreenRoute);
  }

  void _loginWithFacebook(BuildContext context) async {
    final resCode = await AuthService.loginWithFacebook();
    switch (resCode) {
      case NO_ERROR:
        Navigator.of(context).pushNamedAndRemoveUntil(homeScreenRoute, (Route<dynamic> route) => false);
        break;
      case FB_LOGIN_FAILED:
        Flushbar(
        titleText: Text(
          AppLocalizations.of(context).tr('error'),
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: ScreenUtil.instance.setSp(14.0),
            color: Colors.red
          )
        ),
        messageText: Text(
          AppLocalizations.of(context).tr('something_went_wrong'),
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: ScreenUtil.instance.setSp(12.0),
            color: Colors.red
          )
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
        break;
      default:
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
    return EasyLocalizationProvider(
      data: data, 
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          actions: <Widget>[
            InkWell(
              onTap: () {
                data.changeLocale(Locale("vi","VN"));
              },
              child: Container(
                margin: EdgeInsets.only(right: 10.0),
                width: ScreenUtil.instance.setWidth(25.0),
                height: ScreenUtil.instance.setHeight(25.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green,
                  image: DecorationImage(
                    image: AssetImage('assets/images/easy.png'),
                    fit: BoxFit.cover,
                  )
                ),
              ),
            )
          ],
        ),
        body: Container(
          alignment: Alignment.center,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white 
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildLogo(context),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: ScreenUtil.instance.setWidth(MAIN_MARGIN), 
                  vertical: ScreenUtil.instance.setHeight(10)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        _buildButton(
                          width: (screenWidth - ScreenUtil.instance.setWidth(MAIN_MARGIN * 2)) * 0.48,
                          label: AppLocalizations.of(context).tr('login'),
                          backgroundColor: Colors.white,
                          borderColor: Color.fromRGBO(42, 77, 108, 1),
                          textColor: Color.fromRGBO(42, 77, 108, 1),
                          onTapHandler: () {_navigateToSigninScreen(context);}
                        ),
                        SizedBox(width: (screenWidth - ScreenUtil.instance.setWidth(MAIN_MARGIN * 2)) * 0.04,),
                        _buildButton(
                          width: (screenWidth - ScreenUtil.instance.setWidth(MAIN_MARGIN * 2)) * 0.48,
                          label: AppLocalizations.of(context).tr('register'),
                          backgroundColor: Colors.white,
                          borderColor: Color.fromRGBO(42, 77, 108, 1),
                          textColor: Color.fromRGBO(42, 77, 108, 1),
                          onTapHandler: () {_navigateToRegisterScreen(context);}
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: ScreenUtil.instance.setWidth(MAIN_MARGIN), 
                  vertical: ScreenUtil.instance.setHeight(10)
                ),
                child: _buildButton(
                  width: (screenWidth - ScreenUtil.instance.setWidth(MAIN_MARGIN * 2)),
                  label: AppLocalizations.of(context).tr('login_with_facebook'),
                  backgroundColor: Color.fromRGBO(59, 89, 152, 1),
                  borderColor: Color.fromRGBO(59, 89, 152, 1),
                  textColor: Colors.white,
                  onTapHandler: () {
                    _loginWithFacebook(context);
                  }
                ),
              ),
            ],
          )
        )
      )
    );
  }
}