import 'package:flutter/material.dart';

class FormLabel extends StatelessWidget {
  final String label;

  const FormLabel(this.label, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      label.toUpperCase(),
      style: TextStyle(
        fontSize: 12,
        color: Colors.black45,
      ),
    );
  }
}
