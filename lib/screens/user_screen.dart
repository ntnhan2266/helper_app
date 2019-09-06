import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        body: Center(
          child: Text(
            AppLocalizations.of(context).tr('user'),
          ),
        ),
      ),
    );
  }
}
