import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pk_skeleton/pk_skeleton.dart';

import '../utils/utils.dart';
import '../widgets/booking_step_title.dart';
import '../widgets/booking_bottom_bar.dart';
import '../widgets/maid_list.dart';
import '../widgets/dialogs/error_dialog.dart';
import '../models/service_details.dart';
import '../models/user_maid.dart';
import '../services/maid.dart';
import '../utils/route_names.dart';

class ChooseMaidScreen extends StatefulWidget {
  final ServiceDetails data;

  const ChooseMaidScreen({Key key, this.data}) : super(key: key);

  @override
  _ChooseMaidScreenState createState() => _ChooseMaidScreenState();
}

class _ChooseMaidScreenState extends State<ChooseMaidScreen> {
  UserMaid maid;

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
      services: [widget.data.category],
      search: "",
      areas: [],
      minSalary: 0,
      maxSalary: 0,
      sort: "ratting",
      lat: widget.data.lat,
      long: widget.data.long,
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

  void _handleTap(UserMaid maid) {
    setState(() {
      this.maid = maid;
    });
  }

  Widget _buildMaidList() {
    return MaidList(
      maids: _maids,
      total: _maids.length,
      selectedID: maid != null ? maid.id : null,
      handleTap: _handleTap,
      scrollController: _scrollController,
    );
  }

  void _onSubmit(ServiceDetails data) {
    if (maid == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return ErrorDialog(
            AppLocalizations.of(context).tr('maid_required'),
          );
        },
      );
      return;
    }
    data.maid = maid;
    Navigator.pushNamed(context, verifyBookingRoute, arguments: data);
  }

  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;

    final ServiceDetails _data = ModalRoute.of(context).settings.arguments;
    // Calculate interval days
    var price = 0;
    if (_data.endDate != null) {
      // Calculate price = price per day * days;
      final startDate = _data.startDate;
      final endDate = _data.endDate;
      final interval = _data.interval;
      int days = Utils.calculateIntervalDays(startDate, endDate, interval);
      price = maid != null
          ? (_data.endTime.difference(_data.startTime).inMinutes /
                  60 *
                  maid.salary *
                  days)
              .round()
          : 0;
    } else {
      price = maid != null
          ? (_data.endTime.difference(_data.startTime).inMinutes /
                  60 *
                  maid.salary)
              .round()
          : 0;
    }

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
            AppLocalizations.of(context).tr('service_details'),
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black, //change back button color
          ),
          elevation: 0,
        ),
        body: Column(
          children: <Widget>[
            BookingStepTitle(
              currentStep: 1,
            ),
            SizedBox(
              height: 10,
            ),
            _isLoading
                ? PKCardPageSkeleton()
                : Expanded(
                    child: _buildMaidList(),
                  ),
          ],
        ),
        bottomNavigationBar: BookingBottomBar(
          price: price,
          showPrice: true,
          onSubmit: () {
            _onSubmit(_data);
          },
        ),
      ),
    );
  }
}
