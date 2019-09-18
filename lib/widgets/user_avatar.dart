import 'package:flutter/material.dart';

import '../configs/api.dart';

class UserAvatar extends StatelessWidget {
  final String avatar;
  UserAvatar(this.avatar);
  
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: avatar != null
          ? NetworkImage(APIConfig.hostURL + avatar)
          : AssetImage('assets/images/avt_default.png'),
      backgroundColor: Colors.white,
    );
  }
}