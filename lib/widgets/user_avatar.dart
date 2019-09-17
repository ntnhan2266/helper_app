import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final String avatar;
  UserAvatar(this.avatar);
  
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: avatar != null
          ? NetworkImage(avatar)
          : AssetImage('assets/images/avt_default.png'),
      backgroundColor: Colors.white,
    );
  }
}
