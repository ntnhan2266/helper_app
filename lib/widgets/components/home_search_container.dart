import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../screens/search_result_screen.dart';
import '../../utils/route_names.dart';
import '../../utils/utils.dart';
import '../../models/category_list.dart';

enum SalaryTypeEnum { all, custom }
const MIN_SALARY = 0;
const MAX_SALARY = 10000000;
const STEP_SALARY = 50000;
enum AreaTypeEnum { all, custom }
enum ServiceTypeEnum { all, custom }

class HomeSearchContainer extends StatefulWidget {
  @override
  _HomeSearchContainerState createState() => _HomeSearchContainerState();
}

class _HomeSearchContainerState extends State<HomeSearchContainer> {
  final TextEditingController _searchControl = new TextEditingController();
  String _search = "";
  List<String> _searchServices = List();
  List<int> _searchAreas = List();
  int _minSalary = MIN_SALARY;
  int _maxSalary = MAX_SALARY;

  //temp
  List<String> _tempSearchServices = List();
  ServiceTypeEnum _serviceType = ServiceTypeEnum.all;
  List<int> _tempSearchAreas = List();
  SalaryTypeEnum _salaryType = SalaryTypeEnum.all;
  AreaTypeEnum _areaType = AreaTypeEnum.all;

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

  void _showServiceDialog() {
    final categoryListProvider =
        Provider.of<CategoryList>(context, listen: false);
    final categoriesData = categoryListProvider.categories;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(AppLocalizations.of(context).tr('service')),
              content: Wrap(
                alignment: WrapAlignment.center,
                children: categoriesData.map((i) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.0),
                    child: ChoiceChip(
                      label: Text(
                        Localizations.localeOf(context).languageCode == "en"
                            ? i.nameEn
                            : i.nameVi,
                      ),
                      selected: _tempSearchServices.contains(i.id),
                      onSelected: (selected) {
                        if (selected) {
                          setState(() {
                            _tempSearchServices.add(i.id);
                          });
                        } else {
                          setState(() {
                            _tempSearchServices.remove(i.id);
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
                      _tempSearchServices = List();
                      _tempSearchServices.addAll(_searchServices);
                    });
                  },
                ),
                FlatButton(
                  child: Text(AppLocalizations.of(context).tr('ok')),
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      _searchServices = List();
                      _searchServices.addAll(_tempSearchServices);
                      _searchServices.sort();
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

  Widget _serviceRadioGroup(dynamic groupValue, dynamic value, String title) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _serviceType = value;
        });
        if (value == ServiceTypeEnum.custom) {
          _showServiceDialog();
        }
      },
      child: Row(
        children: <Widget>[
          Radio(
            groupValue: groupValue,
            value: value,
            onChanged: (value) {
              setState(() {
                _serviceType = value;
                _searchServices = [];
                _tempSearchServices = [];
              });
              if (value == ServiceTypeEnum.custom) {
                _showServiceDialog();
              }
            },
          ),
          Text(AppLocalizations.of(context).tr(title)),
        ],
      ),
    );
  }

  List<Widget> _serviceList() {
    final categoryListProvider =
        Provider.of<CategoryList>(context, listen: false);
    final categoriesData = categoryListProvider.categories;
    if (_serviceType == ServiceTypeEnum.all) {
      return [];
    } else if (_searchServices.isEmpty) {
      return [
        Center(
          child: Text(AppLocalizations.of(context).tr('select_service')),
        )
      ];
    } else {
      return categoriesData
          .where((service) => _searchServices.contains(service.id))
          .map((service) => _serviceChoiceChip(
                Localizations.localeOf(context).languageCode == "en"
                    ? service.nameEn
                    : service.nameVi,
              ))
          .toList();
    }
  }

  Widget _serviceChoiceChip(String name) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.0),
      child: ChoiceChip(
        label: Text(
          AppLocalizations.of(context).tr(name),
        ),
        selected: true,
        onSelected: (selected) {
          _showServiceDialog();
        },
      ),
    );
  }

  void _showSupportedAreaDialog() {
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
                      _tempSearchAreas = List();
                      _tempSearchAreas.addAll(_searchAreas);
                    });
                  },
                ),
                FlatButton(
                  child: Text(AppLocalizations.of(context).tr('ok')),
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      _searchAreas = List();
                      _searchAreas.addAll(_tempSearchAreas);
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

  Widget _areaRadioGroup(dynamic groupValue, dynamic value, String title) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _areaType = value;
        });
        if (value == AreaTypeEnum.custom) {
          _showSupportedAreaDialog();
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
                _tempSearchAreas = [];
              });
              if (value == AreaTypeEnum.custom) {
                _showSupportedAreaDialog();
              }
            },
          ),
          Text(AppLocalizations.of(context).tr(title)),
        ],
      ),
    );
  }

  List<Widget> _supportedAreaList() {
    int limit = 5;
    if (_areaType == AreaTypeEnum.all) {
      return [];
    } else if (_searchAreas.isEmpty) {
      return [
        Center(
          child: Text(AppLocalizations.of(context).tr('select_area')),
        )
      ];
    } else if (_searchAreas.length <= limit) {
      return _searchAreas
          .map((area) => _supportedAreaChoiceChip(area))
          .toList();
    } else {
      List<Widget> areas = _searchAreas
          .sublist(0, limit)
          .map((area) => _supportedAreaChoiceChip(area))
          .toList();
      areas.add(
          _supportedAreaChoiceChip(_searchAreas.length - limit, more: true));
      return areas;
    }
  }

  Widget _supportedAreaChoiceChip(int i, {bool more = false}) {
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
          _showSupportedAreaDialog();
        },
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
      children: _salaryType == SalaryTypeEnum.all
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

  void _onSearch() {
    if (_serviceType == ServiceTypeEnum.custom && _searchServices.isEmpty) {
      Utils.showErrorDialog(context, "select_service_required");
    } else if (_areaType == AreaTypeEnum.custom && _searchAreas.isEmpty) {
      Utils.showErrorDialog(context, "select_area_required");
    } else {
      Navigator.pushNamed(
        context,
        searchResultRoute,
        arguments: SearchResultScreen(
          search: _search,
          searchServices: _searchServices,
          searchAreas: _searchAreas,
          minSalary: _minSalary,
          maxSalary: _maxSalary,
        ),
      );
    }
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
                _onSearch();
              },
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Divider(),
                  ),
                  _searchLabel(AppLocalizations.of(context).tr('service')),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _serviceRadioGroup(
                          _serviceType, ServiceTypeEnum.all, "all"),
                      _serviceRadioGroup(
                          _serviceType, ServiceTypeEnum.custom, "custom"),
                    ],
                  ),
                  GestureDetector(
                    child: Container(
                      width: double.infinity,
                      color: Colors.transparent,
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        children: _serviceList(),
                      ),
                    ),
                    onTap: () {
                      _showServiceDialog();
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Divider(),
                  ),
                  _searchLabel(AppLocalizations.of(context).tr('support_area')),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _areaRadioGroup(_areaType, AreaTypeEnum.all, "all"),
                      _areaRadioGroup(_areaType, AreaTypeEnum.custom, "custom"),
                    ],
                  ),
                  GestureDetector(
                    child: Container(
                      width: double.infinity,
                      color: Colors.transparent,
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        children: _supportedAreaList(),
                      ),
                    ),
                    onTap: () {
                      _showSupportedAreaDialog();
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
                      _salaryRadioGroup(_salaryType, SalaryTypeEnum.all, "all"),
                      _salaryRadioGroup(
                          _salaryType, SalaryTypeEnum.custom, "custom"),
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
