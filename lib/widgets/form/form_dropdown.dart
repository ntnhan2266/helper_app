import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../form/form_label.dart';

class FormDropdown extends StatefulWidget {
  final String label;
  final List<String> values;
  final String initialValue;
  final bool hasNext;

  const FormDropdown(
      {Key key,
      @required this.label,
      @required this.values,
      this.initialValue,
      this.hasNext = false})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FormDropdownState();
  }
}

class _FormDropdownState extends State<FormDropdown> {
  String _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue ?? widget.values[0];
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
        DropdownButtonFormField(
          decoration: InputDecoration(
            enabledBorder: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 5, bottom: 0),
          ),
          value: _value,
          items: widget.values
              .map(
                (value) => DropdownMenuItem(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: ScreenUtil.instance.setSp(16.0),
                        ),
                      ),
                    ),
              )
              .toList(),
          onChanged: (value) {
            setState(() => _value = value);
          },
        ),
        SizedBox(height: widget.hasNext ? 20 : 0),
      ],
    );
  }
}
