import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

import '../../services/auth.dart';
import '../../models/user.dart';
import '../../utils/route_names.dart';
import '../../widgets/user_avatar.dart';

class UserProfileTab extends StatefulWidget {
  @override
  _UserProfileTabState createState() => _UserProfileTabState();
}

class _UserProfileTabState extends State<UserProfileTab> {
  Widget _menuItem(
      {@required String title,
      @required IconData leadingIcon,
      Color leadingIconColor,
      @required IconData trailingIcon,
      GestureTapCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(left: 7.0),
        decoration: new BoxDecoration(
          color: Colors.white,
          border:
              new Border(bottom: BorderSide(color: Colors.black12, width: 1.0)),
        ),
        child: ListTile(
          title: Text(AppLocalizations.of(context).tr(title)),
          leading: Icon(
            leadingIcon,
            color: leadingIconColor ?? Colors.black,
          ),
          trailing: Icon(trailingIcon),
        ),
      ),
    );
  }

  Widget _menuSpace() {
    return Container(
      color: Colors.blueGrey[50],
      height: 10,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey[50],
      child: ListView(
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(userDetailRoute);
            },
            child: Container(
              color: Theme.of(context).primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 7.0),
              child: ListTile(
                title: Consumer<User>(
                  builder: (ctx, user, _) => Text(
                        user.name != null ? user.name : '--',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                ),
                leading: Consumer<User>(
                    builder: (ctx, user, _) => UserAvatar(user.avatar)),
                trailing: FittedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        AppLocalizations.of(context).tr('see'),
                        style: TextStyle(color: Colors.white),
                      ),
                      Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          _menuSpace(),
          _menuItem(
            title: 'history',
            leadingIcon: Icons.history,
            leadingIconColor: Theme.of(context).primaryColor,
            trailingIcon: Icons.chevron_right,
          ),
          _menuItem(
            title: 'location',
            leadingIcon: Icons.room,
            leadingIconColor: Theme.of(context).primaryColor,
            trailingIcon: Icons.chevron_right,
          ),
          _menuItem(
            title: 'register_to_helperer',
            leadingIcon: Icons.receipt,
            leadingIconColor: Theme.of(context).primaryColor,
            trailingIcon: Icons.chevron_right,
            onTap: () {
              Navigator.of(context).pushNamed(helperRegisterRoute);
            },
          ),
          _menuItem(
            title: 'helper_management',
            leadingIcon: Icons.library_books,
            leadingIconColor: Theme.of(context).primaryColor,
            trailingIcon: Icons.chevron_right,
            onTap: () {
              Navigator.of(context).pushNamed(helperManagementRoute);
            },
          ),
          _menuSpace(),
          _menuItem(
            title: 'review',
            leadingIcon: Icons.rate_review,
            leadingIconColor: Colors.green,
            trailingIcon: Icons.chevron_right,
          ),
          _menuItem(
            title: 'invite_friend',
            leadingIcon: Icons.people,
            leadingIconColor: Colors.green,
            trailingIcon: Icons.chevron_right,
          ),
          _menuSpace(),
          _menuItem(
            title: 'settings',
            leadingIcon: Icons.settings,
            trailingIcon: Icons.chevron_right,
          ),
          _menuItem(
            title: 'about_app',
            leadingIcon: Icons.info,
            trailingIcon: Icons.chevron_right,
          ),
          _menuSpace(),
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
