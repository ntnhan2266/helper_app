import 'package:flutter/material.dart';

import '../models/user_maid.dart';
import './maid_item.dart';

class MaidList extends StatelessWidget {
  final List<dynamic> maids;
  final int total;
  final String selectedID;
  final Function handleTap;

  MaidList({this.maids, this.total, this.selectedID, this.handleTap});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        final user = maids[index]['user'];
        return MaidItem(
          maid: UserMaid(
            address: user['address'],
            avatar: maids[index]['avatar'],
            birthday: DateTime.parse(user['birthday']),
            createdAt: DateTime.parse(maids[index]['createdAt']),
            email: user['email'],
            exp: maids[index]['exp'],
            gender: user['gender'],
            id: maids[index]['_id'],
            intro: maids[index]['intro'],
            jobTypes: maids[index]['jobTypes'].cast<int>(),
            literacyType: maids[index]['literacyType'],
            name: user['name'],
            phoneNumber: user['phoneNumber'],
            salaryType: maids[index]['salaryType'],
            supportAreas: maids[index]['supportAreas'].cast<int>(),
          ),
          isSelected: selectedID == maids[index]['_id'],
          handleTap: handleTap
        );
      },
      itemCount: maids.length,
    );
  }
}
