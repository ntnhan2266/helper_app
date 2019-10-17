import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../models/maid_review.dart';
import '../review_carousel_slider.dart';
import '../../services/review.dart';

class ReviewContainerList extends StatefulWidget {
  final String maidId;

  const ReviewContainerList(this.maidId);

  @override
  _ReviewContainerListState createState() => _ReviewContainerListState();
}

class _ReviewContainerListState extends State<ReviewContainerList> {
  List<MaidReview> _reviews = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    getReviews();
  }

  void getReviews() async {
    final res = await ReviewService.getReviewsByMaidId(
      widget.maidId,
      pageIndex: 0,
      pageSize: 5,
    );
    setState(() {
     loading = false; 
    });
    if (res['isValid']) {
      setState(() {
        _reviews = (res['data']);
      });
    }
  }

  Widget _buildReview() {
    return _reviews.length > 0
        ? ReviewCarouselSlider(
            label: AppLocalizations.of(context).tr('review'),
            reviews: _reviews,
          )
        : Center(
            child: Text('Chua co review'),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(bottom: 15.0),
      color: Colors.white,
      child: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _buildReview(),
    );
  }
}
