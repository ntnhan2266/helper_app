import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../utils/constants.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class VerifyCodeScreen extends StatefulWidget {
  @override
  _VerifyCodeScreenState createState() => _VerifyCodeScreenState();
}

class VerifyData {
  String verificationId = '';
  String phoneNumber = '';
  String otpCode = '';
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {

  final _form = GlobalKey<FormState>();

  int pinLength = 6;

  bool hasError = false;
  String errorMessage;
  TextEditingController controller = TextEditingController();

  VerifyData _data = VerifyData();

  void _signInWithPhone() async {
    if (_form.currentState.validate()) {
      // If the form is valid, display a Snackbar.
      _form.currentState.save();
      print(_data.otpCode);

      final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: _data.verificationId,
      smsCode: _data.otpCode,
      );
      try {
        final FirebaseUser user =
            (await _auth.signInWithCredential(credential)).user;
        final FirebaseUser currentUser = await _auth.currentUser();
        final IdTokenResult token = await currentUser.getIdToken();
        print(token);
        assert(user.uid == currentUser.uid);
        setState(() {
          if (user != null) {
            print('Successfully signed in, uid: ' + user.uid);
            setState(() {
              hasError = false; 
            });
          } else {
            print('Sign in failed');
            setState(() {
             hasError = true; 
            });
          }
        });
      } catch (err) {
        print(err);
        setState(() {
          hasError = true; 
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get arguments from route
    final Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;
    _data.verificationId = args['verificationId'];
    _data.phoneNumber = args['phoneNumber'];
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
                      AppLocalizations.of(context).tr('enter_otp') + ' +84' + _data.phoneNumber,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: ScreenUtil.instance.setSp(12.0),
                        height: 1.4
                      )
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      PinCodeTextField(
                        autofocus: false,
                        controller: controller,
                        hideCharacter: false,
                        highlight: true,
                        highlightColor: Colors.blue,
                        defaultBorderColor: Colors.black,
                        hasTextBorderColor: Colors.green,
                        maxLength: pinLength,
                        hasError: hasError,
                        onTextChanged: (text) {
                          setState(() {
                            hasError = false;
                          });
                        },
                        onDone: (otpCode) {
                          _data.otpCode = otpCode;
                        },
                        pinCodeTextFieldLayoutType: PinCodeTextFieldLayoutType.AUTO_ADJUST_WIDTH,
                        wrapAlignment: WrapAlignment.start,
                        pinBoxDecoration: ProvidedPinBoxDecoration.underlinedPinBoxDecoration,
                        pinTextStyle: TextStyle(fontSize: 20.0),
                        pinTextAnimatedSwitcherTransition: ProvidedPinBoxTextAnimation.scalingTransition,
                        pinTextAnimatedSwitcherDuration: Duration(milliseconds: 200),
                      ),
                      Visibility(
                        child: Text(
                          AppLocalizations.of(context).tr('wrong_pin'),
                          style: TextStyle(color: Colors.red),
                        ),
                        visible: hasError,
                      ),
                    ],
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
                          AppLocalizations.of(context).tr('confirm').toUpperCase(),
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