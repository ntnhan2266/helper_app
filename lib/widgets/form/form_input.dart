import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormInput extends StatefulWidget {
  final String label;
  final String initialValue;
  final FocusNode focusNode;
  final FocusNode nextNode;
  final bool hasNext;

  const FormInput(
      {Key key,
      this.label,
      this.initialValue,
      this.focusNode,
      this.nextNode,
      this.hasNext = false})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FormInputState();
  }
}

class _FormInputState extends State<FormInput> {
  @override
  void initState() {
    super.initState();
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
        Text(
          widget.label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.black45,
          ),
        ),
        TextFormField(
          // validator: (value) {
          //   if (value.isEmpty || value == "") {
          //     return 'Please enter some text';
          //   }
          //   return null;
          // },
          initialValue: widget.initialValue,
          keyboardType: TextInputType.text,
          textInputAction:
              widget.hasNext && widget.nextNode != null ? TextInputAction.next : TextInputAction.done,
          focusNode: widget.focusNode,
          onFieldSubmitted: (term) {
            if (widget.hasNext)
              _fieldFocusChange(context, widget.focusNode, widget.nextNode);
          },
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: ScreenUtil.instance.setSp(16.0),
          ),
          decoration: InputDecoration(
            enabledBorder: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 10, bottom: 5),
          ),
        ),
        SizedBox(height: widget.hasNext ? 20 : 0),
      ],
    );
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
