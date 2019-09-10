import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingStepTitle extends StatelessWidget {
  final int currentStep;

  BookingStepTitle({this.currentStep = 0});

  Widget _buildStep(BuildContext context, String title, IconData icon, bool isActive) {
    return Expanded(
      flex: 1,
      child: Container(
        height: ScreenUtil.instance.setHeight(80),
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                fontSize: ScreenUtil.instance.setSp(12),
                color: isActive ? Color.fromRGBO(42, 77, 108, 1) : Colors.grey,
              ),
            ),
            SizedBox(
              height: ScreenUtil.instance.setHeight(10),
            ),
            Container(
              height: 26,
              width: 26,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(
                  width: 1,
                  color: isActive ? Color.fromRGBO(42, 77, 108, 1) : Colors.grey,
                ),
              ),
              child: Icon(
                icon,
                color: isActive ? Color.fromRGBO(42, 77, 108, 1) : Colors.grey,
                size: 18,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double defaultScreenWidth = 400.0;
    double defaultScreenHeight = 810.0;
    ScreenUtil.instance = ScreenUtil(
      width: defaultScreenWidth,
      height: defaultScreenHeight,
      allowFontScaling: true,
    )..init(context);

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: ScreenUtil.instance.setWidth(10),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              _buildStep(
                context,
                AppLocalizations.of(context).tr('information'),
                Icons.view_headline,
                currentStep == 0,
              ),
              _buildStep(
                context,
                AppLocalizations.of(context).tr('choose_maid'),
                Icons.assignment_ind,
                currentStep == 1,
              ),
              _buildStep(
                context,
                AppLocalizations.of(context).tr('verify'),
                Icons.check,
                currentStep == 2,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
