import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/user_maid.dart';
import '../widgets/user_avatar.dart';

class MaidItem extends StatelessWidget {
  final UserMaid maid;
  final bool isSelected;
  final Function handleTap;

  MaidItem({@required this.maid, this.isSelected, this.handleTap});

  @override
  Widget build(BuildContext context) {
    final numericFormatter = new NumberFormat("#,###", "en_US");
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? Theme.of(context).primaryColor : Colors.white,
      ),
      child: ListTile(
        selected: isSelected,
        onTap: () {
          handleTap(maid);
        },
        leading: UserAvatar(maid.avatar),
        title: Text(
          maid.name,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
        subtitle: Text(
          numericFormatter.format(maid.salary) + ' VND/h',
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.chevron_right,
            color: isSelected ? Colors.white : Colors.black,
          ),
          onPressed: () {
            // TODO Go to user's details page
          },
        ),
      ),
    );
  }
}
