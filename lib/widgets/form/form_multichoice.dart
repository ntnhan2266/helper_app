import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../form/form_label.dart';
import '../form/form_multichoice_dialog.dart';
import '../../utils/constants.dart';

class FormMultiChoice extends StatefulWidget {
  final String label;
  final String hint;
  final List<String> values;
  final List<String> selectedValues;
  final bool hasNext;

  const FormMultiChoice(
      {Key key,
      @required this.label,
      @required this.hint,
      @required this.values,
      this.selectedValues,
      this.hasNext = false})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FormMultiChoiceState();
  }
}

class _FormMultiChoiceState extends State<FormMultiChoice> {
  List<String> _selectedValues;
  @override
  void initState() {
    super.initState();
    _selectedValues = widget.selectedValues ?? List();
  }

  _showReportDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // title: Text("Dich vu"),
          content: FormMultiChoiceDialog(
            values: widget.values,
            selectedValues: _selectedValues,
            onSelectionChanged: (selectedValues) {
              setState(() {
                _selectedValues = selectedValues;
              });
            },
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(AppLocalizations.of(context).tr('select')),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        );
      },
    );
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
        SizedBox(height: ScreenUtil.instance.setHeight(LABEL_MARGIN)),
        GestureDetector(
          onTap: _showReportDialog,
          child: Container(
            width: double.infinity,
            child: _selectedValues.isEmpty
                ? Text(
                    widget.hint,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: ScreenUtil.instance.setSp(12.0),
                    ),
                  )
                : Text(
                    _selectedValues.join(", "),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: ScreenUtil.instance.setSp(12.0),
                    ),
                  ),
          ),
        ),
        SizedBox(height: widget.hasNext ? ScreenUtil.instance.setHeight(20) : 0),
      ],
    );
  }
}
