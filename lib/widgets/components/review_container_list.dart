import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../utils/dummy_data.dart';
import '../../models/maid_review.dart';
import '../review_carousel_slider.dart';

class ReviewContainerList extends StatefulWidget {
  final String maidId;

  const ReviewContainerList(this.maidId);

  @override
  _ReviewContainerListState createState() => _ReviewContainerListState();
}

class _ReviewContainerListState extends State<ReviewContainerList> {
  List<MaidReview> _reviews = reviews.map((review) => MaidReview.fromJson(review)).toList();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(bottom: 15.0),
      color: Colors.white,
      child: ReviewCarouselSlider(
        label: AppLocalizations.of(context).tr('review'),
        reviews: _reviews,
      ),
    );
  }
}
