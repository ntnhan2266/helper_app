import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

InputDecoration textFormFieldConfig(String hintText) {
    return InputDecoration(
      errorStyle: TextStyle(color: Colors.red),
      hintText: hintText,
      border: OutlineInputBorder(
        borderSide: BorderSide(width: 1, color: Colors.grey),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 1, color: Colors.red),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 1, color: Colors.grey),
      ),
      fillColor: Color.fromRGBO(0, 0, 0, 0.05),
      filled: true,
      contentPadding: EdgeInsets.all(
        ScreenUtil.instance.setSp(14.0),
      ),
    );
  }