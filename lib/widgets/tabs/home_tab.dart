import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_rabbit/services/maid.dart';

import '../../models/service_category.dart';
import '../../models/user_maid.dart';
import '../../widgets/components/home_search_container.dart';
import '../../utils/dummy_data.dart';
import '../../utils/route_names.dart';
import '../../configs/api.dart';

class HomeTab extends StatefulWidget {
  final Function bottomTapped;

  const HomeTab({Key key, this.bottomTapped}) : super(key: key);

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  var _categories = categoriesData.sublist(0, 4);
  bool _isShowModalBottomSheet = false;
  List<UserMaid> users = [];

  Widget _inputSearch() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey[50],
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

  // Widget _searchLabel(String label) {
  //   return Container(
  //     alignment: Alignment.center,
  //     padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
  //     child: Text(label.toUpperCase()),
  //   );
  // }

  // Widget _search() {
  //   final screenHeight = MediaQuery.of(context).size.height;
  //   return StatefulBuilder(
  //     builder: (BuildContext context, StateSetter setState) {
  //       return AnimatedContainer(
  //         height: screenHeight * 0.95,
  //         padding: EdgeInsets.symmetric(horizontal: 10.0),
  //         child: Column(
  //           children: <Widget>[
  //             Padding(
  //               padding: const EdgeInsets.symmetric(vertical: 20.0),
  //               child: Text(
  //                 AppLocalizations.of(context).tr('search').toUpperCase(),
  //                 style: TextStyle(
  //                   fontWeight: FontWeight.bold,
  //                   fontSize: ScreenUtil.instance.setSp(20.0),
  //                 ),
  //               ),
  //             ),
  //             _inputSearch(),
  //             Expanded(
  //               child: ListView(
  //                 children: <Widget>[
  //                   _searchLabel(AppLocalizations.of(context).tr('service')),
  //                   Wrap(
  //                     alignment: WrapAlignment.center,
  //                     children: categoriesData.map((item) {
  //                       return Padding(
  //                         padding: EdgeInsets.symmetric(horizontal: 2.0),
  //                         child: ChoiceChip(
  //                           label: Text(
  //                             AppLocalizations.of(context).tr(item.serviceName),
  //                           ),
  //                           selected: searchServices.contains(item.id),
  //                           onSelected: (selected) {
  //                             if (selected) {
  //                               setState(() {
  //                                 searchServices.add(item.id);
  //                               });
  //                             } else {
  //                               setState(() {
  //                                 searchServices.remove(item.id);
  //                               });
  //                             }
  //                           },
  //                         ),
  //                       );
  //                     }).toList(),
  //                   ),
  //                   _searchLabel(
  //                       AppLocalizations.of(context).tr('support_area')),
  //                   Wrap(
  //                     alignment: WrapAlignment.center,
  //                     children:
  //                         Iterable<int>.generate(22, (i) => i + 1).map((i) {
  //                       return Padding(
  //                         padding: EdgeInsets.symmetric(horizontal: 2.0),
  //                         child: ChoiceChip(
  //                           label: Text(
  //                             AppLocalizations.of(context)
  //                                 .tr(Utils.intToSupportArea(i)),
  //                           ),
  //                           selected: searchAreas.contains(i),
  //                           onSelected: (selected) {
  //                             if (selected) {
  //                               setState(() {
  //                                 searchAreas.add(i);
  //                               });
  //                             } else {
  //                               setState(() {
  //                                 searchAreas.remove(i);
  //                               });
  //                             }
  //                           },
  //                         ),
  //                       );
  //                     }).toList(),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //         duration: Duration(microseconds: 5000),
  //       );
  //     },
  //   );
  // }

  @override
  void initState() {
    super.initState();
    getTopMaid();
  }

  void getTopMaid() async {
    final res = await MaidService.getTopRatingMaids();
    print(res);
    if (!res['hasError']) {
      final List<UserMaid> data = [];
      final maids = res['maids'];
      for (var i = 0; i < maids.length; i++) {
        final maid = maids[i];
        data.add(UserMaid.getMaid(maid));
      }
      setState(() {
        users = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              AppLocalizations.of(context).tr('home_tab_welcome_title'),
              style: TextStyle(
                fontSize: ScreenUtil.instance.setSp(32.0),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: _inputSearch(),
          ),
          Container(
            color: Colors.blueGrey[50],
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  AppLocalizations.of(context).tr('suggested_services'),
                  style: TextStyle(
                    fontSize: ScreenUtil.instance.setSp(17.0),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    widget.bottomTapped(1);
                  },
                  child: Text(
                    AppLocalizations.of(context).tr('more'),
                    style: TextStyle(
                      fontSize: ScreenUtil.instance.setSp(15.0),
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: _categories.map((category) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    serviceDetailRoute,
                    arguments: {'id': category.id},
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
                          child: Image.asset(
                            category.imgURL,
                            width: MediaQuery.of(context).size.width / 8,
                            height: MediaQuery.of(context).size.width / 8,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Text(
                          AppLocalizations.of(context).tr(category.serviceName),
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
          Container(
            color: Colors.blueGrey[50],
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              AppLocalizations.of(context)
                  .tr('home_tab_title_highest_ratting_users'),
              style: TextStyle(
                fontSize: ScreenUtil.instance.setSp(17.0),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10, left: 20),
            height: 250,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              primary: false,
              itemCount: users == null ? 0 : users.length,
              itemBuilder: (BuildContext context, int index) {
                UserMaid user = users.toList()[index];
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
                                    'assets/images/retangle_avatar.png',
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
          Container(
            color: Colors.blueGrey[50],
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              AppLocalizations.of(context).tr('home_tab_title_recent_service'),
              style: TextStyle(
                fontSize: ScreenUtil.instance.setSp(17.0),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: ListView.separated(
              primary: false,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                ServiceCategory service =
                    categoriesData[new Random().nextInt(categoriesData.length)];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: InkWell(
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          Image.asset(
                            service.imgURL,
                            width: MediaQuery.of(context).size.width / 4,
                            height: MediaQuery.of(context).size.width / 4,
                          ),
                          Container(
                            width:
                                MediaQuery.of(context).size.width * 3 / 4 - 30,
                            padding: EdgeInsets.only(left: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    AppLocalizations.of(context)
                                        .tr(service.serviceName),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: ScreenUtil.instance.setSp(15.0),
                                    ),
                                    maxLines: 2,
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                SizedBox(height: 3),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.location_on,
                                      size: 13,
                                      color: Colors.blueGrey[300],
                                    ),
                                    SizedBox(width: 3),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Quận 5, HCM",
                                        style: TextStyle(
                                          fontSize:
                                              ScreenUtil.instance.setSp(14.0),
                                          color: Colors.blueGrey[300],
                                        ),
                                        maxLines: 1,
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "100\$",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: ScreenUtil.instance.setSp(14.0),
                                    ),
                                    maxLines: 1,
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (BuildContext context) {
                      //       return Details();
                      //     },
                      //   ),
                      // );
                    },
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  height: 0,
                );
              },
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
