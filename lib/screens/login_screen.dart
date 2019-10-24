import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../utils/utils.dart';
import '../widgets/components/color_loader.dart';
import '../utils/constants.dart';
import '../utils/route_names.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginData {
  String phoneNumber = '';
}

class _LoginScreenState extends State<LoginScreen> {
  final _form = GlobalKey<FormState>();
  _LoginData _data = _LoginData();

  void _verifyPhoneNumber(String phoneNumber) async {
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) {
      _auth.signInWithCredential(phoneAuthCredential);
      print('Received phone auth credential: $phoneAuthCredential');
      Navigator.pop(context);
    };

    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      print(
          'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');
      Navigator.pop(context);
      Utils.showErrorDialog(context, 'phone_verification_failed');
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      print('Please check your phone for the verification code');
      // _verificationId = verificationId;
      // Navigate to verify code screen
      Navigator.pushReplacementNamed(context, verificationCodeRoute,
          arguments: {
            'isLogin': true,
            'verificationId': verificationId,
            'phoneNumber': _data.phoneNumber
          });
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      // _verificationId = verificationId;
      // Handle time out
    };

    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 30),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  void login() {
    if (_form.currentState.validate()) {
      // If the form is valid, display a Snackbar.
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            child: ColorLoader(
              colors: [Colors.red, Colors.blue, Colors.green],
              duration: Duration(seconds: 1),
            ),
          );
        },
      );
      _form.currentState.save();
      _verifyPhoneNumber('+84' + _data.phoneNumber);
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
                          child: Image.asset('assets/images/login_banner.png')),
                      SizedBox(height: ScreenUtil.instance.setHeight(20.0)),
                      Container(
                        margin: EdgeInsets.symmetric(
                          vertical: ScreenUtil.instance.setWidth(MAIN_MARGIN),
                        ),
                        child: Text(
                            AppLocalizations.of(context)
                                .tr('enter_registered_phone_number_to_login'),
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: ScreenUtil.instance.setSp(16.0),
                            )),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      bottom: ScreenUtil.instance.setWidth(LABEL_MARGIN),
                    ),
                    child: Text(AppLocalizations.of(context).tr('phone_number'),
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: ScreenUtil.instance.setSp(12.0),
                        )),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                            right: ScreenUtil.instance.setWidth(10),
                            top: ScreenUtil.instance.setHeight(6)),
                        width: ScreenUtil.instance.setWidth(66),
                        height: ScreenUtil.instance.setWidth(32),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'assets/images/vn_flag_icon.png',
                              fit: BoxFit.fill,
                              width: ScreenUtil.instance.setWidth(30),
                              height: ScreenUtil.instance.setWidth(20),
                            ),
                            SizedBox(
                              width: ScreenUtil.instance.setWidth(4),
                            ),
                            Text(
                              '+84',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: ScreenUtil.instance.setSp(12.0),
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return AppLocalizations.of(context)
                                  .tr('please_enter_phone_number');
                            } else if (value.length < 8) {
                              return AppLocalizations.of(context)
                                  .tr('invalid_phone_number');
                            }
                            return null;
                          },
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)
                                .tr('phone_number_example'),
                          ),
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: ScreenUtil.instance.setSp(12.0),
                          ),
                          onSaved: (value) {
                            this._data.phoneNumber = value;
                          },
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: ScreenUtil.instance.setHeight(20.0)),
                  InkWell(
                    onTap: login,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(0, 91, 150, 1),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                            AppLocalizations.of(context)
                                .tr('login')
                                .toUpperCase(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: ScreenUtil.instance.setSp(12.0),
                              color: Colors.white,
                            )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil.instance.setHeight(20.0),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
