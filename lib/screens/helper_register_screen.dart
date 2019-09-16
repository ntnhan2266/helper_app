import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_rabbit/widgets/form/form_multichoice.dart';
import 'package:provider/provider.dart';

import '../widgets/form/form_dropdown.dart';
import '../widgets/form/form_input.dart';
import '../models/user.dart';

class HelperRegisterScreen extends StatefulWidget {
  @override
  _HelperRegisterScreenState createState() => _HelperRegisterScreenState();
}

class _HelperRegisterScreenState extends State<HelperRegisterScreen> {
  final _form = GlobalKey<FormState>();
  bool _agree = false;

  void _onSubmit() {
    if (_form.currentState.validate()) {
      print('ok');
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<User>(context, listen: false);
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
            AppLocalizations.of(context).tr('register_to_helperer'),
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
                                    userProvider.name != null
                                        ? userProvider.name
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
                                    userProvider.email != null
                                        ? userProvider.email
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
                            margin: EdgeInsets.only(
                                top: ScreenUtil.instance.setHeight(20.0)),
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 15),
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                FormInput(
                                  label: AppLocalizations.of(context)
                                      .tr('introduction'),
                                  hint: AppLocalizations.of(context)
                                      .tr('introduction_hint'),
                                  hasNext: true,
                                  inputType: TextInputType.multiline,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return AppLocalizations.of(context).tr('intro_required');
                                    }
                                    return null;
                                  },
                                ),
                                FormDropdown(
                                  label: AppLocalizations.of(context)
                                      .tr('literacy'),
                                  values: [
                                    AppLocalizations.of(context)
                                        .tr('literacy_choice_1'),
                                    AppLocalizations.of(context)
                                        .tr('literacy_choice_2'),
                                    AppLocalizations.of(context)
                                        .tr('literacy_choice_3'),
                                    AppLocalizations.of(context)
                                        .tr('literacy_choice_4'),
                                    AppLocalizations.of(context)
                                        .tr('literacy_choice_5'),
                                  ],
                                  hasNext: true,
                                ),
                                FormInput(
                                  label: AppLocalizations.of(context)
                                      .tr('experience'),
                                  hint: AppLocalizations.of(context)
                                      .tr('experience_hint'),
                                  inputType: TextInputType.multiline,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return AppLocalizations.of(context).tr('exp_required');
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(top: 20),
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 15),
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                FormDropdown(
                                  label: AppLocalizations.of(context)
                                      .tr('salary'),
                                  values: [
                                    AppLocalizations.of(context)
                                        .tr('salary_choice_1'),
                                    AppLocalizations.of(context)
                                        .tr('salary_choice_2'),
                                    AppLocalizations.of(context)
                                        .tr('salary_choice_3'),
                                    AppLocalizations.of(context)
                                        .tr('salary_choice_4'),
                                    AppLocalizations.of(context)
                                        .tr('salary_choice_5'),
                                    AppLocalizations.of(context)
                                        .tr('salary_choice_6'),
                                    AppLocalizations.of(context)
                                        .tr('salary_choice_7'),
                                    AppLocalizations.of(context)
                                        .tr('salary_choice_8'),
                                    AppLocalizations.of(context)
                                        .tr('salary_choice_9'),
                                    AppLocalizations.of(context)
                                        .tr('salary_choice_10'),
                                    AppLocalizations.of(context)
                                        .tr('salary_choice_11'),
                                  ],
                                  hasNext: true,
                                ),
                                FormMultiChoice(
                                  label:
                                      AppLocalizations.of(context).tr('work'),
                                  hint: AppLocalizations.of(context)
                                      .tr('work_hint'),
                                  values: <String>[
                                    AppLocalizations.of(context)
                                        .tr('work_choice_1'),
                                    AppLocalizations.of(context)
                                        .tr('work_choice_2'),
                                    AppLocalizations.of(context)
                                        .tr('work_choice_3'),
                                    AppLocalizations.of(context)
                                        .tr('work_choice_4'),
                                    AppLocalizations.of(context)
                                        .tr('work_choice_5'),
                                    AppLocalizations.of(context)
                                        .tr('work_choice_6'),
                                  ],
                                  hasNext: true,
                                ),
                                FormMultiChoice(
                                  label: AppLocalizations.of(context)
                                      .tr('support_area'),
                                  hint: AppLocalizations.of(context)
                                      .tr('support_area_hint'),
                                  values: <String>[
                                    AppLocalizations.of(context)
                                        .tr('support_area_choice_1'),
                                    AppLocalizations.of(context)
                                        .tr('support_area_choice_2'),
                                    AppLocalizations.of(context)
                                        .tr('support_area_choice_3'),
                                    AppLocalizations.of(context)
                                        .tr('support_area_choice_4'),
                                    AppLocalizations.of(context)
                                        .tr('support_area_choice_5'),
                                    AppLocalizations.of(context)
                                        .tr('support_area_choice_6'),
                                    AppLocalizations.of(context)
                                        .tr('support_area_choice_7'),
                                    AppLocalizations.of(context)
                                        .tr('support_area_choice_8'),
                                    AppLocalizations.of(context)
                                        .tr('support_area_choice_9'),
                                    AppLocalizations.of(context)
                                        .tr('support_area_choice_10'),
                                    AppLocalizations.of(context)
                                        .tr('support_area_choice_11'),
                                    AppLocalizations.of(context)
                                        .tr('support_area_choice_12'),
                                    AppLocalizations.of(context)
                                        .tr('support_area_choice_13'),
                                    AppLocalizations.of(context)
                                        .tr('support_area_choice_14'),
                                    AppLocalizations.of(context)
                                        .tr('support_area_choice_15'),
                                    AppLocalizations.of(context)
                                        .tr('support_area_choice_16'),
                                    AppLocalizations.of(context)
                                        .tr('support_area_choice_17'),
                                    AppLocalizations.of(context)
                                        .tr('support_area_choice_18'),
                                    AppLocalizations.of(context)
                                        .tr('support_area_choice_19'),
                                    AppLocalizations.of(context)
                                        .tr('support_area_choice_20'),
                                    AppLocalizations.of(context)
                                        .tr('support_area_choice_21'),
                                    AppLocalizations.of(context)
                                        .tr('support_area_choice_22'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(top: ScreenUtil.instance.setHeight(20),),
                            color: Colors.white,
                            child: Row(
                              children: <Widget>[
                                Checkbox(
                                  value: _agree,
                                  onChanged: (bool value) {
                                    setState(() {
                                      _agree = value;
                                    });
                                  },
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _agree = !_agree;
                                    });
                                  },
                                  child: Text(
                                    AppLocalizations.of(context)
                                        .tr('i_agree'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: ScreenUtil.instance.setHeight(20.0),
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
                  AppLocalizations.of(context).tr('register').toUpperCase(),
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
