import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../form/form_label.dart';

class FormDatePicker extends StatefulWidget {
  final String label;
  final DateTime value;
  final bool hasNext;

  const FormDatePicker(
      {Key key, @required this.label, this.value, this.hasNext = false})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FormDatePickerState();
  }
}

class _FormDatePickerState extends State<FormDatePicker> {
  DateTime _birthday;
  @override
  void initState() {
    super.initState();
    _birthday = widget.value ?? DateTime.now();
  }

  Future _selectDate() async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: _birthday,
        firstDate: new DateTime(2016),
        lastDate: new DateTime(2020));
    if (picked != null) setState(() => _birthday = picked);
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
        FormLabel(widget.label),
        GestureDetector(
          onTap: _selectDate,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: ScreenUtil.instance.setHeight(10), bottom: ScreenUtil.instance.setHeight(10)),
            child: Text(
              DateFormat.yMd('vi_VN').format(_birthday),
              style: TextStyle(
                color: Colors.black,
                fontSize: ScreenUtil.instance.setSp(12.0),
              ),
            ),
          ),
        ),
        SizedBox(height: widget.hasNext ? 20 : 0),
      ],
    );
  }
}
