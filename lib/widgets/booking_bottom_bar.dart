import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class BookingBottomBar extends StatelessWidget {
  final Function onSubmit;
  final bool isVerify;
  final int price;
  final bool showPrice;
  BookingBottomBar({
    @required this.onSubmit,
    this.isVerify = false,
    this.price = 0,
    this.showPrice = false,
  });

  @override
  Widget build(BuildContext context) {
    final numericFormatter = new NumberFormat("#,###", "en_US");
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(blurRadius: 10, color: Color.fromRGBO(0, 0, 0, 0.4))
      ]),
      padding: EdgeInsets.all(ScreenUtil.instance.setWidth(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          showPrice
              ? Text(
                  AppLocalizations.of(context).tr('service_fee') +
                      ' ' +
                      numericFormatter.format(price) +
                      ' VND',
                )
              : Container(),
          Container(
            width: double.infinity,
            child: RaisedButton(
              child: Text(
                isVerify
                    ? AppLocalizations.of(context).tr('confirm').toUpperCase()
                    : AppLocalizations.of(context).tr('next').toUpperCase(),
                style: TextStyle(
                  fontSize: ScreenUtil.instance.setSp(13),
                ),
              ),
              color: Color.fromRGBO(42, 77, 108, 1),
              textColor: Colors.white,
              onPressed: () {
                onSubmit();
              },
            ),
          ),
        ],
      ),
    );
  }
}
