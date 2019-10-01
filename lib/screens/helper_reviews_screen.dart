import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/components/review_container.dart';
import '../widgets/form/form_label.dart';
import '../models/user_maid.dart';
import '../utils/dummy_data.dart';

class HelperReviewsScreen extends StatefulWidget {
  @override
  _HelperReviewsScreenState createState() => _HelperReviewsScreenState();
}

class _HelperReviewsScreenState extends State<HelperReviewsScreen> {
  List reviewList = [];
  int pageIndex = 0;
  bool isLoading = true;
  bool canLoadMore = true;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Set event
    _fetchReviews();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _fetchReviews();
      }
    });
  }

  void _fetchReviews() async {
    if (!canLoadMore || !mounted) {
      return;
    }
    setState(() {
      isLoading = true;
    });
    Future.delayed(Duration(seconds: 2), () {
      if (pageIndex < 20) {
        setState(() {
          reviewList.addAll(reviews);
          pageIndex = reviewList.length;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  Widget _getReviews() {
    return ListView.builder(
      primary: false,
      shrinkWrap: true,
      itemCount: reviewList.length,
      itemBuilder: (BuildContext context, int index) {
        var review = reviewList[index];
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 3.0),
          child: ReviewContainer(review),
        );
      },
    );
  }

  Widget _getLoading() {
    return isLoading
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20.0,
                  horizontal: 10.0,
                ),
                child: Text(AppLocalizations.of(context).tr("loading")),
              ),
            ],
          )
        : SizedBox(height: 10.0);
  }

  @override
  Widget build(BuildContext context) {
    // final userProvider = Provider.of<User>(context, listen: false);
    UserMaid userMaid = userMaids.toList()[0];
    // Responsive
    double defaultScreenWidth = 400.0;
    double defaultScreenHeight = 810.0;
    ScreenUtil.instance = ScreenUtil(
      width: defaultScreenWidth,
      height: defaultScreenHeight,
      allowFontScaling: true,
    )..init(context);
    // Localization
    var data = EasyLocalizationProvider.of(context).data;
    // Get screen width
    final screenWidth = MediaQuery.of(context).size.width;
    // Build slide list
    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text(
            AppLocalizations.of(context).tr('helper_information'),
            style: TextStyle(
              fontSize: ScreenUtil.instance.setSp(20.0),
            ),
          ),
          centerTitle: true,
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(
            color: Colors.blueGrey[50],
            height: double.infinity,
            width: double.infinity,
            child: ListView(
              controller: _scrollController,
              children: <Widget>[
                Stack(
                  alignment: AlignmentDirectional.topCenter,
                  children: <Widget>[
                    Container(
                      height: 130,
                      color: Theme.of(context).primaryColor,
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          width: screenWidth * 0.8,
                          margin: EdgeInsets.only(
                              top: ScreenUtil.instance.setHeight(30.0)),
                          padding: EdgeInsets.symmetric(
                              vertical: ScreenUtil.instance.setHeight(30.0)),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            color: Colors.white,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                width: ScreenUtil.instance.setWidth(70),
                                height: ScreenUtil.instance.setWidth(70),
                                child: CircleAvatar(
                                  backgroundImage: AssetImage(
                                      "assets/images/female_user.jpg"),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Text(
                                  userMaid.name != null ? userMaid.name : '',
                                  style: TextStyle(
                                    fontSize: ScreenUtil.instance.setSp(18.0),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(
                                  userMaid.email != null ? userMaid.email : '',
                                  style: TextStyle(
                                    fontSize: ScreenUtil.instance.setSp(14.0),
                                    color: Colors.black45,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil.instance.setHeight(20.0),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 15.0,
                                  horizontal: 10.0,
                                ),
                                child: FormLabel(
                                    AppLocalizations.of(context).tr("review")),
                              ),
                              _getReviews(),
                              _getLoading(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
