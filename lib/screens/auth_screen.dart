import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        Text(
          APP_NAME,
          style: Theme.of(context)
              .textTheme
              .title
              .copyWith(fontSize: ScreenUtil.instance.setSp(26)),
        )
      ],
    );
  }

  Widget _buildButton(
      {@required double width,
      @required String label,
      @required Color backgroundColor,
      @required Color textColor,
      @required Function onTapHandler,
      @required Color borderColor,
      bool bold: false}) {
    return InkWell(
      onTap: onTapHandler,
      child: Container(
        width: width,
        alignment: Alignment.center,
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: borderColor, width: 1.0),
        ),
        child: Text(
          label.toUpperCase(),
          style: TextStyle(
            color: textColor,
            fontFamily: 'Roboto',
            fontSize: ScreenUtil.instance.setSp(14),
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  void _navigateToRegisterScreen(BuildContext context) {
    Navigator.of(context).pushNamed(registerScreenRoute);
  }

  void _navigateToSigninScreen(BuildContext context) {
    Navigator.of(context).pushNamed(loginScreenRoute);
  }

  void _loginWithFacebook() {}

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
    // Get screen width, height
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.white,
        //   elevation: 0,
        //   actions: <Widget>[
        //     InkWell(
        //       onTap: () {
        //         data.changeLocale(Locale("vi", "VN"));
        //       },
        //       child: Container(
        //         margin: EdgeInsets.only(right: 10.0),
        //         width: ScreenUtil.instance.setWidth(25.0),
        //         height: ScreenUtil.instance.setHeight(25.0),
        //         decoration: BoxDecoration(
        //             shape: BoxShape.circle,
        //             color: Colors.green,
        //             image: DecorationImage(
        //               image: AssetImage('assets/images/easy.png'),
        //               fit: BoxFit.cover,
        //             )),
        //       ),
        //     )
        //   ],
        // ),
        body: Container(
          alignment: Alignment.bottomCenter,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: AssetImage('assets/images/welcome.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            width: screenWidth * 0.8,
            height: screenHeight * 0.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    _buildButton(
                      width: screenWidth * 0.38,
                      label: AppLocalizations.of(context).tr('login'),
                      backgroundColor: Colors.white,
                      borderColor: Color(MAIN_COLOR),
                      textColor: Color(MAIN_COLOR),
                      bold: true,
                      onTapHandler: () {
                        _navigateToSigninScreen(context);
                      },
                    ),
                    _buildButton(
                      width: screenWidth * 0.38,
                      label: AppLocalizations.of(context).tr('register'),
                      backgroundColor: Colors.white,
                      borderColor: Color(MAIN_COLOR),
                      textColor: Color(MAIN_COLOR),
                      bold: true,
                      onTapHandler: () {
                        _navigateToRegisterScreen(context);
                      },
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: ScreenUtil.instance.setHeight(15),
                  ),
                  child: _buildButton(
                    width: screenWidth * 0.8,
                    label:
                        AppLocalizations.of(context).tr('login_with_facebook'),
                    backgroundColor: Color.fromRGBO(59, 89, 152, 1),
                    borderColor: Color.fromRGBO(59, 89, 152, 1),
                    textColor: Colors.white,
                    onTapHandler: () {
                      _loginWithFacebook();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
