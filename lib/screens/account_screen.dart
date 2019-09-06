import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:smart_rabbit/utils/constants.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context).tr('account'),
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
        ),
        body: ListView(
          children: <Widget>[
            InkWell(
              onTap: () {},
              child: Container(
                color: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 7.0),
                child: ListTile(
                  title: Text(
                    'Nhan Nguyen',
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: CircleAvatar(),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.black12,
              height: 10,
            ),
            InkWell(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.only(left: 7.0),
                decoration: new BoxDecoration(
                  border: new Border(
                      bottom: BorderSide(color: Colors.black12, width: 1.0)),
                ),
                child: ListTile(
                  title: Text('Lich su'),
                  leading: Icon(Icons.pets),
                  trailing: Icon(Icons.chevron_right),
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.only(left: 7.0),
                decoration: new BoxDecoration(
                  border: new Border(
                      bottom: BorderSide(color: Colors.black12, width: 1.0)),
                ),
                child: ListTile(
                  title: Text('Vi voucher'),
                  leading: Icon(Icons.pets),
                  trailing: Icon(Icons.chevron_right),
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.only(left: 7.0),
                decoration: new BoxDecoration(
                  border: new Border(
                      bottom: BorderSide(color: Colors.black12, width: 1.0)),
                ),
                child: ListTile(
                  title: Text('Dia chi'),
                  leading: Icon(Icons.pets),
                  trailing: Icon(Icons.chevron_right),
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.only(left: 7.0),
                decoration: new BoxDecoration(
                  border: new Border(
                      bottom: BorderSide(color: Colors.black12, width: 1.0)),
                ),
                child: ListTile(
                  title: Text('Hoa don'),
                  leading: Icon(Icons.pets),
                  trailing: Icon(Icons.chevron_right),
                ),
              ),
            ),
            Container(
              color: Colors.black12,
              height: 10,
            ),
            InkWell(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.only(left: 7.0),
                decoration: new BoxDecoration(
                  border: new Border(
                      bottom: BorderSide(color: Colors.black12, width: 1.0)),
                ),
                child: ListTile(
                  title: Text('Moi ban be'),
                  leading: Icon(Icons.pets),
                  trailing: Icon(Icons.chevron_right),
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.only(left: 7.0),
                decoration: new BoxDecoration(
                  border: new Border(
                      bottom: BorderSide(color: Colors.black12, width: 1.0)),
                ),
                child: ListTile(
                  title: Text('Danh gia'),
                  leading: Icon(Icons.pets),
                  trailing: Icon(Icons.chevron_right),
                ),
              ),
            ),
            Container(
              color: Colors.black12,
              height: 10,
            ),
            InkWell(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.only(left: 7.0),
                decoration: new BoxDecoration(
                  border: new Border(
                      bottom: BorderSide(color: Colors.black12, width: 1.0)),
                ),
                child: ListTile(
                  title: Text('Moi ban be'),
                  leading: Icon(Icons.pets),
                  trailing: Icon(Icons.chevron_right),
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.only(left: 7.0),
                decoration: new BoxDecoration(
                  border: new Border(
                      bottom: BorderSide(color: Colors.black12, width: 1.0)),
                ),
                child: ListTile(
                  title: Text('Danh gia'),
                  leading: Icon(Icons.pets),
                  trailing: Icon(Icons.chevron_right),
                ),
              ),
            ),
            Container(
              color: Colors.black12,
              height: 10,
            ),
            InkWell(
              onTap: () {},
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 17.0),
                child: Text(
                  'Dang xuat',
                  style: TextStyle(
                    color: Color(MAIN_COLOR),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
