import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../widgets/components/review_container_list.dart';
import '../widgets/form/form_label.dart';
import '../models/service_details.dart';
import '../models/user_maid.dart';
import '../utils/constants.dart';
import '../configs/api.dart';
import '../services/maid.dart';
import '../services/review.dart';
import '../utils/route_names.dart';
import '../utils/utils.dart';

class HelperRattingScreen extends StatefulWidget {
  final ServiceDetails data;
  HelperRattingScreen(this.data);

  @override
  _HelperRattingScreenState createState() => _HelperRattingScreenState();
}

class ReviewData {
  double rating = 0.0;
  String content = '';
  String maidId;
  String bookingId;
}

class _HelperRattingScreenState extends State<HelperRattingScreen> {
  final _form = GlobalKey<FormState>();
  String _rattingComment = '';
  bool loading = true;
  bool submitting = false;
  bool error = false;
  UserMaid maid;
  ReviewData reviewData = ReviewData();

  @override
  void initState() {
    super.initState();
    getMaidInfo();
    reviewData.maidId = widget.data.maid.id;
    reviewData.bookingId = widget.data.id;
  }

  void getMaidInfo() async {
    final res = await MaidService.getMaid(id: widget.data.maid.id);
    if (res['isHost']) {
      setState(() {
        maid = UserMaid.fromJson(res['maid']);
        loading = false;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  void _onSubmit() async {
    if (submitting) {
      return;
    }
    if (reviewData.rating == 0) {
      setState(() {
       error = true; 
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text(
              AppLocalizations.of(context).tr('error'),
              style: TextStyle(color: Color.fromRGBO(165, 0, 0, 1)),
            ),
            content: new Text(
              AppLocalizations.of(context).tr('rating_required'),
            ),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text(
                  AppLocalizations.of(context).tr('close'),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else if (_form.currentState.validate()) {
      _form.currentState.save();
      setState(() {
       submitting = true; 
      });
      final res = await ReviewService.review(rating: reviewData.rating, bookingId: reviewData.bookingId, content: reviewData.content, maidId: reviewData.maidId);
      setState(() {
       submitting = false; 
      });
      if (res['isValid']) {
        Navigator.of(context).pushReplacementNamed(homeScreenRoute);
        Utils.showSuccessSnackbar(context, AppLocalizations.of(context).tr('review_successfully'));
      } else {
        Utils.showSuccessSnackbar(context, AppLocalizations.of(context).tr('review_error'));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
            AppLocalizations.of(context).tr('helper_review'),
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
          child: loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  color: Colors.blueGrey[50],
                  height: double.infinity,
                  width: double.infinity,
                  child: ListView(
                    children: <Widget>[
                      Stack(
                        alignment: AlignmentDirectional.topCenter,
                        children: <Widget>[
                          Container(
                            height: 130,
                            color: Theme.of(context).primaryColor,
                          ),
                          Form(
                            key: _form,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  width: screenWidth * 0.8,
                                  margin: EdgeInsets.only(
                                      top: ScreenUtil.instance.setHeight(30.0)),
                                  padding: EdgeInsets.symmetric(
                                      vertical:
                                          ScreenUtil.instance.setHeight(30.0)),
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
                                        height:
                                            ScreenUtil.instance.setWidth(70),
                                        child: CircleAvatar(
                                          backgroundImage: maid.avatar != null
                                              ? NetworkImage(APIConfig.hostURL +
                                                  maid.avatar)
                                              : AssetImage(
                                                  'assets/images/avt_default.png'),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 15),
                                        child: Text(
                                          maid.name != null ? maid.name : '--',
                                          style: TextStyle(
                                            fontSize:
                                                ScreenUtil.instance.setSp(18.0),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Text(
                                          maid.email != null
                                              ? maid.email
                                              : '--',
                                          style: TextStyle(
                                            fontSize:
                                                ScreenUtil.instance.setSp(14.0),
                                            color: Colors.black45,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  // height: double.infinity,
                                  margin: EdgeInsets.only(
                                      top: ScreenUtil.instance.setHeight(20.0)),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 15),
                                  color: Colors.white,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Center(
                                        child: RatingBar(
                                          initialRating: reviewData.rating,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemPadding: EdgeInsets.symmetric(
                                              horizontal: 4.0),
                                          itemBuilder: (context, _) => Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          onRatingUpdate: (rating) {
                                            setState(() {
                                              reviewData.rating = rating;
                                              error = false;  
                                              _rattingComment =
                                                  RATTING[rating.ceil()];
                                            });
                                          },
                                        ),
                                      ),
                                      _rattingComment != ''
                                          ? Container(
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.only(
                                                  bottom: 30, top: 10),
                                              child: Text(
                                                  AppLocalizations.of(context)
                                                      .tr(_rattingComment),
                                                  style: TextStyle(
                                                      color: Colors.black)),
                                            )
                                          : SizedBox(
                                              height: ScreenUtil.instance
                                                  .setHeight(20),
                                            ),
                                      error ? 
                                      Container(
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.only(
                                                  bottom: 30, top: 10),
                                              child: Text(
                                                  AppLocalizations.of(context)
                                                      .tr('rating_required'),
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(165, 0, 0, 1))),
                                            )
                                          : SizedBox(
                                              height: ScreenUtil.instance
                                                  .setHeight(20),
                                            ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          FormLabel(
                                            AppLocalizations.of(context)
                                                .tr('review'),
                                          ),
                                          TextFormField(
                                            validator: (String val) {
                                              if (val.isEmpty) {
                                                return AppLocalizations.of(
                                                        context)
                                                    .tr('review_content_required');
                                              } else if (val.length < 50) {
                                                return AppLocalizations.of(
                                                        context)
                                                    .tr('review_content_minlength');
                                              } else {
                                                return null;
                                              }
                                            },
                                            keyboardType:
                                                TextInputType.multiline,
                                            maxLines: 4,
                                            textInputAction:
                                                TextInputAction.newline,
                                            style: TextStyle(
                                              fontSize: ScreenUtil.instance
                                                  .setSp(12.0),
                                              color: Colors.black,
                                            ),
                                            decoration: InputDecoration(
                                              hintText:
                                                  AppLocalizations.of(context)
                                                      .tr('review_hint'),
                                              hintStyle: TextStyle(),
                                              enabledBorder: InputBorder.none,
                                              disabledBorder: InputBorder.none,
                                              contentPadding: EdgeInsets.only(
                                                top: ScreenUtil.instance
                                                    .setHeight(10),
                                                bottom: ScreenUtil.instance
                                                    .setHeight(10),
                                              ),
                                            ),
                                            onSaved: (String val) {
                                              setState(() {
                                                reviewData.content = val;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: ScreenUtil.instance.setHeight(20.0),
                                ),
                                ReviewContainerList(widget.data.maid.id),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
        ),
        bottomNavigationBar: Container(
          color: submitting ? Colors.grey : Theme.of(context).primaryColor,
          padding: EdgeInsets.all(ScreenUtil.instance.setWidth(12.0)),
          child: InkWell(
            onTap: _onSubmit,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  AppLocalizations.of(context).tr('ok').toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: ScreenUtil.instance.setSp(13),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
