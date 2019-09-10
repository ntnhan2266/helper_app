import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import './service_category_item.dart';
import '../../utils/dummy_data.dart';

class ServiceCategoryList extends StatefulWidget {
  @override
  _ServiceCategoryListState createState() => _ServiceCategoryListState();
}

class _ServiceCategoryListState extends State<ServiceCategoryList> {
  var categories = categoriesData;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      
      padding: EdgeInsets.all(ScreenUtil.instance.setWidth(10),),
      itemCount: categories.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: ScreenUtil.instance.setWidth(10),
        mainAxisSpacing: ScreenUtil.instance.setWidth(10),
      ),
      itemBuilder: (BuildContext context, int index) {
        final item = categories[index];
        return ServiceCategoryItem(id: item.id, imgURL: item.imgURL, serviceName: item.serviceName,);
      }
    );
  }
}