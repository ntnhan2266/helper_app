import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_localization/easy_localization.dart';

import './screens/splash_screen.dart';
import './screens/home_screen.dart';
import './utils/constants.dart';
import './utils/route_names.dart';

void main() {
  runApp(EasyLocalization(child: SmartRabbitApp()));
}

class SmartRabbitApp extends StatefulWidget {
  @override
  _SmartRabbitAppState createState() => _SmartRabbitAppState();
}

class _SmartRabbitAppState extends State<SmartRabbitApp> {
  

  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: MaterialApp(
        title: APP_NAME,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          // App-specific localization
          EasylocaLizationDelegate(
              locale: data.locale,
              path: 'assets/i18n'
          ),
        ],
        supportedLocales: [Locale('vi', 'VN'), Locale('en', 'US')],
        locale: data.savedLocale,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen(),
        onGenerateRoute: _getRoute
      ),
    );
  }

  Route _getRoute(RouteSettings settings) {
    switch (settings.name){
      case homeRoute:
        return _buildRoute(settings, HomeScreen());
      default:
        return null;
    }
  }

  MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder){
    return new MaterialPageRoute(
      settings: settings,
      builder: (BuildContext context) => builder,
    );
  }
}
