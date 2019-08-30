import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constants.dart';
import '../utils/route_names.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  List<Slide> slides = new List();

  void onDonePress() async {
    // If use logged, navigate to home page
    // Else navigatate to sign up/sign in page
    // Navigator.of(context).pushReplacementNamed('/home');
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(IS_FIRST_LOGIN, false);
    // Navigate into login screen
    Navigator.of(context).pushReplacementNamed(authScreenRoute);
  }

  void _buildSlideList(BuildContext context) {
    slides.add(
      new Slide(
        title: AppLocalizations.of(context).tr('intro_slide_1_title'),
        styleTitle: TextStyle(color: Colors.black, fontSize: 28, fontWeight: FontWeight.bold),
        marginTitle: EdgeInsets.only(top: 80.0),
        description: AppLocalizations.of(context).tr('intro_slide_1_description'),
        styleDescription: TextStyle(color: Colors.black, fontSize: 16),
        marginDescription: EdgeInsets.only(top: 10.0),
        backgroundImage: "assets/images/speed.png",
        backgroundOpacity: 0.0,
      ),
    );
    slides.add(
      new Slide(
        title: AppLocalizations.of(context).tr('intro_slide_2_title'),
        styleTitle: TextStyle(color: Colors.black, fontSize: 28, fontWeight: FontWeight.bold),
        marginTitle: EdgeInsets.only(top: 80.0),
        description: AppLocalizations.of(context).tr('intro_slide_2_description'),
        styleDescription: TextStyle(color: Colors.black, fontSize: 16),
        marginDescription: EdgeInsets.only(top: 10.0),
        backgroundImage: "assets/images/convenience.png",
        backgroundOpacity: 0.0,
      ),
    );
    slides.add(
      new Slide(
        title: AppLocalizations.of(context).tr('intro_slide_3_title'),
        styleTitle: TextStyle(color: Colors.black, fontSize: 28, fontWeight: FontWeight.bold),
        marginTitle: EdgeInsets.only(top: 80.0),
        description: AppLocalizations.of(context).tr('intro_slide_3_description'),
        styleDescription: TextStyle(color: Colors.black, fontSize: 16),
        marginDescription: EdgeInsets.only(top: 10.0),
        backgroundImage: "assets/images/review.png",
        backgroundOpacity: 0.0,
      ),
    );
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
    _buildSlideList(context);
    return EasyLocalizationProvider(
      data: data, 
      child: Scaffold(
        body: Container(
          child: IntroSlider(
            slides: this.slides,
            onDonePress: this.onDonePress,
          )
        )
      )
    );
  }
}