import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../models/user_maid.dart';
import './maid_item.dart';

class MaidList extends StatelessWidget {
  final List<dynamic> maids;
  final int total;
  final String selectedID;
  final Function handleTap;
  final ScrollController scrollController;

  MaidList({
    this.maids,
    this.total,
    this.selectedID,
    this.handleTap,
    @required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return maids.length > 0
        ? ListView.builder(
            controller: scrollController,
            itemBuilder: (BuildContext context, int index) {
              final maid = maids[index];
              return MaidItem(
                  maid: UserMaid(
                    id: maid['_id'],
                    name: maid['name'],
                    salary: maid['salary'],
                    rating: maid['ratting'].toDouble(),
                    avatar: maid['avatar'],
                  ),
                  distance: maid['distance'] == null ? null : maid['distance'].toDouble(),
                  isSelected: selectedID == maid['_id'],
                  handleTap: handleTap);
            },
            itemCount: maids.length,
          )
        : Center(
            child: Text(AppLocalizations.of(context).tr('no_maids')),
          );
  }
}
