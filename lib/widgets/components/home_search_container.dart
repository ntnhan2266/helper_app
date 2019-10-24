import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../utils/utils.dart';
import '../../utils/dummy_data.dart';

enum SalaryType { all, custom }
const MIN_SALARY = 0;
const MAX_SALARY = 10000000;
const STEP_SALARY = 50000;
enum AreaType { all, custom }

class HomeSearchContainer extends StatefulWidget {
  @override
  _HomeSearchContainerState createState() => _HomeSearchContainerState();
}

class _HomeSearchContainerState extends State<HomeSearchContainer> {
  final TextEditingController _searchControl = new TextEditingController();
  String _search = "";
  List<int> _searchServices = [];
  List<int> _searchAreas = [];
  int _minSalary = MIN_SALARY;
  int _maxSalary = MAX_SALARY;

  //temp
  List<int> _tempSearchAreas = [];
  SalaryType _salaryType = SalaryType.all;
  AreaType _areaType = AreaType.all;

  Widget _inputSearch() {
    return Container(
      margin: EdgeInsets.only(bottom: 5.0),
      decoration: BoxDecoration(
        color: Colors.blueGrey[50],
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      child: TextField(
        onChanged: (value) {
          setState(() {
            _search = value;
          });
        },
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

  void _showSupportedAreas() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(AppLocalizations.of(context).tr('support_area')),
              content: Wrap(
                alignment: WrapAlignment.center,
                children: Iterable<int>.generate(22, (i) => i + 1).map((i) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.0),
                    child: ChoiceChip(
                      label: Text(
                        AppLocalizations.of(context)
                            .tr(Utils.intToSupportArea(i)),
                      ),
                      selected: _tempSearchAreas.contains(i),
                      onSelected: (selected) {
                        if (selected) {
                          setState(() {
                            _tempSearchAreas.add(i);
                          });
                        } else {
                          setState(() {
                            _tempSearchAreas.remove(i);
                          });
                        }
                        FocusScope.of(context).requestFocus(new FocusNode());
                      },
                    ),
                  );
                }).toList(),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text(AppLocalizations.of(context).tr('cancel')),
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      _tempSearchAreas = _searchAreas;
                    });
                  },
                ),
                FlatButton(
                  child: Text(AppLocalizations.of(context).tr('ok')),
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      _searchAreas = _tempSearchAreas;
                      _searchAreas.sort();
                    });
                  },
                ),
              ],
            );
          },
        );
      },
    ).then((value) {
      setState(() {});
    });
  }

  List<Widget> _supportedAreas() {
    int limit = 5;
    if (_areaType == AreaType.all) {
      return [];
    } else if (_searchAreas.isEmpty) {
      return [
        Center(
          child: Text(AppLocalizations.of(context).tr('select_area')),
        )
      ];
    } else if (_searchAreas.length <= limit) {
      return _searchAreas.map((area) => _supportedArea(area)).toList();
    } else {
      List<Widget> areas = _searchAreas
          .sublist(0, limit)
          .map((area) => _supportedArea(area))
          .toList();
      areas.add(_supportedArea(_searchAreas.length - limit, more: true));
      return areas;
    }
  }

  Widget _supportedArea(int i, {bool more = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.0),
      child: ChoiceChip(
        label: Text(
          more
              ? "+$i"
              : AppLocalizations.of(context).tr(Utils.intToSupportArea(i)),
        ),
        selected: true,
        onSelected: (selected) {
          _showSupportedAreas();
        },
      ),
    );
  }

  Widget _areaRadioGroup(dynamic groupValue, dynamic value, String title) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _areaType = value;
        });
        if (value == AreaType.custom) {
          _showSupportedAreas();
        }
      },
      child: Row(
        children: <Widget>[
          Radio(
            groupValue: groupValue,
            value: value,
            onChanged: (value) {
              setState(() {
                _areaType = value;
                _searchAreas = [];
              });
              if (value == AreaType.custom) {
                _showSupportedAreas();
              }
            },
          ),
          Text(AppLocalizations.of(context).tr(title)),
        ],
      ),
    );
  }

  Widget _salaryRadioGroup(dynamic groupValue, dynamic value, String title) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _salaryType = value;
        });
      },
      child: Row(
        children: <Widget>[
          Radio(
            groupValue: groupValue,
            value: value,
            onChanged: (value) {
              setState(() {
                _salaryType = value;
                _minSalary = MIN_SALARY;
                _maxSalary = MAX_SALARY;
              });
            },
          ),
          Text(AppLocalizations.of(context).tr(title)),
        ],
      ),
    );
  }

  Widget _salaryDetail() {
    return Column(
      children: _salaryType == SalaryType.all
          ? []
          : [
              Center(
                child: Text(
                  NumberFormat("#,###").format(_minSalary) +
                      " ~ " +
                      NumberFormat("#,###").format(_maxSalary),
                ),
              ),
              RangeSlider(
                min: MIN_SALARY.toDouble(),
                max: MAX_SALARY.toDouble(),
                activeColor: Theme.of(context).primaryColor,
                inactiveColor: Colors.blueGrey[100],
                values:
                    RangeValues(_minSalary.toDouble(), _maxSalary.toDouble()),
                onChanged: (RangeValues value) {
                  setState(() {
                    _minSalary = (value.start.round() / STEP_SALARY).round() *
                        STEP_SALARY;
                    _maxSalary =
                        (value.end.round() / STEP_SALARY).round() * STEP_SALARY;
                  });
                },
              ),
            ],
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
            RaisedButton(
              color: Theme.of(context).primaryColor,
              textTheme: ButtonTextTheme.primary,
              child: Text("Search"),
              onPressed: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Divider(),
                  ),
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
                          selected: _searchServices.contains(item.id),
                          onSelected: (selected) {
                            if (selected) {
                              setState(() {
                                _searchServices.add(item.id);
                              });
                            } else {
                              setState(() {
                                _searchServices.remove(item.id);
                              });
                            }
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                          },
                        ),
                      );
                    }).toList(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Divider(),
                  ),
                  _searchLabel(AppLocalizations.of(context).tr('support_area')),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _areaRadioGroup(_areaType, AreaType.all, "all"),
                      _areaRadioGroup(_areaType, AreaType.custom, "custom"),
                    ],
                  ),
                  GestureDetector(
                    child: Container(
                      width: double.infinity,
                      color: Colors.transparent,
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        children: _supportedAreas(),
                      ),
                    ),
                    onTap: () {
                      _showSupportedAreas();
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Divider(),
                  ),
                  _searchLabel(AppLocalizations.of(context).tr('salary')),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _salaryRadioGroup(_salaryType, SalaryType.all, "all"),
                      _salaryRadioGroup(
                          _salaryType, SalaryType.custom, "custom"),
                    ],
                  ),
                  _salaryDetail(),
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
