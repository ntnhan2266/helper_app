import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../widgets/tabs/home_tab.dart';
import '../widgets/tabs/service_category_tab.dart';
import '../widgets/tabs/service_history_tab.dart';
import '../widgets/tabs/notification_tab.dart';
import '../widgets/tabs/user_profile_tab.dart';

class HomeScreen extends StatefulWidget {
  final int tabIndex;

  const HomeScreen({this.tabIndex});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  int _tabIndex;

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  Widget _buildPageView() {
    return PageView(
      controller: pageController,
      onPageChanged: (index) {
        _pageChanged(index);
      },
      children: <Widget>[
        HomeTab(bottomTapped: _bottomTapped),
        ServiceCategoryTab(),
        ServiceHistoryTab(),
        NotificationTab(),
        UserProfileTab()
      ],
    );
  }

  @override
  void initState() {
    super.initState();

    print(widget.tabIndex);
    setState(() {
      if (widget.tabIndex != null) {
        _tabIndex = widget.tabIndex;
        pageController.jumpToPage(widget.tabIndex);
      } else {
        _tabIndex = 0;
      }
    });
  }

  void _pageChanged(int index) {
    setState(() {
      _tabIndex = index;
    });
  }

  void _bottomTapped(int index) {
    setState(() {
      _tabIndex = index;
      pageController.jumpToPage(index);
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
                icon: Icon(
                  Icons.notifications,
                ),
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
