import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer<User>(
        builder: (ctx, user, _) => Text(
          user.uid
        ),
      ),
    );
  }
}