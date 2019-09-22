import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_rabbit/utils/constants.dart';
import 'package:smart_rabbit/widgets/form/form_multichoice.dart';
import 'package:provider/provider.dart';

import '../widgets/form/form_dropdown.dart';
import '../widgets/form/form_input.dart';
import '../widgets/user_avatar.dart';
import '../widgets/dialogs/error_dialog.dart';
import '../widgets/form/form_label.dart';
import '../models/form_select_item.dart';
import '../models/user.dart';
import '../models/maid.dart';
import '../utils/constants.dart';
import '../utils/dummy_data.dart';
import '../utils/utils.dart';
import '../services/maid.dart';

class HelperRegisterScreen extends StatefulWidget {
  @override
  _HelperRegisterScreenState createState() => _HelperRegisterScreenState();
}

class _HelperRegisterScreenState extends State<HelperRegisterScreen> {
  TextEditingController _introController = TextEditingController();
  TextEditingController _expController = TextEditingController();
  Maid _data = Maid(
    exp: '',
    intro: '',
    literacyType: 1,
    salaryType: 1,
    jobTypes: [],
    supportAreas: [],
  );
  bool loading = true;
  bool isHost = false;
  final _form = GlobalKey<FormState>();
  bool _agree = false;

  @override
  void initState() {
    super.initState();
    _getMaidInfo();
  }

  void _getMaidInfo() async {
    final res = await MaidService.getMaid();
    if (res['isHost']) {
      setState(() {
        isHost = true;
        _data.fromJson(res['maid']);
        _introController.text = _data.intro;
        _expController.text = _data.exp;
        loading = false;
      });
    } else {
      setState(() {
        isHost = false;
        loading = false;
      });
    }
  }

  void _handleChangeLiteracy(int value) {
    setState(() {
      _data.literacyType = value;
    });
  }

  void _handleChangeSalary(int value) {
    setState(() {
      _data.salaryType = value;
    });
  }

  void _handleChangeJob(List<int> values) {
    setState(() {
      _data.jobTypes = values;
    });
  }

  void _handleChangeArea(List<int> values) {
    setState(() {
      _data.supportAreas = values;
    });
  }

  void _onSubmit() async {
    if (_form.currentState.validate()) {
      // Specific custom validate
      if (!_agree && !isHost) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            // return object of type Dialog
            return ErrorDialog(
              AppLocalizations.of(context).tr('agree_with_policy'),
            );
          },
        );
        return;
      }
      if (_data.jobTypes.length == 0) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            // return object of type Dialog
            return ErrorDialog(
              AppLocalizations.of(context).tr('choose_job_type'),
            );
          },
        );
        return;
      }
      if (_data.supportAreas.length == 0) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            // return object of type Dialog
            return ErrorDialog(
              AppLocalizations.of(context).tr('choose_supported_area'),
            );
          },
        );
        return;
      }
      // Call API register host
      _form.currentState.save();
      if (isHost) {
        // Edit info
        editHostInfo();
      } else {
        // Register host
        _registerHost();
      }
    }
  }

  void _registerHost() async {
    final res = await MaidService.registerHost(_data);
    if (res['isValid']) {
      setState(() {
        _data.fromJson(res['maid']);
      });
      Utils.showSuccessSnackbar(
        context,
        AppLocalizations.of(context).tr('update_profile_successfully'),
      );
    } else {
      Utils.showErrorSnackbar(context);
    }
  }

  void editHostInfo() async {
    final res = await MaidService.editHostInfo(_data);
    if (res['isValid']) {
      setState(() {
        _data.fromJson(res['maid']);
      });
      Utils.showSuccessSnackbar(
        context,
        AppLocalizations.of(context).tr('update_profile_successfully'),
      );
    } else {
      Utils.showErrorSnackbar(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<User>(context, listen: false);
    final services = categoriesData;
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
        body: loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : GestureDetector(
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
                                        child: UserAvatar(userProvider.avatar),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 15),
                                        child: Text(
                                          userProvider.name != null
                                              ? userProvider.name
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
                                          userProvider.email != null
                                              ? userProvider.email
                                              : '',
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
                                  margin: EdgeInsets.only(
                                      top: ScreenUtil.instance.setHeight(20.0)),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 15),
                                  color: Colors.white,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          FormLabel(
                                            AppLocalizations.of(context)
                                                .tr('introduction'),
                                          ),
                                          TextFormField(
                                            validator: (String value) {
                                              if (value.isEmpty) {
                                                return AppLocalizations.of(
                                                        context)
                                                    .tr('intro_required');
                                              }
                                              return null;
                                            },
                                            controller: _introController,
                                            style: TextStyle(
                                              fontSize: ScreenUtil.instance
                                                  .setSp(12.0),
                                              color: Colors.black,
                                            ),
                                            decoration: InputDecoration(
                                              hintText:
                                                  AppLocalizations.of(context)
                                                      .tr('introduction_hint'),
                                              hintStyle: TextStyle(),
                                              enabledBorder: InputBorder.none,
                                              contentPadding: EdgeInsets.only(
                                                  top: ScreenUtil.instance
                                                      .setHeight(10),
                                                  bottom: ScreenUtil.instance
                                                      .setHeight(10)),
                                            ),
                                            onSaved: (String value) {
                                              _data.intro = value;
                                            },
                                          ),
                                          SizedBox(
                                            height: ScreenUtil.instance
                                                .setHeight(20),
                                          ),
                                        ],
                                      ),
                                      FormDropdown(
                                        value: _data.literacyType,
                                        label: AppLocalizations.of(context)
                                            .tr('literacy'),
                                        values: [
                                          FormSelectItem(
                                            label: AppLocalizations.of(context)
                                                .tr('literacy_choice_1'),
                                            value: Utils.literacyToInt(
                                                LITERACY_TYPE.other),
                                          ),
                                          FormSelectItem(
                                            label: AppLocalizations.of(context)
                                                .tr('literacy_choice_2'),
                                            value: Utils.literacyToInt(
                                                LITERACY_TYPE.highschool),
                                          ),
                                          FormSelectItem(
                                            label: AppLocalizations.of(context)
                                                .tr('literacy_choice_3'),
                                            value: Utils.literacyToInt(
                                                LITERACY_TYPE.university),
                                          ),
                                          FormSelectItem(
                                            label: AppLocalizations.of(context)
                                                .tr('literacy_choice_4'),
                                            value: Utils.literacyToInt(
                                                LITERACY_TYPE.college),
                                          ),
                                          FormSelectItem(
                                            label: AppLocalizations.of(context)
                                                .tr('literacy_choice_5'),
                                            value: Utils.literacyToInt(
                                                LITERACY_TYPE.post_graduate),
                                          ),
                                        ],
                                        hasNext: true,
                                        handleOnChange: _handleChangeLiteracy,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          FormLabel(
                                            AppLocalizations.of(context)
                                                .tr('experience'),
                                          ),
                                          TextFormField(
                                            maxLines: 4,
                                            minLines: 4,
                                            validator: (String value) {
                                              if (value.isEmpty) {
                                                return AppLocalizations.of(
                                                        context)
                                                    .tr('exp_required');
                                              }
                                              if (value.length < 50) {
                                                return AppLocalizations.of(
                                                        context)
                                                    .tr('min_50_characters');
                                              }
                                              return null;
                                            },
                                            controller: _expController,
                                            style: TextStyle(
                                              fontSize: ScreenUtil.instance
                                                  .setSp(12.0),
                                              color: Colors.black,
                                            ),
                                            decoration: InputDecoration(
                                              hintText:
                                                  AppLocalizations.of(context)
                                                      .tr('experience_hint'),
                                              hintStyle: TextStyle(),
                                              enabledBorder: InputBorder.none,
                                              contentPadding: EdgeInsets.only(
                                                  top: ScreenUtil.instance
                                                      .setHeight(10),
                                                  bottom: ScreenUtil.instance
                                                      .setHeight(10)),
                                            ),
                                            onSaved: (String value) {
                                              _data.exp = value;
                                            },
                                          ),
                                        ],
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      FormDropdown(
                                        value: _data.salaryType,
                                        label: AppLocalizations.of(context)
                                            .tr('salary'),
                                        values: [
                                          FormSelectItem(
                                            value: Utils.salaryToInt(
                                                SALARY_TYPE.less_one),
                                            label: AppLocalizations.of(context)
                                                .tr('salary_choice_1'),
                                          ),
                                          FormSelectItem(
                                            value: Utils.salaryToInt(
                                                SALARY_TYPE.one_to_three),
                                            label: AppLocalizations.of(context)
                                                .tr('salary_choice_2'),
                                          ),
                                          FormSelectItem(
                                            value: Utils.salaryToInt(
                                                SALARY_TYPE.three_to_five),
                                            label: AppLocalizations.of(context)
                                                .tr('salary_choice_3'),
                                          ),
                                          FormSelectItem(
                                            value: Utils.salaryToInt(
                                                SALARY_TYPE.five_to_seven),
                                            label: AppLocalizations.of(context)
                                                .tr('salary_choice_4'),
                                          ),
                                          FormSelectItem(
                                            value: Utils.salaryToInt(
                                                SALARY_TYPE.more_seven),
                                            label: AppLocalizations.of(context)
                                                .tr('salary_choice_5'),
                                          ),
                                        ],
                                        hasNext: true,
                                        handleOnChange: _handleChangeSalary,
                                      ),
                                      FormMultiChoice(
                                        selectedValues: _data.jobTypes,
                                        label: AppLocalizations.of(context)
                                            .tr('work'),
                                        hint: AppLocalizations.of(context)
                                            .tr('work_hint'),
                                        values: services.map((item) {
                                          return FormSelectItem(
                                            label: AppLocalizations.of(context)
                                                .tr(item.serviceName),
                                            value: item.id,
                                          );
                                        }).toList(),
                                        hasNext: true,
                                        onChangeHandler: _handleChangeJob,
                                      ),
                                      FormMultiChoice(
                                        selectedValues: _data.supportAreas,
                                        label: AppLocalizations.of(context)
                                            .tr('support_area'),
                                        hint: AppLocalizations.of(context)
                                            .tr('support_area'),
                                        values: <FormSelectItem>[
                                          FormSelectItem(
                                            label: AppLocalizations.of(context)
                                                .tr('support_area_choice_1'),
                                            value: Utils.getSupportAreaCode(
                                                SUPPURT_AREA.district_1),
                                          ),
                                          FormSelectItem(
                                            label: AppLocalizations.of(context)
                                                .tr('support_area_choice_2'),
                                            value: Utils.getSupportAreaCode(
                                                SUPPURT_AREA.district_2),
                                          ),
                                          FormSelectItem(
                                            label: AppLocalizations.of(context)
                                                .tr('support_area_choice_3'),
                                            value: Utils.getSupportAreaCode(
                                                SUPPURT_AREA.district_3),
                                          ),
                                          FormSelectItem(
                                            label: AppLocalizations.of(context)
                                                .tr('support_area_choice_4'),
                                            value: Utils.getSupportAreaCode(
                                                SUPPURT_AREA.district_4),
                                          ),
                                          FormSelectItem(
                                            label: AppLocalizations.of(context)
                                                .tr('support_area_choice_5'),
                                            value: Utils.getSupportAreaCode(
                                                SUPPURT_AREA.district_5),
                                          ),
                                          FormSelectItem(
                                            label: AppLocalizations.of(context)
                                                .tr('support_area_choice_6'),
                                            value: Utils.getSupportAreaCode(
                                                SUPPURT_AREA.district_6),
                                          ),
                                          FormSelectItem(
                                            label: AppLocalizations.of(context)
                                                .tr('support_area_choice_7'),
                                            value: Utils.getSupportAreaCode(
                                                SUPPURT_AREA.district_7),
                                          ),
                                          FormSelectItem(
                                            label: AppLocalizations.of(context)
                                                .tr('support_area_choice_8'),
                                            value: Utils.getSupportAreaCode(
                                                SUPPURT_AREA.district_8),
                                          ),
                                          FormSelectItem(
                                            label: AppLocalizations.of(context)
                                                .tr('support_area_choice_9'),
                                            value: Utils.getSupportAreaCode(
                                                SUPPURT_AREA.district_9),
                                          ),
                                          FormSelectItem(
                                            label: AppLocalizations.of(context)
                                                .tr('support_area_choice_10'),
                                            value: Utils.getSupportAreaCode(
                                                SUPPURT_AREA.district_10),
                                          ),
                                          FormSelectItem(
                                            label: AppLocalizations.of(context)
                                                .tr('support_area_choice_11'),
                                            value: Utils.getSupportAreaCode(
                                                SUPPURT_AREA.district_11),
                                          ),
                                          FormSelectItem(
                                            label: AppLocalizations.of(context)
                                                .tr('support_area_choice_12'),
                                            value: Utils.getSupportAreaCode(
                                                SUPPURT_AREA.district_12),
                                          ),
                                          FormSelectItem(
                                            label: AppLocalizations.of(context)
                                                .tr('support_area_choice_13'),
                                            value: Utils.getSupportAreaCode(
                                                SUPPURT_AREA
                                                    .district_binh_thanh),
                                          ),
                                          FormSelectItem(
                                            label: AppLocalizations.of(context)
                                                .tr('support_area_choice_14'),
                                            value: Utils.getSupportAreaCode(
                                                SUPPURT_AREA.district_go_vap),
                                          ),
                                          FormSelectItem(
                                            label: AppLocalizations.of(context)
                                                .tr('support_area_choice_15'),
                                            value: Utils.getSupportAreaCode(
                                                SUPPURT_AREA
                                                    .district_phu_nhuan),
                                          ),
                                          FormSelectItem(
                                            label: AppLocalizations.of(context)
                                                .tr('support_area_choice_16'),
                                            value: Utils.getSupportAreaCode(
                                                SUPPURT_AREA.district_tan_binh),
                                          ),
                                          FormSelectItem(
                                            label: AppLocalizations.of(context)
                                                .tr('support_area_choice_17'),
                                            value: Utils.getSupportAreaCode(
                                                SUPPURT_AREA.district_thu_duc),
                                          ),
                                          FormSelectItem(
                                            label: AppLocalizations.of(context)
                                                .tr('support_area_choice_18'),
                                            value: Utils.getSupportAreaCode(
                                                SUPPURT_AREA
                                                    .district_binh_chanh),
                                          ),
                                          FormSelectItem(
                                            label: AppLocalizations.of(context)
                                                .tr('support_area_choice_19'),
                                            value: Utils.getSupportAreaCode(
                                                SUPPURT_AREA.district_can_gio),
                                          ),
                                          FormSelectItem(
                                            label: AppLocalizations.of(context)
                                                .tr('support_area_choice_20'),
                                            value: Utils.getSupportAreaCode(
                                                SUPPURT_AREA.district_cu_chi),
                                          ),
                                          FormSelectItem(
                                            label: AppLocalizations.of(context)
                                                .tr('support_area_choice_21'),
                                            value: Utils.getSupportAreaCode(
                                                SUPPURT_AREA.district_hooc_mon),
                                          ),
                                          FormSelectItem(
                                            label: AppLocalizations.of(context)
                                                .tr('support_area_choice_22'),
                                            value: Utils.getSupportAreaCode(
                                                SUPPURT_AREA.district_nha_be),
                                          ),
                                        ],
                                        onChangeHandler: _handleChangeArea,
                                      ),
                                    ],
                                  ),
                                ),
                                isHost
                                    ? Container()
                                    : Container(
                                        width: double.infinity,
                                        margin: EdgeInsets.only(
                                          top:
                                              ScreenUtil.instance.setHeight(20),
                                        ),
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
        bottomNavigationBar: loading
            ? null
            : Container(
                color: Theme.of(context).primaryColor,
                padding: EdgeInsets.all(ScreenUtil.instance.setWidth(12.0)),
                child: InkWell(
                  onTap: _onSubmit,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        isHost
                            ? AppLocalizations.of(context)
                                .tr('update')
                                .toUpperCase()
                            : AppLocalizations.of(context)
                                .tr('register')
                                .toUpperCase(),
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
