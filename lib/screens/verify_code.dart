import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/route_names.dart';
import '../utils/constants.dart';

class VerifyCodeScreen extends StatefulWidget {
  @override
  _VerifyCodeScreenState createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {

  final _form = GlobalKey<FormState>();

  void _signInWithPhone() {
    if (_form.currentState.validate()) {
      // If the form is valid, display a Snackbar.
      print('ok');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get arguments from route
    final Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;
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
          height: double.infinity,
          color: Colors.white,
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil.instance.setWidth(MAIN_MARGIN),
          ),
          child: Form(
            key: _form,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[ 
                  Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(
                          vertical: ScreenUtil.instance.setWidth(MAIN_MARGIN),
                        ),
                        child: Image.asset(
                          'assets/images/send_message.png',
                          height: ScreenUtil.instance.setHeight(120.0),
                        )
                      ),
                      SizedBox(height: ScreenUtil.instance.setHeight(20.0)),
                      Container(
                        margin: EdgeInsets.symmetric(
                          vertical: ScreenUtil.instance.setWidth(MAIN_MARGIN),
                        ),
                        child: Text(
                          AppLocalizations.of(context).tr('one_more_step'),
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: ScreenUtil.instance.setSp(16.0),
                          )
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      bottom: ScreenUtil.instance.setWidth(LABEL_MARGIN),
                    ),
                    child: Text(
                      AppLocalizations.of(context).tr('enter_otp'),
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: ScreenUtil.instance.setSp(12.0),
                      )
                    ),
                  ),
                   
                  SizedBox(height: ScreenUtil.instance.setHeight(20.0)),
                  InkWell(
                    onTap: _signInWithPhone,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(0, 91, 150, 1),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          AppLocalizations.of(context).tr('login').toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: ScreenUtil.instance.setSp(12.0),
                            color: Colors.white,
                          )
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: ScreenUtil.instance.setHeight(20.0),),
                ],
              ),
            ),
          ),
        )
      )
    );
  }
}