import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../form/form_label.dart';
import '../../models/form_select_item.dart';

class FormDropdown extends StatelessWidget {
  final String label;
  final List<FormSelectItem> values;
  final bool hasNext;
  final dynamic value;
  final Function handleOnChange;

  const FormDropdown({
    Key key,
    @required this.label,
    @required this.values,
    this.hasNext = false,
    this.value,
    this.handleOnChange,
  }) : super(key: key);

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
        DropdownButtonFormField(
          decoration: InputDecoration(
            enabledBorder: InputBorder.none,
            contentPadding: EdgeInsets.only(
                top: ScreenUtil.instance.setHeight(5),
                bottom: ScreenUtil.instance.setHeight(5)),
          ),
          value: value,
          items: values
              .map(
                (item) => DropdownMenuItem(
                  value: item.value,
                  child: Text(
                    item.label,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: ScreenUtil.instance.setSp(12.0),
                    ),
                  ),
                ),
              )
              .toList(),
          onChanged: (dynamic value) {
            handleOnChange(value);
          }
        ),
        SizedBox(
            height: hasNext ? ScreenUtil.instance.setHeight(20) : 0),
      ],
    );
  }
}
