import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../utils/utils.dart';
import '../utils/constants.dart';
import '../services/auth.dart';
import '../services/user.dart';
import '../utils/route_names.dart';
import '../models/user.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class VerifyCodeScreen extends StatefulWidget {
  @override
  _VerifyCodeScreenState createState() => _VerifyCodeScreenState();
}

class VerifyData {
  bool isLogin = false;
  String verificationId = '';
  String name = '';
  String phoneNumber = '';
  String email = '';
  String otpCode = '';
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  final _form = GlobalKey<FormState>();

  int pinLength = 6;
  bool hasError = false;
  String errorMessage = '';
  TextEditingController controller = TextEditingController();

  VerifyData _data = VerifyData();

  // Firebase messaging
  final Firestore _db = Firestore.instance;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  _saveDeviceToken(String uid) async {
    // Get the token for this device
    String fcmToken = await _firebaseMessaging.getToken();

    // Save it to Firestore
    if (fcmToken != null) {
      var tokens = _db
          .collection('users')
          .document(uid)
          .collection('tokens')
          .document(fcmToken);

      await tokens.setData({
        'token': fcmToken,
        'createdAt': FieldValue.serverTimestamp(), // optional
        'platform': Platform.operatingSystem // optional
      });
    }
  }

  void _register(BuildContext context, IdTokenResult idTokenResult) async {
    Map<String, dynamic> res = await AuthService.register(
        email: _data.email,
        name: _data.name,
        phoneNumber: '+84' + _data.phoneNumber,
        token: idTokenResult.token);
    _processAuthData(context, res);
  }

  void _login(BuildContext context, IdTokenResult idTokenResult) async {
    Map<String, dynamic> res =
        await AuthService.login(token: idTokenResult.token);
    _processAuthData(context, res);
  }

  void _processAuthData(BuildContext context, data) async {
    final userProvider = Provider.of<User>(context, listen: false);
    switch (data['responseCode']) {
      case NO_ERROR:
        // Set state
        final res = await UserService.getUser();
        userProvider.fromJson(res['user']);
        final isHost = res['isHost'];
        if (isHost != null && isHost) {
          userProvider.changeIsHost(isHost);
        }
        _saveDeviceToken(userProvider.id);
        Navigator.of(context).pushNamedAndRemoveUntil(
            homeScreenRoute, (Route<dynamic> route) => false);
        break;
      case NOT_REGISTERED_PHONE_NUMBER:
        setState(() {
          hasError = true;
          errorMessage =
              AppLocalizations.of(context).tr('you_have_not_registered');
        });
        break;
      default:
        setState(() {
          hasError = true;
          errorMessage =
              AppLocalizations.of(context).tr('something_went_wrong');
        });
        break;
    }
  }

  void _signInWithPhone(BuildContext context) async {
    if (_form.currentState.validate()) {
      Utils.showLoadingDialog(context);

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
        assert(user.uid == currentUser.uid);
        if (user != null) {
          final IdTokenResult idTokenResult = await currentUser.getIdToken();
          setState(() {
            hasError = false;
          });
          if (_data.isLogin) {
            // Call API to login
            _login(context, idTokenResult);
          } else {
            // Call API to register new account with token, phone number, first name, last name
            _register(context, idTokenResult);
          }
        } else {
          print('Sign in failed');
          setState(() {
            hasError = true;
            errorMessage = AppLocalizations.of(context).tr('wrong_pin');
          });
        }
      } catch (err) {
        print(err);
        setState(() {
          hasError = true;
          errorMessage =
              AppLocalizations.of(context).tr('something_went_wrong');
        });
      } finally {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get arguments from route
    final Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;
    _data.isLogin = args['isLogin'];
    _data.verificationId = args['verificationId'];
    _data.phoneNumber = args['phoneNumber'];
    _data.email = args['email'];
    _data.name = args['name'];
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
        body: Observer(
          builder: (BuildContext context) {
            return Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white,
              padding: EdgeInsets.symmetric(
                horizontal: MAIN_MARGIN,
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
                                vertical:
                                    ScreenUtil.instance.setWidth(MAIN_MARGIN),
                              ),
                              child: Image.asset(
                                'assets/images/send_message.png',
                                height: ScreenUtil.instance.setHeight(120.0),
                              )),
                          SizedBox(height: ScreenUtil.instance.setHeight(20.0)),
                          Container(
                            margin: EdgeInsets.symmetric(
                              vertical:
                                  ScreenUtil.instance.setWidth(MAIN_MARGIN),
                            ),
                            child: Text(
                                AppLocalizations.of(context)
                                    .tr('one_more_step'),
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
                        child: Text(
                            '${AppLocalizations.of(context).tr('enter_otp')} +84 ${_data.phoneNumber}',
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: ScreenUtil.instance.setSp(12.0),
                                height: 1.4)),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                            pinCodeTextFieldLayoutType:
                                PinCodeTextFieldLayoutType.AUTO_ADJUST_WIDTH,
                            wrapAlignment: WrapAlignment.start,
                            pinBoxDecoration: ProvidedPinBoxDecoration
                                .underlinedPinBoxDecoration,
                            pinTextStyle: TextStyle(fontSize: 20.0),
                            pinTextAnimatedSwitcherTransition:
                                ProvidedPinBoxTextAnimation.scalingTransition,
                            pinTextAnimatedSwitcherDuration:
                                Duration(milliseconds: 200),
                            pinBoxWidth:
                                MediaQuery.of(context).size.width * 0.16,
                          ),
                          SizedBox(height: ScreenUtil.instance.setHeight(10.0)),
                          Visibility(
                            child: Text(
                              errorMessage,
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: ScreenUtil.instance.setSp(12.0),
                                color: Colors.red,
                              ),
                            ),
                            visible: hasError,
                          ),
                        ],
                      ),
                      SizedBox(height: ScreenUtil.instance.setHeight(20.0)),
                      InkWell(
                        onTap: () {
                          _signInWithPhone(context);
                        },
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
                                    .tr('confirm')
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
            );
          },
        ),
      ),
    );
  }
}
