import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

import '../../services/auth.dart';
import '../../models/user.dart';

class UserProfileTab extends StatefulWidget {
  @override
  _UserProfileTabState createState() => _UserProfileTabState();
}

class _UserProfileTabState extends State<UserProfileTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey[50],
      child: ListView(
        children: <Widget>[
          InkWell(
            onTap: () {},
            child: Container(
              color: Color.fromRGBO(42, 77, 108, 1),
              padding: const EdgeInsets.symmetric(vertical: 7.0),
              child: ListTile(
                title: Text(
                  'Test User',
                  style: TextStyle(color: Colors.white),
                ),
                leading: CircleAvatar(
                  backgroundColor: Colors.white,
                ),
                trailing: Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Container(
            color: Colors.blueGrey[50],
            height: 10,
          ),
          InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.only(left: 7.0),
              decoration: new BoxDecoration(
                color: Colors.white,
                border: new Border(
                    bottom: BorderSide(color: Colors.black12, width: 1.0)),
              ),
              child: ListTile(
                title: Text(
                  AppLocalizations.of(context).tr('history')
                ),
                leading: Icon(Icons.history, color: Color.fromRGBO(42, 77, 108, 1),),
                trailing: Icon(Icons.chevron_right),
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.only(left: 7.0),
              decoration: new BoxDecoration(
                color: Colors.white,
                border: new Border(
                    bottom: BorderSide(color: Colors.black12, width: 1.0)),
              ),
              child: ListTile(
                title: Text(
                  AppLocalizations.of(context).tr('location')
                ),
                leading: Icon(Icons.room, color: Color.fromRGBO(42, 77, 108, 1),),
                trailing: Icon(Icons.chevron_right),
              ),
            ),
          ),
          Container(
            color: Colors.blueGrey[50],
            height: 10,
          ),
          InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.only(left: 7.0),
              decoration: new BoxDecoration(
                color: Colors.white,
                border: new Border(
                    bottom: BorderSide(color: Colors.black12, width: 1.0)),
              ),
              child: ListTile(
                title: Text(
                  AppLocalizations.of(context).tr('review')
                ),
                leading: Icon(Icons.rate_review, color: Colors.green,),
                trailing: Icon(Icons.chevron_right),
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.only(left: 7.0),
              decoration: new BoxDecoration(
                color: Colors.white,
                border: new Border(
                    bottom: BorderSide(color: Colors.black12, width: 1.0)),
              ),
              child: ListTile(
                title: Text(
                  AppLocalizations.of(context).tr('invite_friend')
                ),
                leading: Icon(Icons.people, color: Colors.green),
                trailing: Icon(Icons.chevron_right),
              ),
            ),
          ),
          Container(
            color: Colors.blueGrey[50],
            height: 10,
          ),
          InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.only(left: 7.0),
              decoration: new BoxDecoration(
                color: Colors.white,
                border: new Border(
                    bottom: BorderSide(color: Colors.black12, width: 1.0)),
              ),
              child: ListTile(
                title: Text(
                  AppLocalizations.of(context).tr('settings')
                ),
                leading: Icon(Icons.settings, color: Colors.black,),
                trailing: Icon(Icons.chevron_right),
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.only(left: 7.0),
              decoration: new BoxDecoration(
                color: Colors.white,
                border: new Border(
                    bottom: BorderSide(color: Colors.black12, width: 1.0)),
              ),
              child: ListTile(
                title: Text(
                  AppLocalizations.of(context).tr('about_app')
                ),
                leading: Icon(Icons.info, color: Colors.black,),
                trailing: Icon(Icons.chevron_right),
              ),
            ),
          ),
          Container(
            color: Colors.blueGrey[50],
            height: 10,
          ),
          InkWell(
            onTap: () {
              final userProvider = Provider.of<User>(context, listen: false);
              userProvider.clear();
              AuthService.logout(context);
            },
            child: Container(
              color: Colors.white,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 17.0),
              child: Text(
                AppLocalizations.of(context).tr('log_out'),
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}