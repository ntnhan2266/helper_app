import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  int tabIndex = 0;
  void _changeTabIndex(index) {
    setState(() {
      tabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        body: Center(
          child: Text(AppLocalizations.of(context).tr('home'))
        ),
        bottomNavigationBar: BottomNavigationBar(
        // Disable title of bar item
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: Colors.white,
          currentIndex: tabIndex,
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
            _changeTabIndex(index);
          },
        ),
      )
    );
  }
}