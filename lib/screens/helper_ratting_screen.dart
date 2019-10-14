import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../models/service_category.dart';
import '../utils/utils.dart';
import '../models/service_details.dart';
import '../models/user_maid.dart';
import '../widgets/form/form_input.dart';
import '../utils/constants.dart';
import '../utils/dummy_data.dart';
import '../widgets/review_carousel_slider.dart';
import '../widgets/form/form_label.dart';

class HelperRattingScreen extends StatefulWidget {
  @override
  _HelperRattingScreenState createState() => _HelperRattingScreenState();
}

class _HelperRattingScreenState extends State<HelperRattingScreen> {
  final _form = GlobalKey<FormState>();
  double _rating = 0.0;
  String _rattingComment = '';

  @override
  void initState() {
    super.initState();
    getMaidInfo();
  }

  void getMaidInfo() {}

  void _onSubmit() {
    if (_form.currentState.validate()) {
      print('ok');
    }
  }

  @override
  Widget build(BuildContext context) {
    // final userProvider = Provider.of<User>(context, listen: false);
    ServiceDetails serviceDetail = serviceHistoty.toList()[0];
    UserMaid _userMaid = serviceDetail.maid;
    ServiceCategory _serviceCategory = categoriesData[serviceDetail.category];
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
          child: Container(
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
                                    _userMaid.name != null
                                        ? _userMaid.name
                                        : '',
                                    style: TextStyle(
                                      fontSize: ScreenUtil.instance.setSp(18.0),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Text(
                                    _userMaid.email != null
                                        ? _userMaid.email
                                        : '',
                                    style: TextStyle(
                                      fontSize: ScreenUtil.instance.setSp(14.0),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Center(
                                  child: RatingBar(
                                    initialRating: _rating,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 4.0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {
                                      setState(() {
                                        _rating = rating;
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
                                            style:
                                                TextStyle(color: Colors.black)),
                                      )
                                    : SizedBox(
                                        height:
                                            ScreenUtil.instance.setHeight(20),
                                      ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    FormLabel(
                                      AppLocalizations.of(context).tr('review'),
                                    ),
                                    TextFormField(
                                      keyboardType: TextInputType.multiline,
                                      maxLines: 4,
                                      textInputAction: TextInputAction.newline,
                                      style: TextStyle(
                                        fontSize:
                                            ScreenUtil.instance.setSp(12.0),
                                        color: Colors.black,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: AppLocalizations.of(context)
                                            .tr('review_hint'),
                                        hintStyle: TextStyle(),
                                        enabledBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        contentPadding: EdgeInsets.only(
                                          top:
                                              ScreenUtil.instance.setHeight(10),
                                          bottom:
                                              ScreenUtil.instance.setHeight(10),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
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
          color: Theme.of(context).primaryColor,
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
