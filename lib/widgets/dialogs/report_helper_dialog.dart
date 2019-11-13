import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReportHelperDialog extends StatefulWidget {
  final Function onSubmit;

  ReportHelperDialog({this.onSubmit});

  @override
  _ReportHelperDialogState createState() => _ReportHelperDialogState();
}

class _ReportHelperDialogState extends State<ReportHelperDialog> {
  int _reason = 1;
  TextEditingController _contentController = TextEditingController();

  Widget _buildOptions() {
    final List<Widget> options = [];
    for (var i = 1; i <= 4; i++) {
      options.add(
        RadioListTile<int>(
          groupValue: _reason,
          title: Text(AppLocalizations.of(context).tr('report_reason_$i')),
          value: i,
          onChanged: (int value) {
            setState(() {
              _reason = value;
            });
          },
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: options,
    );
  }

  @override
  Widget build(BuildContext context) {
    double defaultScreenWidth = 400.0;
    double defaultScreenHeight = 810.0;
    ScreenUtil.instance = ScreenUtil(
      width: defaultScreenWidth,
      height: defaultScreenHeight,
      allowFontScaling: true,
    )..init(context);

    return AlertDialog(
      title: Text(
        AppLocalizations.of(context).tr('report_helper'),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              AppLocalizations.of(context).tr('choose_reason_to_report') + ' :',
            ),
            SizedBox(
              height: ScreenUtil.instance.setHeight(12),
            ),
            _buildOptions(),
            TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context).tr('description'),
              ),
              controller: _contentController,
            )
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(AppLocalizations.of(context).tr('close')),
        ),
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
            widget.onSubmit(_reason, _contentController.text);
          },
          child: Text(AppLocalizations.of(context).tr('ok')),
        )
      ],
    );
  }
}
