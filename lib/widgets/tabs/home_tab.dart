import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:pk_skeleton/pk_skeleton.dart';

import '../../services/booking.dart';
import '../../services/maid.dart';
import '../../models/user.dart';
import '../../models/user_maid.dart';
import '../../models/service_details.dart';
import '../../models/category_list.dart';
import '../../utils/route_names.dart';
import '../../utils/constants.dart';
import '../../configs/api.dart';
import '../service_history_list_item.dart';
import '../../widgets/components/home_search_container.dart';

class HomeTab extends StatefulWidget {
  final Function bottomTapped;

  const HomeTab({Key key, this.bottomTapped}) : super(key: key);

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  bool _isShowModalBottomSheet = false;
  List<UserMaid> _topUsers = List();
  bool _isLoadingTopUsers = true;
  List<ServiceDetails> _recentServices = List();
  bool _isLoadingRecentServices = true;

  Widget _inputSearch() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey[50].withOpacity(0.7),
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      child: TextField(
        focusNode: AlwaysDisabledFocusNode(),
        onTap: () {
          if (!_isShowModalBottomSheet) {
            setState(() {
              _isShowModalBottomSheet = true;
            });
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(25.0),
                ),
              ),
              builder: (builder) {
                return HomeSearchContainer();
              },
            ).whenComplete(() {
              setState(() {
                _isShowModalBottomSheet = false;
              });
            });
          }
        },
        style: TextStyle(
          fontSize: ScreenUtil.instance.setSp(16.0),
          color: Colors.blueGrey[300],
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(5.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(5.0),
          ),
          hintText: AppLocalizations.of(context).tr('home_tab_search_hint'),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.blueGrey[300],
          ),
          hintStyle: TextStyle(
            fontSize: ScreenUtil.instance.setSp(16.0),
            color: Colors.blueGrey[300],
          ),
        ),
        maxLines: 1,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _getTopMaid();
    _getBooking();
  }

  void _getTopMaid() async {
    final res = await MaidService.getTopRatingMaids();
    if (!res['hasError']) {
      final List<UserMaid> data = [];
      final maids = res['maids'];
      for (var i = 0; i < maids.length; i++) {
        final maid = maids[i];
        data.add(UserMaid.getMaid(maid));
      }
      setState(() {
        _topUsers = data;
        _isLoadingTopUsers = false;
      });
    } else {
      setState(() {
        _isLoadingTopUsers = false;
      });
    }
  }

  void _getBooking() async {
    final res =
        await BookingService.getBookingsByStatus(COMPLETED, pageSize: 2);
    if (res['isValid']) {
      setState(() {
        _recentServices.addAll(res['data']);
        _isLoadingRecentServices = false;
      });
    } else {
      setState(() {
        _isLoadingRecentServices = false;
      });
    }
  }

  Widget _homeComponent(
      {@required String title,
      Widget action,
      @required Widget content,
      bool isLoading = true,
      bool isEmpty = false,
      bool hasNext = true}) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                AppLocalizations.of(context).tr(title),
                style: TextStyle(
                  fontSize: ScreenUtil.instance.setSp(17.0),
                  fontWeight: FontWeight.w500,
                ),
              ),
              action != null ? action : Container(),
            ],
          ),
        ),
        isLoading
            ? PKCardPageSkeleton(totalLines: 1)
            : (isEmpty
                ? Column(
                    children: <Widget>[
                      Image.asset(
                        'assets/images/not_found.jpg',
                        width: MediaQuery.of(context).size.width * 0.5,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 20.0),
                        child:
                            Text(AppLocalizations.of(context).tr('no_content')),
                      )
                    ],
                  )
                : content),
        hasNext
            ? Container(
                color: Colors.blueGrey[50],
                height: 10,
              )
            : Container(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final categoryListProvider =
        Provider.of<CategoryList>(context, listen: false);
    final categoriesData = categoryListProvider.categories;
    var _categories = categoriesData != null
        ? categoriesData.sublist(
            0, categoriesData.length > 4 ? 4 : categoriesData.length)
        : [];
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            height: 260,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/home_welcome.jpg"),
                fit: BoxFit.cover,
                alignment: Alignment.bottomCenter
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Consumer<User>(
                    builder: (ctx, user, _) => Text(
                      AppLocalizations.of(context).tr('home_tab_welcome_title',
                          args: [user.name != null ? user.name : '--']),
                      style: TextStyle(
                        fontSize: ScreenUtil.instance.setSp(25.0),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: _inputSearch(),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.blueGrey[50],
            height: 10,
          ),
          _homeComponent(
            title: 'suggested_services',
            isLoading: false,
            action: GestureDetector(
              onTap: () {
                widget.bottomTapped(1);
              },
              child: Text(
                AppLocalizations.of(context).tr('more'),
                style: TextStyle(
                  fontSize: ScreenUtil.instance.setSp(13.0),
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _categories.map((category) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      serviceDetailRoute,
                      arguments: {'serviceCategory': category},
                    );
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 4 - 20.0,
                    child: Column(
                      children: <Widget>[
                        Card(
                          elevation: 3.0,
                          shape: CircleBorder(),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundImage: category.icon != null
                                  ? NetworkImage(
                                      APIConfig.hostURL + category.icon)
                                  : AssetImage('assets/images/category.png'),
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Text(
                            Localizations.localeOf(context).languageCode == "en"
                                ? category.nameEn
                                : category.nameVi,
                            style: TextStyle(
                              fontSize: ScreenUtil.instance.setSp(13.0),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          _homeComponent(
            title: 'home_tab_title_highest_ratting_users',
            isLoading: _isLoadingTopUsers,
            isEmpty: _topUsers == null || _topUsers.length == 0,
            content: Container(
              padding: EdgeInsets.only(top: 10, left: 20),
              height: 250,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                primary: false,
                itemCount: _topUsers == null ? 0 : _topUsers.length,
                itemBuilder: (BuildContext context, int index) {
                  UserMaid user = _topUsers.toList()[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: InkWell(
                      child: Container(
                        height: 250,
                        width: 140,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: user.avatar != null
                                  ? Image.network(
                                      "${APIConfig.hostURL + user.avatar}",
                                      height: 178,
                                      width: 140,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      'assets/images/avt_default.png',
                                      height: 178,
                                      width: 140,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            SizedBox(height: 7),
                            Text(
                              "${user.name}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenUtil.instance.setSp(15.0),
                              ),
                              maxLines: 2,
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(height: 3),
                            RatingBar(
                              initialRating: user.rating,
                              allowHalfRating: true,
                              ignoreGestures: true,
                              itemSize: ScreenUtil.instance.setSp(20),
                              itemCount: 5,
                              itemPadding: EdgeInsets.only(right: 2.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {},
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(helperDetailRoute, arguments: user.id);
                      },
                    ),
                  );
                },
              ),
            ),
          ),
          _homeComponent(
            title: 'home_tab_title_recent_service',
            isLoading: _isLoadingRecentServices,
            isEmpty: _recentServices == null || _recentServices.length == 0,
            action: GestureDetector(
              onTap: () {
                widget.bottomTapped(2);
              },
              child: Text(
                AppLocalizations.of(context).tr('more'),
                style: TextStyle(
                  fontSize: ScreenUtil.instance.setSp(13.0),
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            content: Column(
              children: _recentServices.map((service) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                  padding: EdgeInsets.zero,
                  child: ServiceHistoryListItem(service),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
