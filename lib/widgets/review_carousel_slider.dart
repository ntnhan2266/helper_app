import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/form/form_label.dart';

class ReviewCarouselSlider extends StatelessWidget {
  final String label;
  final List reviews;

  const ReviewCarouselSlider(
      {Key key, @required this.label, @required this.reviews})
      : assert(reviews != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: FormLabel(label),
        ),
        CarouselSlider(
          viewportFraction: 1.0,
          enableInfiniteScroll: false,
          items: reviews.map((review) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
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
                    itemPadding:
                        EdgeInsets.only(top: 10.0, right: 2.0, bottom: 5.0),
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
          }).toList(),
        ),
      ],
    );
  }
}
