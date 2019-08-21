import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: 
        Scaffold(
      appBar: AppBar(
        title: Text('App bar'),
        actions: <Widget>[
            FlatButton(
              child: Text("English"),
              color: Localizations.localeOf(context).languageCode == "en"
                  ? Colors.lightBlueAccent
                  : Colors.blue,
              onPressed: () {
                this.setState(() {
                  data.changeLocale(Locale("en","US"));
                  print(Localizations.localeOf(context).languageCode);
                });
              },
            ),
            FlatButton(
              child: Text("VN"),
              color: Localizations.localeOf(context).languageCode == "vi"
                  ? Colors.lightBlueAccent
                  : Colors.blue,
              onPressed: () {
                this.setState(() {
                  data.changeLocale(Locale("vi","VN"));
                  print(Localizations.localeOf(context).languageCode);
                });
              },
            )
          ],
      ),
      body: Center(
        child: Text(AppLocalizations.of(context).tr('test'))
      )
    )
    );
  }
}