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
  List<dynamic> _maids = List();
  int _pageIndex = 0;
  bool _isLoading = true;
  bool _canLoadMore = true;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _searchHelpers();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _searchHelpers();
      }
    });
  }

  void _searchHelpers() async {
    if (!_canLoadMore || !mounted) {
      return;
    }
    setState(() {
      _isLoading = true;
    });

    final res = await MaidService.searchMaids(
      pageIndex: _pageIndex,
      search: widget.search,
      services: widget.searchServices,
      areas: widget.searchAreas,
      minSalary: widget.minSalary,
      maxSalary: widget.maxSalary,
    );
    if (res['isValid'] && mounted) {
      setState(() {
        _maids.addAll(res['data']);
        _pageIndex++;
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
                child: _maids.isEmpty
                    ? Container(
                        color: Colors.white,
                        margin: EdgeInsets.symmetric(
                          vertical: ScreenUtil.instance.setHeight(2.0),
                          horizontal: ScreenUtil.instance.setWidth(5.0),
                        ),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Image.asset(
                              'assets/images/not_found.jpg',
                              width: MediaQuery.of(context).size.width * 0.5,
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 20.0),
                              child: Text(AppLocalizations.of(context)
                                  .tr('no_content')),
                            )
                          ],
                        ),
                      )
                    : ListView(
                        controller: _scrollController,
                        children:
                            _maids.map((maid) => HelperListItem(maid)).toList(),
                      ),
              ),
      ),
    );
  }
}
