import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/maid_review.dart';

class ReviewContainer extends StatefulWidget {
  final MaidReview review;

  const ReviewContainer(this.review, {Key key}) : super(key: key);

  @override
  _ReviewContainerState createState() => _ReviewContainerState();
}

class _ReviewContainerState extends State<ReviewContainer> {
  int _like = 0;

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
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.review.createdBy != null ? widget.review.createdBy.name : 'user_name',
                style: TextStyle(
                    fontSize: ScreenUtil.instance.setSp(16),
                    fontWeight: FontWeight.w500),
              ),
              RatingBar(
                initialRating: widget.review.ratting,
                allowHalfRating: true,
                itemSize: ScreenUtil.instance.setSp(20),
                itemCount: 5,
                itemPadding:
                    EdgeInsets.only(top: 10.0, right: 2.0, bottom: 5.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {},
              ),
              Text(
                widget.review.content,
                style: TextStyle(fontSize: ScreenUtil.instance.setSp(14)),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                InkWell(
                  child: Row(
                    children: <Widget>[
                      Text(
                        widget.review.helpful.toString()
                      ),
                      SizedBox(width: ScreenUtil.instance.setWidth(5),),
                      Icon(
                        Icons.thumb_up,
                        size: ScreenUtil.instance.setSp(16),
                        color: _like > 0 ? Theme.of(context).primaryColor : Colors.grey,
                      ),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      _like = _like == 1 ? 0 : 1;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
