import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

import '../models/user_maid.dart';
import '../widgets/user_avatar.dart';
import '../utils/route_names.dart';

class MaidItem extends StatelessWidget {
  final UserMaid maid;
  final bool isSelected;
  final Function handleTap;
  final double distance;

  MaidItem({
    @required this.maid,
    this.isSelected,
    this.handleTap,
    this.distance,
  });

  String _getDistance(distance) {
    var temp = distance.toDouble();
    if (temp < 1000) {
      return temp.toStringAsFixed(0) + "m";
    } else if (temp < 50000) {
      return (temp / 1000).toStringAsFixed(1) + "km";
    } else {
      return "-";
    }
  }

  @override
  Widget build(BuildContext context) {
    final numericFormatter = new NumberFormat("#,###", "en_US");
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? Theme.of(context).primaryColor : Colors.white,
      ),
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: ListTile(
        selected: isSelected,
        onTap: () {
          handleTap(maid);
        },
        leading: Container(
          width: MediaQuery.of(context).size.width * 0.15,
          height: MediaQuery.of(context).size.width * 0.15,
          child: UserAvatar(maid.avatar),
        ),
        title: Text(
          maid.name,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 10),
            Text(
              numericFormatter.format(maid.salary) + ' VND/h',
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 5),
            Text(
              (distance != null
                  ? AppLocalizations.of(context)
                      .tr('distance_display', args: [_getDistance(distance)])
                  : AppLocalizations.of(context).tr('no_location')),
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 5),
            RatingBar(
              initialRating: (maid.rating ?? 0).toDouble(),
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.only(right: 4.0),
              itemSize: 16,
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              ignoreGestures: true,
              onRatingUpdate: (double value) {},
            ),
          ],
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.chevron_right,
            color: isSelected ? Colors.white : Colors.black,
          ),
          onPressed: () {
            Navigator.of(context)
                .pushNamed(helperDetailRoute, arguments: maid.id);
          },
        ),
      ),
    );
  }
}
