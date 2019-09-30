import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../form/form_label.dart';

class FormInput extends StatelessWidget {
  final String label;
  final String initialValue;
  final String hint;
  final FocusNode focusNode;
  final FocusNode nextNode;
  final bool hasNext;
  final TextInputType inputType;
  final dynamic validator;
  final bool enabled;

  FormInput({
    @required this.label,
    this.initialValue,
    this.hint,
    this.focusNode,
    this.nextNode,
    this.hasNext = false,
    this.validator,
    this.inputType = TextInputType.text,
    this.enabled = true,
  });

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
        TextFormField(
          validator: validator,
          initialValue: initialValue,
          keyboardType: inputType,
          enabled: enabled,
          maxLines: inputType == TextInputType.multiline ? null : 1,
          textInputAction: inputType == TextInputType.multiline
              ? TextInputAction.newline
              : nextNode != null ? TextInputAction.next : TextInputAction.done,
          focusNode: focusNode != null ? focusNode : null,
          onFieldSubmitted: (term) {
            if (hasNext) _fieldFocusChange(context, focusNode, nextNode);
          },
          style: TextStyle(
            fontSize: ScreenUtil.instance.setSp(12.0),
            color: Colors.black,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(),
            enabledBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding: EdgeInsets.only(
              top: ScreenUtil.instance.setHeight(10),
              bottom: ScreenUtil.instance.setHeight(10),
            ),
          ),
        ),
        SizedBox(height: hasNext ? ScreenUtil.instance.setHeight(20) : 0),
      ],
    );
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
