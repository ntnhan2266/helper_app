import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

import './screens/calendar_screen.dart';
import './screens/about_screen.dart';
import './screens/search_result_screen.dart';
import './screens/helper_management_screen.dart';
import './screens/setting_screen.dart';
import './screens/helper_detail_screen.dart';
import './screens/helper_register_screen.dart';
import './screens/service_status_screen.dart';
import './screens/user_detail_screen.dart';
import './screens/splash_screen.dart';
import './screens/home_screen.dart';
import './screens/intro_screen.dart';
import './screens/auth_screen.dart';
import './screens/register_screen.dart';
import './screens/login_screen.dart';
import './screens/verify_code_screen.dart';
import './screens/service_detail_screen.dart';
import './screens/choose_maid_screen.dart';
import './screens/verify_booking.dart';
import './screens/message_screen.dart';
import './models/user.dart';
import './models/category_list.dart';
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
  50: Color.fromRGBO(42, 77, 108, .1),
  100: Color.fromRGBO(42, 77, 108, .2),
  200: Color.fromRGBO(42, 77, 108, .3),
  300: Color.fromRGBO(42, 77, 108, .4),
  400: Color.fromRGBO(42, 77, 108, .5),
  500: Color.fromRGBO(42, 77, 108, .6),
  600: Color.fromRGBO(42, 77, 108, .7),
  700: Color.fromRGBO(42, 77, 108, .8),
  800: Color.fromRGBO(42, 77, 108, .9),
  900: Color.fromRGBO(42, 77, 108, 1),
};

class _SmartRabbitAppState extends State<SmartRabbitApp> {
  MaterialColor colorCustom = MaterialColor(0xFF880E4F, color);

  @override
  void initState() {
    super.initState();
  }

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
        ChangeNotifierProvider.value(
          value: CategoryList(),
        )
      ],
      child: EasyLocalizationProvider(
        data: data,
        child: OverlaySupport(
          child: MaterialApp(
            title: APP_NAME,
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              // App-specific localization
              EasylocaLizationDelegate(
                  locale: data.locale, path: 'assets/i18n'),
            ],
            supportedLocales: [Locale('vi', 'VN'), Locale('en', 'US')],
            locale: data.savedLocale,
            theme: ThemeData(
                primarySwatch: colorCustom,
                primaryColor: Color.fromRGBO(42, 77, 108, 1),
                textTheme: Theme.of(context).textTheme.copyWith(
                      title: TextStyle(
                        color: Color.fromRGBO(42, 77, 108, 1),
                        fontFamily: 'Pacifico-Regular',
                      ),
                    ),
                fontFamily: 'Roboto',
                scaffoldBackgroundColor: Colors.white),
            home: SplashScreen(),
            onGenerateRoute: _getRoute,
          ),
        ),
      ),
    );
  }

  Route _getRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeScreenRoute:
        return _buildRoute(
            settings,
            HomeScreen(
                tabIndex: settings.arguments == null
                    ? null
                    : (settings.arguments as HomeScreen).tabIndex));
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
      case chooseMaidRoute:
        return _buildRoute(
          settings,
          settings.arguments == null
              ? ChooseMaidScreen()
              : ChooseMaidScreen(data: settings.arguments),
        );
      case verifyBookingRoute:
        return _buildRoute(settings, VerifyBookingScreen());
      case userDetailRoute:
        return _buildRoute(settings, UserDetailScreen());
      case helperRegisterRoute:
        return _buildRoute(settings, HelperRegisterScreen());
      case helperDetailRoute:
        return _buildRoute(settings, HelperDetailScreen());
      case serviceStatusRoute:
        return _buildRoute(settings, ServiceStatusScreen());
      case messageRoute:
        return _buildRoute(settings, MessageScreen());
      case helperManagementRoute:
        return _buildRoute(settings, HelperManagementScreen());
      case settingRoute:
        return _buildRoute(settings, SettingScreen());
      case searchResultRoute:
        return _buildRoute(
          settings,
          settings.arguments == null
              ? SearchResultScreen()
              : SearchResultScreen(
                  search: (settings.arguments as SearchResultScreen).search,
                  searchServices:
                      (settings.arguments as SearchResultScreen).searchServices,
                  searchAreas:
                      (settings.arguments as SearchResultScreen).searchAreas,
                  minSalary:
                      (settings.arguments as SearchResultScreen).minSalary,
                  maxSalary:
                      (settings.arguments as SearchResultScreen).maxSalary,
                  sort: (settings.arguments as SearchResultScreen).sort,
                ),
        );
      case aboutRoute:
        return _buildRoute(settings, AboutScreen());
      case calendarRoute:
        return _buildRoute(settings, CalendarScreen());
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
