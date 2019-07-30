import 'package:SmartRabit/util/const.dart';
import 'package:flutter/material.dart';
import 'package:SmartRabit/screens/main_screen.dart';
import 'package:flutter/painting.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

class OtpScreen extends StatefulWidget {
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Constants.primaryColor,
        child: Center(
          child: ListView(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                height: MediaQuery.of(context).size.height * 0.75,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Smart Rabbit",
                        style: TextStyle(
                            fontSize: 35,
                            fontFamily: "Pacifico",
                            color: Constants.primaryTextColor),
                      ),
                    ),
                    PinCodeTextField(
                      autofocus: true,
                      pinBoxWidth: 40.0,
                      pinBoxHeight: 40.0,
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(horizontal: 40.0),
                          child: RaisedButton(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 18.0),
                              child: Text(
                                "TIẾP THEO",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Constants.lightTextColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            color: Constants.primaryColor,
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return MainScreen();
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 18.0, bottom: 14.0),
                          child: GestureDetector(
                            child: Text(
                              "Gửi lại mã OTP",
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
