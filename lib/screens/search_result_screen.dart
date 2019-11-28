import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pk_skeleton/pk_skeleton.dart';

import '../models/maid.dart';
import '../services/maid.dart';
import '../widgets/components/helper_list_item.dart';

class SearchResultScreen extends StatefulWidget {
  final String search;
  final List<dynamic> searchServices;
  final List<int> searchAreas;
  final int minSalary;
  final int maxSalary;

  const SearchResultScreen(
      {Key key,
      this.search,
      this.searchServices,
      this.searchAreas,
      this.minSalary,
      this.maxSalary})
      : super(key: key);

  @override
  _SearchResultScreenState createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  bool _isLoading = true;
  List<dynamic> _maids = List();

  @override
  void initState() {
    super.initState();
    _searchHelpers();
  }

  void _searchHelpers() async {
    final res = await MaidService.searchMaids(
      search: widget.search,
      services: widget.searchServices,
      areas: widget.searchAreas,
      minSalary: widget.minSalary,
      maxSalary: widget.maxSalary,
    );
    print(res['isValid']);
    if (res['isValid'] && mounted) {
      // final total = res['total'];
      setState(() {
        _maids.addAll(res['data']);
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;

    double defaultScreenWidth = 400.0;
    double defaultScreenHeight = 810.0;
    ScreenUtil.instance = ScreenUtil(
      width: defaultScreenWidth,
      height: defaultScreenHeight,
      allowFontScaling: true,
    )..init(context);

    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context).tr('search_result'),
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          elevation: 0,
        ),
        body: _isLoading
            ? PKCardPageSkeleton()
            : Container(
                color: Colors.blueGrey[50],
                padding: EdgeInsets.symmetric(vertical: 3.0),
                child: ListView(
                  children: _maids.map((maid) => HelperListItem(maid)).toList(),
                ),
              ),
      ),
    );
  }
}
