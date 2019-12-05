import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:smart_rabbit/configs/api.dart';

class HelperListItem extends StatefulWidget {
  final maid;

  const HelperListItem(this.maid);

  @override
  _HelperListItemState createState() => _HelperListItemState();
}

class _HelperListItemState extends State<HelperListItem> {
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
    print(widget.maid['location']);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      margin: EdgeInsets.symmetric(vertical: 3.0, horizontal: 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width / 4,
            height: MediaQuery.of(context).size.width / 4,
            padding: EdgeInsets.all(10.0),
            margin: EdgeInsets.only(right: 10.0),
            child: CircleAvatar(
              backgroundImage: widget.maid['avatar'] != null
                  ? NetworkImage(APIConfig.hostURL + widget.maid['avatar'])
                  : AssetImage('assets/images/avt_default.png'),
              backgroundColor: Colors.transparent,
            ),
          ),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.maid['name'] ?? "-",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  (widget.maid['salary'] ?? "-").toString() +
                      " " +
                      AppLocalizations.of(context).tr('vnd_hour'),
                ),
                SizedBox(height: 5),
                Text(
                  (widget.maid['distance'] != null
                      ? AppLocalizations.of(context).tr('distance_display',
                          args: [_getDistance(widget.maid['distance'])])
                      : AppLocalizations.of(context).tr('no_location')),
                ),
                SizedBox(height: 5),
                RatingBar(
                  initialRating: (widget.maid['ratting'] ?? 0).toDouble(),
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.only(right: 4.0),
                  itemSize: 20,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  ignoreGestures: true,
                  onRatingUpdate: (double value) {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
