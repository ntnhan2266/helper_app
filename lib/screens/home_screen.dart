import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../widgets/tabs/home_tab.dart';
import '../widgets/tabs/service_category_tab.dart';
import '../widgets/tabs/service_history_tab.dart';
import '../widgets/tabs/favourite_staff_tab.dart';
import '../widgets/tabs/user_profile_tab.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  int _tabIndex = 0;
  Widget body = HomeTab();

  void _changeTabIndex(int index, BuildContext context) {
    setState(() {
      setState(() {
        _tabIndex = index;
      });
      switch (index) {
        case 0:
          setState(() {
            body = HomeTab();
          });
          break;
        case 1:
          setState(() {
            body = ServiceCategoryTab();
          });
          break;
        case 2:
          setState(() {
            body = ServiceHistoryTab();
          });
          break;
        case 3:
          setState(() {
            body = FavouriteStaffTab();
          });
          break;
        case 4:
          setState(() {
            body = UserProfileTab();
          });
          break;
        default:
          setState(() {
            body = HomeTab();
          });
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        body: body,
        bottomNavigationBar: BottomNavigationBar(
        // Disable title of bar item
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: Colors.white,
          currentIndex: _tabIndex,
          selectedItemColor: Color.fromRGBO(75, 134, 180, 1),
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed ,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              title: new Text('')
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.date_range,
              ),
              title: new Text('')
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.list,
              ),
              title: new Text('')
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
              ),
              title: new Text('')
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle,
              ),
              title: new Text('')
            )
          ],
          onTap: (index){
            _changeTabIndex(index, context);
          },
        ),
      ),
    );
  }
}