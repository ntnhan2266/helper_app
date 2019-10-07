import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/utils.dart';
import '../../utils/dummy_data.dart';

class HomeSearchContainer extends StatefulWidget {
  @override
  _HomeSearchContainerState createState() => _HomeSearchContainerState();
}

class _HomeSearchContainerState extends State<HomeSearchContainer> {
  final TextEditingController _searchControl = new TextEditingController();
  String search = "";
  List<int> searchServices = [];
  List<int> searchAreas = [];

  Widget _inputSearch() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey[50],
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      child: TextField(
        autofocus: true,
        style: TextStyle(
          fontSize: ScreenUtil.instance.setSp(16.0),
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
        controller: _searchControl,
      ),
    );
  }

  Widget _searchLabel(String label) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
      child: Text(label.toUpperCase()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: AnimatedContainer(
        height: screenHeight * 0.95,
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              child: Stack(
                alignment: AlignmentDirectional.centerEnd,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                      AppLocalizations.of(context).tr('search').toUpperCase(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenUtil.instance.setSp(20.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _inputSearch(),
            Expanded(
              child: ListView(
                children: <Widget>[
                  _searchLabel(AppLocalizations.of(context).tr('service')),
                  Wrap(
                    alignment: WrapAlignment.center,
                    children: categoriesData.map((item) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.0),
                        child: ChoiceChip(
                          label: Text(
                            AppLocalizations.of(context).tr(item.serviceName),
                          ),
                          selected: searchServices.contains(item.id),
                          onSelected: (selected) {
                            if (selected) {
                              setState(() {
                                searchServices.add(item.id);
                              });
                            } else {
                              setState(() {
                                searchServices.remove(item.id);
                              });
                            }
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                          },
                        ),
                      );
                    }).toList(),
                  ),
                  _searchLabel(AppLocalizations.of(context).tr('support_area')),
                  Wrap(
                    alignment: WrapAlignment.center,
                    children: Iterable<int>.generate(22, (i) => i + 1).map((i) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.0),
                        child: ChoiceChip(
                          label: Text(
                            AppLocalizations.of(context)
                                .tr(Utils.intToSupportArea(i)),
                          ),
                          selected: searchAreas.contains(i),
                          onSelected: (selected) {
                            if (selected) {
                              setState(() {
                                searchAreas.add(i);
                              });
                            } else {
                              setState(() {
                                searchAreas.remove(i);
                              });
                            }
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                          },
                        ),
                      );
                    }).toList(),
                  ),
                  _searchLabel(AppLocalizations.of(context).tr('salary')),
                  // RangeSlider(
                  //   value: 0.0,
                  //   onChanged: (double value) {},
                  // ),
                ],
              ),
            ),
          ],
        ),
        duration: Duration(microseconds: 5000),
      ),
    );
  }
}
