import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';

class FavouriteStaffTab extends StatefulWidget {
  @override
  _FavouriteStaffTabState createState() => _FavouriteStaffTabState();
}

class _FavouriteStaffTabState extends State<FavouriteStaffTab> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer<User>(
        builder: (ctx, user, _) => Text(
          user.email
        ),
      )
    );
  }
}