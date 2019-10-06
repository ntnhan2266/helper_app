import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/form/form_label.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  Locale locale;

  Widget languageButton(
      {@required String label,
      @required double width,
      @required Locale locale,
      @required VoidCallback onPressed}) {
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: RaisedButton(
        textTheme: ButtonTextTheme.primary,
        color: this.locale == locale
            ? Theme.of(context).primaryColor
            : Colors.white,
        child: Text(label),
        onPressed: onPressed,
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
    setState(() {
      locale = data.savedLocale;
    });
    // Get screen width
    final screenWidth = MediaQuery.of(context).size.width;
    // Build slide list
    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text(
            AppLocalizations.of(context).tr('setting'),
          ),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(20.0),
          child: ListView(
            children: <Widget>[
              FormLabel(
                AppLocalizations.of(context).tr('language'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  languageButton(
                    label: AppLocalizations.of(context).tr('vi'),
                    width: screenWidth * 0.4,
                    locale: Locale('vi', 'VN'),
                    onPressed: () {
                      data.changeLocale(Locale("vi", "VN"));
                    },
                  ),
                  languageButton(
                    label: AppLocalizations.of(context).tr('en'),
                    width: screenWidth * 0.4,
                    locale: Locale('en', 'US'),
                    onPressed: () {
                      data.changeLocale(Locale("en", "US"));
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
