import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  @override
  _ChooseMaidScreenState createState() => _ChooseMaidScreenState();
}

class _ChooseMaidScreenState extends State<ChooseMaidScreen> {
  List<dynamic> maids = [];
  int total = 0;
  bool loading = true;
  UserMaid maid;

  @override
  void initState() {
    super.initState();
    getMaids();
  }

  void getMaids() async {
    final res = await MaidService.getMaidList();
    if (res['errorCode'] == null) {
      final maids = res['maids'];
      final total = res['total'];
      setState(() {
        this.maids = maids;
        this.total = total;
        loading = false;
      });
    } else {
      loading = false;
    }
  }

  void _handleTap(UserMaid maid) {
    setState(() {
      this.maid = maid;
    });
  }

  Widget _buildMaidList() {
    return MaidList(
      maids: maids,
      total: total,
      selectedID: maid != null ? maid.id : null,
      handleTap: _handleTap,
    );
  }

  // ServiceDetails _data = ServiceDetails();
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
          ? (_data.endTime.difference(_data.startTime).inMinutes / 60 * maid.salary * days).round()
          : 0;
    } else {
      price = maid != null
          ? (_data.endTime.difference(_data.startTime).inMinutes / 60 * maid.salary).round()
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
            loading
                ? CircularProgressIndicator()
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
