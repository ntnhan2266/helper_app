import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_rabbit/widgets/form/form_multichoice.dart';

import '../widgets/form/form_dropdown.dart';
import '../widgets/form/form_input.dart';

class HelperRegisterScreen extends StatefulWidget {
  @override
  _HelperRegisterScreenState createState() => _HelperRegisterScreenState();
}

class _HelperRegisterScreenState extends State<HelperRegisterScreen> {
  bool _agree = false;

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
            AppLocalizations.of(context).tr('register_to_helperer'),
            style: TextStyle(
              fontSize: ScreenUtil.instance.setSp(20.0),
            ),
          ),
          centerTitle: true,
        ),
        body: Container(
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
                  Column(
                    children: <Widget>[
                      Container(
                        width: screenWidth * 0.8,
                        margin: EdgeInsets.only(top: 30),
                        padding: EdgeInsets.symmetric(vertical: 35),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              width: 70,
                              height: 70,
                              child: CircleAvatar(
                                backgroundImage:
                                    AssetImage("assets/images/female_user.jpg"),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Text(
                                "Nhan Nguyen",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(
                                "nhan.nguyen@gmail.com",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black45),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 20),
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                        color: Colors.white,
                        child: Form(
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
                              ),
                              FormInput(
                                label: AppLocalizations.of(context)
                                    .tr('experience'),
                                hint: AppLocalizations.of(context)
                                    .tr('experience_hint'),
                                hasNext: true,
                                inputType: TextInputType.multiline,
                              ),
                              FormDropdown(
                                label:
                                    AppLocalizations.of(context).tr('salary'),
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
                                label: AppLocalizations.of(context).tr('work'),
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
                              Row(
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
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 20),
                        padding: const EdgeInsets.symmetric(vertical: 17.0),
                        child: Text(
                          AppLocalizations.of(context).tr('register'),
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
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
    );
  }
}
