import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../form/form_label.dart';
import '../form/form_multichoice_dialog.dart';
import '../../utils/constants.dart';
import '../../models/form_select_item.dart';

class FormMultiChoice extends StatelessWidget {
  final String label;
  final String hint;
  final List<FormSelectItem> values;
  final List<dynamic> selectedValues;
  final bool hasNext;
  final Function onChangeHandler;

  const FormMultiChoice(
      {Key key,
      @required this.label,
      @required this.hint,
      @required this.values,
      this.selectedValues,
      this.onChangeHandler,
      this.hasNext = false})
      : super(key: key);

  _showReportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            hint,
          ),
          content: FormMultiChoiceDialog(
            values: values,
            selectedValues: selectedValues,
            onSelectionChanged: onChangeHandler,
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

    // Render selected data
    String selectedData = '';
    if (selectedValues.length > 0) {
      values.forEach((item) {
        if (selectedValues.contains(item.value)) {
          selectedData += item.label + ', ';
        }
      });
      if (selectedValues.length > 2) {
        selectedData = selectedData.substring(0, selectedData.length - 2);
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        FormLabel(label),
        SizedBox(height: ScreenUtil.instance.setHeight(LABEL_MARGIN)),
        GestureDetector(
          onTap: () {
            _showReportDialog(context);
          },
          child: Container(
            width: double.infinity,
            child: selectedValues.isEmpty
                ? Text(
                    hint,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: ScreenUtil.instance.setSp(13.0),
                    ),
                  )
                : Text(
                    selectedData,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: ScreenUtil.instance.setSp(13.0),
                    ),
                  ),
          ),
        ),
        SizedBox(height: hasNext ? ScreenUtil.instance.setHeight(20) : 0),
      ],
    );
  }
}
