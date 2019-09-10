import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

import './screens/splash_screen.dart';
import './screens/home_screen.dart';
import './screens/intro_screen.dart';
import './screens/auth_screen.dart';
import './screens/register_screen.dart';
import './screens/login_screen.dart';
import './screens/verify_code_screen.dart';
import './screens/service_detail_screen.dart';
import './models/user.dart';

import './utils/constants.dart';
import './utils/route_names.dart';

void main() {
  runApp(EasyLocalization(child: SmartRabbitApp()));
}

class SmartRabbitApp extends StatefulWidget {
  @override
  _SmartRabbitAppState createState() => _SmartRabbitAppState();
}

Map<int, Color> color = {
  50: Color.fromRGBO(75, 134, 180, .1),
  100: Color.fromRGBO(75, 134, 180, .2),
  200: Color.fromRGBO(75, 134, 180, .3),
  300: Color.fromRGBO(75, 134, 180, .4),
  400: Color.fromRGBO(75, 134, 180, .5),
  500: Color.fromRGBO(75, 134, 180, .6),
  600: Color.fromRGBO(75, 134, 180, .7),
  700: Color.fromRGBO(75, 134, 180, .8),
  800: Color.fromRGBO(75, 134, 180, .9),
  900: Color.fromRGBO(75, 134, 180, 1),
};

class _SmartRabbitAppState extends State<SmartRabbitApp> {
  
  MaterialColor colorCustom = MaterialColor(0xFF880E4F, color);

  @override
  Widget build(BuildContext context) {
    // Prevent device orientation changes and force portrait
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
    ]);
    // Localization
    var data = EasyLocalizationProvider.of(context).data;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: User(),
        ),
      ],
      child: EasyLocalizationProvider(
      data: data,
      child: MaterialApp(
          title: APP_NAME,
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            // App-specific localization
            EasylocaLizationDelegate(locale: data.locale, path: 'assets/i18n'),
          ],
          supportedLocales: [Locale('vi', 'VN'), Locale('en', 'US')],
          locale: data.savedLocale,
          theme: ThemeData(
              primarySwatch: colorCustom,
              primaryColor: Color.fromRGBO(75, 134, 180, 1),
              textTheme: Theme.of(context).textTheme.copyWith(
                title: TextStyle(
                  color: Color.fromRGBO(42, 77, 108, 1),
                  fontFamily: 'Pacifico-Regeular'
                )
              ),
              fontFamily: 'Roboto',
              scaffoldBackgroundColor: Colors.white
          ),
          home: SplashScreen(),
          onGenerateRoute: _getRoute),
      ),
    );
  }

  Route _getRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeScreenRoute:
        return _buildRoute(settings, HomeScreen());
      case introScreenRoute:
        return _buildRoute(settings, IntroScreen());
      case authScreenRoute:
        return _buildRoute(settings, AuthScreen());
      case registerScreenRoute:
        return _buildRoute(settings, RegisterScreen());
      case loginScreenRoute:
        return _buildRoute(settings, LoginScreen());
      case verificationCodeRoute:
        return _buildRoute(settings, VerifyCodeScreen());
      case serviceDetailRoute:
        return _buildRoute(settings, ServiceDetailScreen());
      default:
        return null;
    }
  }

  MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
    return new MaterialPageRoute(
      settings: settings,
      builder: (BuildContext context) => builder,
    );
  }
}
