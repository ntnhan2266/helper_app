import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RejectBookingDialog extends StatefulWidget {
  final Function handleCancel;

  RejectBookingDialog(this.handleCancel);

  @override
  _RejectBookingDialogState createState() => _RejectBookingDialogState();
}

class _RejectBookingDialogState extends State<RejectBookingDialog> {
  int _reason = 1;
  TextEditingController _contentController = TextEditingController();

  Widget _buildCancelOptions() {
    final List<Widget> options = [];
    for (var i = 1; i <= 4; i++) {
      options.add(
        RadioListTile<int>(
          groupValue: _reason,
          title: Text(AppLocalizations.of(context).tr('reject_reason_$i')),
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
        AppLocalizations.of(context).tr('reject_confirm'),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              AppLocalizations.of(context).tr('choose_reason') + ' :',
            ),
            SizedBox(
              height: ScreenUtil.instance.setHeight(12),
            ),
            _buildCancelOptions(),
            TextField(
              minLines: 4,
              maxLines: 6,
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
            widget.handleCancel(_reason, _contentController.text);
          },
          child: Text(AppLocalizations.of(context).tr('ok')),
        )
      ],
    );
  }
}
