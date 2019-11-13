import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

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

  @override
  void initState() {
    super.initState();

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
        NotificationTab(),
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
