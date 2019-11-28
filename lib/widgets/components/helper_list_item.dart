import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class HelperListItem extends StatefulWidget {
  final maid;

  const HelperListItem(this.maid);

  @override
  _HelperListItemState createState() => _HelperListItemState();
}

class _HelperListItemState extends State<HelperListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      margin: EdgeInsets.symmetric(vertical: 3.0, horizontal: 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: <Widget>[
          Image.asset(
            'assets/images/category.png',
            width: MediaQuery.of(context).size.width / 4,
            height: MediaQuery.of(context).size.width / 6,
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
                Text(widget.maid['salary'].toString() ?? "-" + " VND/hour"),
                SizedBox(height: 5),
                RatingBar(
                  initialRating: widget.maid['ratting'] ?? 0,
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
