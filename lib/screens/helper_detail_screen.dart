import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

import '../models/user_maid.dart';
import '../widgets/form/form_input.dart';
import '../widgets/review_carousel_slider.dart';
import '../utils/utils.dart';
import '../utils/dummy_data.dart';
import '../services/maid.dart';
import '../widgets/user_avatar.dart';

Future<UserMaid> fetchMaidInfo(String maidId) async {
  final res = await MaidService.getMaid(id: maidId);
  if (res['isHost']) {
    print((res['maid']));
    return UserMaid.fromJson(res['maid']);
  } else {
    throw Exception('Failed to load data');
  }
}

class HelperDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String id = ModalRoute.of(context).settings.arguments;
    return HelperDetailScreenData(maid: fetchMaidInfo(id));
  }
}

class HelperDetailScreenData extends StatelessWidget {
  final Future<UserMaid> maid;

  HelperDetailScreenData({Key key, this.maid}) : super(key: key);
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
          child: FutureBuilder<UserMaid>(
            future: maid,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                UserMaid userMaid = snapshot.data;
                return Container(
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
                                        child: UserAvatar(userMaid.avatar),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 15),
                                        child: Text(
                                          userMaid.name != null
                                              ? userMaid.name
                                              : '',
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
                                          userMaid.email != null
                                              ? userMaid.email
                                              : AppLocalizations.of(context)
                                                  .tr("no_email_info"),
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
                                          ignoreGestures: true,
                                          initialRating: userMaid.rating,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemPadding: EdgeInsets.symmetric(
                                              horizontal: 4.0),
                                          itemBuilder: (context, _) => Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          onRatingUpdate: (rating) {},
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.only(
                                            bottom: 10, top: 10),
                                        child: Text(AppLocalizations.of(context)
                                            .tr('ratting_comment',
                                                args: ['30'])),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: ScreenUtil.instance.setHeight(20.0),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.symmetric(
                                    vertical: 15.0,
                                    horizontal: 10.0,
                                  ),
                                  color: Colors.white,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      FormInput(
                                        label: AppLocalizations.of(context)
                                            .tr("gender"),
                                        initialValue:
                                            AppLocalizations.of(context).tr(
                                                Utils.intToGender(
                                                    userMaid.gender)),
                                        enabled: false,
                                        hasNext: true,
                                      ),
                                      FormInput(
                                        label: AppLocalizations.of(context)
                                            .tr("birthday"),
                                        initialValue: DateFormat("dd-MM-yyyy")
                                            .format(userMaid.birthday),
                                        enabled: false,
                                        hasNext: true,
                                      ),
                                      FormInput(
                                        label: AppLocalizations.of(context)
                                            .tr("address"),
                                        initialValue: userMaid.address,
                                        enabled: false,
                                        hasNext: false,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: ScreenUtil.instance.setHeight(20.0),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.symmetric(
                                    vertical: 15.0,
                                    horizontal: 10.0,
                                  ),
                                  color: Colors.white,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      FormInput(
                                        label: AppLocalizations.of(context)
                                            .tr("introduction"),
                                        initialValue: userMaid.intro,
                                        enabled: false,
                                        hasNext: true,
                                      ),
                                      FormInput(
                                        label: AppLocalizations.of(context)
                                            .tr("experience"),
                                        initialValue: userMaid.exp,
                                        enabled: false,
                                        hasNext: true,
                                      ),
                                      FormInput(
                                        label: AppLocalizations.of(context)
                                            .tr("literacy"),
                                        initialValue:
                                            AppLocalizations.of(context).tr(
                                                Utils.intToLiteracy(
                                                    userMaid.literacyType)),
                                        enabled: false,
                                        hasNext: true,
                                      ),
                                      FormInput(
                                        label: AppLocalizations.of(context)
                                            .tr("salary"),
                                        initialValue:
                                            userMaid.salary.toString() + ' VND',
                                        enabled: false,
                                        hasNext: true,
                                      ),
                                      FormInput(
                                        label: AppLocalizations.of(context)
                                            .tr("work"),
                                        initialValue: userMaid.jobTypes
                                            .map((x) =>
                                                AppLocalizations.of(context)
                                                    .tr(Utils.intToJob(x)))
                                            .join(", "),
                                        enabled: false,
                                        hasNext: true,
                                        inputType: TextInputType.multiline,
                                      ),
                                      FormInput(
                                        label: AppLocalizations.of(context)
                                            .tr("support_area"),
                                        initialValue: userMaid.supportAreas
                                            .map((x) =>
                                                AppLocalizations.of(context).tr(
                                                    Utils.intToSupportArea(x)))
                                            .join(", "),
                                        enabled: false,
                                        hasNext: false,
                                        inputType: TextInputType.multiline,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: ScreenUtil.instance.setHeight(20.0),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.only(bottom: 15.0),
                                  color: Colors.white,
                                  child: ReviewCarouselSlider(
                                    label: AppLocalizations.of(context)
                                        .tr('review'),
                                    reviews: reviews,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text("${snapshot.error}"));
              }
              // By default, show a loading spinner.
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}
