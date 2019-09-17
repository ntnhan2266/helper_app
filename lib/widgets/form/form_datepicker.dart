import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../form/form_label.dart';

class FormDatePicker extends StatelessWidget {
  final String label;
  final DateTime value;
  final bool hasNext;
  final Function hanldeChange;

  FormDatePicker(
      {@required this.label, this.value, this.hasNext = false, @required this.hanldeChange});


  Future _selectDate(BuildContext context) async {
    var now = DateTime.now();
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: value != null ? value : DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));
    if (picked != null && picked != value) {
      hanldeChange(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Responsive
    double defaultScreenWidth = 400.0;
    double defaultScreenHeight = 810.0;
    ScreenUtil.instance = ScreenUtil(
      width: defaultScreenWidth,
      height: defaultScreenHeight,
      allowFontScaling: true,
    )..init(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        FormLabel(label),
        GestureDetector(
          onTap: () {
            _selectDate(context);
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: ScreenUtil.instance.setHeight(10), bottom: ScreenUtil.instance.setHeight(10)),
            child: Text(
              DateFormat.yMd('vi_VN').format(value),
              style: TextStyle(
                color: Colors.black,
                fontSize: ScreenUtil.instance.setSp(12.0),
              ),
            ),
          ),
        ),
        SizedBox(height: hasNext ? ScreenUtil.instance.setHeight(20.0) : 0),
      ],
    );
  }
}
