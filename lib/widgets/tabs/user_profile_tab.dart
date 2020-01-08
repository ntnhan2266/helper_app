import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../utils/constants.dart';
import '../../widgets/form/form_input.dart';
import '../../services/auth.dart';
import '../../models/user.dart';
import '../../utils/route_names.dart';
import '../../utils/utils.dart';
import '../../widgets/user_avatar.dart';
import '../../screens/choose_address_screen.dart';
import '../../services/setting.dart';
import '../../services/permission.dart';
import '../../services/user.dart';

class UserProfileTab extends StatefulWidget {
  @override
  _UserProfileTabState createState() => _UserProfileTabState();
}

class _UserProfileTabState extends State<UserProfileTab> {
  final _emailForm = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  void _clearToken(String id) {
    Firestore.instance
        .collection('users')
        .document(id)
        .collection('tokens')
        .getDocuments()
        .then((snapshot) {
      for (DocumentSnapshot doc in snapshot.documents) {
        doc.reference.delete();
      }
    });
  }

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
    final userProvider = Provider.of<User>(context, listen: false);
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
                leading: UserAvatar(userProvider.avatar),
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
          // _menuItem(
          //   title: 'history',
          //   leadingIcon: Icons.history,
          //   leadingIconColor: Theme.of(context).primaryColor,
          //   trailingIcon: Icons.chevron_right,
          // ),
          _menuItem(
            title: 'location',
            leadingIcon: Icons.room,
            leadingIconColor: Theme.of(context).primaryColor,
            trailingIcon: Icons.chevron_right,
            onTap: () {
              this._getCurrentLocation();
            },
          ),
          _menuItem(
            title: userProvider.isHost
                ? 'update_host_info'
                : 'register_to_helperer',
            leadingIcon: Icons.receipt,
            leadingIconColor: Theme.of(context).primaryColor,
            trailingIcon: Icons.chevron_right,
            onTap: () {
              Navigator.of(context).pushNamed(helperRegisterRoute);
            },
          ),
          userProvider.isHost
              ? _menuItem(
                  title: 'helper_management',
                  leadingIcon: Icons.library_books,
                  leadingIconColor: Theme.of(context).primaryColor,
                  trailingIcon: Icons.chevron_right,
                  onTap: () {
                    Navigator.of(context).pushNamed(helperManagementRoute);
                  },
                )
              : Container(),
          _menuSpace(),
          _menuItem(
            title: 'calendar',
            leadingIcon: Icons.calendar_today,
            leadingIconColor: Colors.lightGreen[300],
            trailingIcon: Icons.chevron_right,
            onTap: () {
              Navigator.of(context).pushNamed(calendarRoute);
            },
          ),
          _menuItem(
            title: 'statistic',
            leadingIcon: Icons.insert_chart,
            leadingIconColor: Colors.lightGreen[300],
            trailingIcon: Icons.chevron_right,
            onTap: () {
              Navigator.of(context).pushNamed(statisticRoute);
            },
          ),
          _menuSpace(),
          _menuItem(
            title: 'settings',
            leadingIcon: Icons.settings,
            trailingIcon: Icons.chevron_right,
            onTap: () {
              Navigator.of(context).pushNamed(settingRoute);
            },
          ),
          _menuItem(
              title: 'invite_friend',
              leadingIcon: Icons.people,
              trailingIcon: Icons.chevron_right,
              onTap: () {
                _showInviteFriendsDialog();
              }),
          _menuItem(
            title: 'about_app',
            leadingIcon: Icons.info,
            trailingIcon: Icons.chevron_right,
            onTap: () {
              Navigator.of(context).pushNamed(aboutRoute);
            },
          ),
          _menuSpace(),
          InkWell(
            onTap: () {
              _clearToken(userProvider.id);
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

  void _showInviteFriendsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text(
            AppLocalizations.of(context).tr('invite_friend'),
            style: TextStyle(fontSize: 16),
          ),
          children: <Widget>[
            FlatButton(
              padding: EdgeInsets.symmetric(vertical: 15.0),
              child: Text(
                AppLocalizations.of(context).tr('use_qr_code'),
              ),
              onPressed: () {
                Navigator.pop(context);
                _showQRCodeDialog();
              },
            ),
            FlatButton(
              padding: EdgeInsets.symmetric(vertical: 15.0),
              child: Text(
                AppLocalizations.of(context).tr('use_mail'),
              ),
              onPressed: () {
                Navigator.pop(context);
                _showMailDialog();
              },
            ),
          ],
        );
      },
    );
  }

  void _showQRCodeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(vertical: 20.0),
              width: MediaQuery.of(context).size.width * 0.5,
              alignment: Alignment.center,
              child: QrImage(
                data: "Smart Rabbit",
                size: MediaQuery.of(context).size.width * 0.5,
                padding: EdgeInsets.zero,
                // embeddedImage: AssetImage('assets/images/logo_x5.png'),
              ),
            ),
            InkWell(
              child: Container(
                padding: EdgeInsets.all(10.0),
                alignment: Alignment.center,
                child: Text(AppLocalizations.of(context).tr('close')),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _showMailDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Form(
                key: _emailForm,
                child: FormInput(
                  controller: _emailController,
                  label: AppLocalizations.of(context).tr('email'),
                  hint: AppLocalizations.of(context).tr('email_example'),
                  inputType: TextInputType.emailAddress,
                  validator: (String value) {
                    RegExp regex = new RegExp(EMAIL_PATTERN);
                    if (value.isEmpty) {
                      return AppLocalizations.of(context)
                          .tr('please_enter_email');
                    } else if (!regex.hasMatch(value)) {
                      return AppLocalizations.of(context).tr('invalid_email');
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          actions: <Widget>[
            InkWell(
              child: Container(
                padding: EdgeInsets.all(10.0),
                alignment: Alignment.center,
                child: Text(AppLocalizations.of(context).tr('cancel')),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            InkWell(
              child: Container(
                padding: EdgeInsets.all(10.0),
                alignment: Alignment.center,
                child: Text(
                  AppLocalizations.of(context).tr('ok'),
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
              onTap: () async {
                if (_emailForm.currentState.validate()) {
                  final result =
                      await SettingService.sendEmail(_emailController.text);
                  if (result['success']) {
                    _emailController.text = "";
                    Navigator.pop(context);
                  } else {
                    _emailController.text = "";
                    Navigator.pop(context);
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _getCurrentLocation() async {
    try {
      double lat = 21.0048;
      double long = 105.8453;

      final isGrantedPermission = await PermissionsService()
          .requestLocationPermission(onPermissionDenied: () {
        print('Can not get permission');
      });
      if (isGrantedPermission) {
        Position position = await Geolocator()
            .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        lat = position.latitude;
        long = position.longitude;
      }
      Map<String, dynamic> returnedData =
          await Navigator.push(context, MaterialPageRoute(builder: (context) {
        return ChooseAddressScreen(
          lat: lat,
          long: long,
        );
      }));
      if (returnedData != null) {
        var res = await UserService.editUserAddress(
            returnedData['address'], returnedData['lat'], returnedData['long']);
        if (res['isValid']) {
          final userProvider = Provider.of<User>(context, listen: false);
          userProvider.changeAddress(returnedData['address']);
          userProvider.changeLatatute(returnedData['lat']);
          userProvider.changeLongtitute(returnedData['long']);
          Utils.showSuccessSnackbar(context,
              AppLocalizations.of(context).tr('update_address_success'));
        } else {
          Utils.showErrorSnackbar(context);
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
