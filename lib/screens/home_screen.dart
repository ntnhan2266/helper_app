import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:smart_rabbit/screens/account_screen.dart';
import 'package:smart_rabbit/screens/user_screen.dart';
import 'package:smart_rabbit/utils/constants.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  PageController _pageController;
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: onPageChanged,
          children: <Widget>[
            UserScreen(),
            UserScreen(),
            UserScreen(),
            AccountScreen(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text(
                AppLocalizations.of(context).tr('home'),
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.library_add),
              title: Text(
                AppLocalizations.of(context).tr('home'),
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.library_books),
              title: Text(
                AppLocalizations.of(context).tr('home'),
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text(
                AppLocalizations.of(context).tr('account'),
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
          ],
          selectedItemColor: Color(MAIN_COLOR),
          unselectedItemColor: Colors.black45,
          type: BottomNavigationBarType.fixed,
          currentIndex: _page,
          onTap: (int item) {
            setState(() {
              _page = item;
            });
            _pageController.jumpToPage(item);
          },
        ),
      ),
    );
  }

  void navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }
}
