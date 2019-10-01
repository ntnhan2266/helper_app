import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReviewContainer extends StatelessWidget {
  final review;

  const ReviewContainer(this.review, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            review['username'],
            style: TextStyle(
                fontSize: ScreenUtil.instance.setSp(16),
                fontWeight: FontWeight.w500),
          ),
          RatingBar(
            initialRating: review['ratting'],
            allowHalfRating: true,
            itemSize: ScreenUtil.instance.setSp(20),
            itemCount: 5,
            itemPadding: EdgeInsets.only(top: 10.0, right: 2.0, bottom: 5.0),
            itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
            onRatingUpdate: (rating) {},
          ),
          Text(
            review['content'],
            style: TextStyle(fontSize: ScreenUtil.instance.setSp(14)),
          ),
        ],
      ),
    );
  }
}
