import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../widgets/components/review_container.dart';
import '../utils/route_names.dart';
import '../widgets/form/form_label.dart';
import '../models/maid_review.dart';

class ReviewCarouselSlider extends StatelessWidget {
  final String label;
  final List<MaidReview> reviews;

  const ReviewCarouselSlider(
      {Key key, @required this.label, @required this.reviews})
      : assert(reviews != null),
        super(key: key);

  List<Widget> _getReviews(BuildContext context) {
    return reviews
        .map((review) => Container(child: ReviewContainer(review)))
        .toList();
  }

  List<Widget> _getReviewsAndMore(BuildContext context) {
    List<Widget> reviews = _getReviews(context);
    reviews.add(
      Container(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(helperReviewsRoute);
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  AppLocalizations.of(context).tr("more"),
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                Icon(
                  Icons.chevron_right,
                  color: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
    return reviews;
  }

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
          items: _getReviewsAndMore(context),
        ),
      ],
    );
  }
}
