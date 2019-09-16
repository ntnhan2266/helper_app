import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

class ServiceInterval extends StatelessWidget {
  final Map<String, bool> data;
  final Function handleClick;
  ServiceInterval({
    @required this.data,
    @required this.handleClick,
  });

  Widget _buildStep(String title, bool isActive, Function handleClick) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: handleClick,
        child: Container(
          padding: EdgeInsets.all(
            ScreenUtil.instance.setWidth(8.0),
          ),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? Colors.green : Colors.transparent,
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.black,
            ),
          ),
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
      child: Container(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildStep(
              AppLocalizations.of(context).tr('mon'),
              data['mon'],
              () {
                handleClick('mon');
              },
            ),
            _buildStep(
              AppLocalizations.of(context).tr('tue'),
              data['tue'],
              () {
                handleClick('tue');
              },
            ),
            _buildStep(
              AppLocalizations.of(context).tr('wed'),
              data['wed'],
              () {
                handleClick('wed');
              },
            ),
            _buildStep(
              AppLocalizations.of(context).tr('thu'),
              data['thu'],
              () {
                handleClick('thu');
              },
            ),
            _buildStep(
              AppLocalizations.of(context).tr('fri'),
              data['fri'],
              () {
                handleClick('fri');
              },
            ),
            _buildStep(
              AppLocalizations.of(context).tr('sat'),
              data['sat'],
              () {
                handleClick('sat');
              },
            ),
            _buildStep(
              AppLocalizations.of(context).tr('sun'),
              data['sun'],
              () {
                handleClick('sun');
              },
            ),
          ],
        ),
      ),
    );
  }
}
