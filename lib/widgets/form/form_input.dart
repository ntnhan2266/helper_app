import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../form/form_label.dart';

class FormInput extends StatefulWidget {
  final String label;
  final String initialValue;
  final String hint;
  final FocusNode focusNode;
  final FocusNode nextNode;
  final bool hasNext;
  final TextInputType inputType;
  final dynamic validator;

  const FormInput(
      {Key key,
      @required this.label,
      this.initialValue,
      this.hint,
      this.focusNode,
      this.nextNode,
      this.hasNext = false,
      this.validator,
      this.inputType = TextInputType.text})
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
        FormLabel(widget.label),
        TextFormField(
          validator: widget.validator,
          initialValue: widget.initialValue,
          keyboardType: widget.inputType,
          maxLines: widget.inputType == TextInputType.multiline ? null : 1,
          textInputAction: widget.inputType == TextInputType.multiline
              ? TextInputAction.newline
              : widget.nextNode != null
                  ? TextInputAction.next
                  : TextInputAction.done,
          focusNode: widget.focusNode,
          onFieldSubmitted: (term) {
            if (widget.hasNext)
              _fieldFocusChange(context, widget.focusNode, widget.nextNode);
          },
          style: TextStyle(
            fontSize: ScreenUtil.instance.setSp(12.0),
            color: Colors.black,
          ),
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: TextStyle(),
            enabledBorder: InputBorder.none,
            contentPadding: EdgeInsets.only(top: ScreenUtil.instance.setHeight(10), bottom: ScreenUtil.instance.setHeight(10)),
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
