import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:smart_rabbit/utils/route_names.dart';

import '../services/notification.dart';
import '../widgets/tabs/home_tab.dart';
import '../widgets/tabs/service_category_tab.dart';
import '../widgets/tabs/service_history_tab.dart';
import '../widgets/tabs/notification_tab.dart';
import '../widgets/tabs/user_profile_tab.dart';
import '../services/user.dart';
import '../services/category.dart';
import '../models/user.dart';
import '../models/category_list.dart';

class HomeScreen extends StatefulWidget {
  final int tabIndex;

  const HomeScreen({this.tabIndex});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  int _tabIndex;
  PageController _pageController;
  int _newNotification = 0;

  // Firebase messaging
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    firebaseCloudMessagingListeners();
    _countNotification();

    setState(() {
      if (widget.tabIndex != null) {
        _tabIndex = widget.tabIndex;
        _pageController = PageController(
          initialPage: widget.tabIndex,
          keepPage: true,
        );
      } else {
        _tabIndex = 0;
        _pageController = PageController(
          initialPage: 0,
          keepPage: true,
        );
      }
    });
  }

  void firebaseCloudMessagingListeners() {
    if (Platform.isIOS) iOS_Permission();

    _firebaseMessaging.getToken().then((token) {
      // print(token);
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
        showOverlayNotification((context) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 3.0),
            elevation: 4.0,
            child: SafeArea(
              child: ListTile(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    homeScreenRoute,
                    arguments: HomeScreen(tabIndex: 3),
                  );
                },
                contentPadding:
                    EdgeInsets.only(top: 10.0, bottom: 10.0, left: 5.0),
                leading: SizedBox.fromSize(
                  size: const Size(40, 40),
                  child: ClipOval(
                    child: Icon(
                      Icons.notifications_active,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                title: Text(message['notification']['title']),
                subtitle: Text(
                  AppLocalizations.of(context).tr(
                    message['data']['message'],
                    args: [
                      message['data']['name'],
                      Localizations.localeOf(context) == Locale('vi', 'VN')
                          ? message['data']['category_vi']
                          : message['data']['category_en'],
                    ],
                  ),
                ),
                trailing: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      OverlaySupportEntry.of(context).dismiss();
                    }),
              ),
            ),
          );
        }, duration: Duration(milliseconds: 4000));
        _countNotification();
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    );
  }

  void iOS_Permission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }

  void _countNotification() async {
    final res = await NotificationService.count();
    if (res['isValid'] && mounted) {
      setState(() {
        _newNotification = res['count'];
      });
    }
  }

  void _getUserData() async {
    await UserService.getUser().then((res) {
      if (res['isValid']) {
        final user = res['user'];
        final userProvider = Provider.of<User>(context, listen: true);
        userProvider.fromJson(user);
      }
    });
  }

  _getCategoriesData() async {
    // Load categories into provider
    await CategoryService.getAvailableCategories().then((res) {
      if (res['isValid']) {
        final categories = res['categories'];
        final categoryListProvider =
            Provider.of<CategoryList>(context, listen: false);
        categoryListProvider.getDate(categories);
      }
    });
  }

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    final userProvider = Provider.of<User>(context, listen: true);
    final categoryListProvider =
        Provider.of<CategoryList>(context, listen: false);
    if (userProvider.id == null) {
      _getUserData();
    }
    if (categoryListProvider.categories == null) {
      _getCategoriesData();
    }
  }

  Widget _buildPageView() {
    return PageView(
      controller: _pageController,
      onPageChanged: (index) {
        _pageChanged(index);
      },
      children: <Widget>[
        HomeTab(bottomTapped: _bottomTapped),
        ServiceCategoryTab(),
        ServiceHistoryTab(),
        NotificationTab(countNotification: _countNotification),
        UserProfileTab()
      ],
    );
  }

  void _pageChanged(int index) {
    setState(() {
      _tabIndex = index;
    });
  }

  void _bottomTapped(int index) {
    setState(() {
      _tabIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  Widget _buildAppBar(BuildContext context) {
    switch (_tabIndex) {
      case 1:
        return AppBar(
          centerTitle: true,
          title: Text(AppLocalizations.of(context).tr('choose_service_type'),
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w300)),
          backgroundColor: Colors.white,
          elevation: 0,
        );
        break;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: _buildPageView(),
        bottomNavigationBar: BottomNavigationBar(
          // Disable title of bar item
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: Colors.white,
          currentIndex: _tabIndex,
          selectedItemColor: Color.fromRGBO(75, 134, 180, 1),
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                title: new Text('')),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.add_circle,
                ),
                title: new Text('')),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.history,
                ),
                title: new Text('')),
            BottomNavigationBarItem(
                icon: _newNotification > 0
                    ? Container(
                        width: 30.0,
                        height: 30.0,
                        child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: <Widget>[
                            Icon(Icons.notifications),
                            Positioned(
                              right: 0,
                              top: 1,
                              child: new Container(
                                padding: EdgeInsets.all(2),
                                decoration: new BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                constraints: BoxConstraints(
                                  minWidth: 14,
                                  minHeight: 14,
                                ),
                                child: Text(
                                  _newNotification.toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 8,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    : Icon(Icons.notifications),
                title: new Text('')),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.account_circle,
                ),
                title: new Text(''))
          ],
          onTap: (index) {
            _bottomTapped(index);
          },
        ),
      ),
    );
  }
}
