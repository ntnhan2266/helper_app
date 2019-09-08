import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/service_category.dart';
import './service_category_item.dart';

class ServiceCategoryList extends StatefulWidget {
  @override
  _ServiceCategoryListState createState() => _ServiceCategoryListState();
}

class _ServiceCategoryListState extends State<ServiceCategoryList> {
  var categories = [
    ServiceCategory(imgURL: 'easy.png', serviceName: 'Test'),
    ServiceCategory(imgURL: 'easy.png', serviceName: 'Test'),
    ServiceCategory(imgURL: 'easy.png', serviceName: 'Test'),
    ServiceCategory(imgURL: 'easy.png', serviceName: 'Test'),
    ServiceCategory(imgURL: 'easy.png', serviceName: 'Test'),
    ServiceCategory(imgURL: 'easy.png', serviceName: 'Test'),
    ServiceCategory(imgURL: 'easy.png', serviceName: 'Test'),
    ServiceCategory(imgURL: 'easy.png', serviceName: 'Test'),
    ServiceCategory(imgURL: 'easy.png', serviceName: 'Test'),
    ServiceCategory(imgURL: 'easy.png', serviceName: 'Test'),
  ];

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
        return ServiceCategoryItem(imgURL: item.imgURL, serviceName: item.serviceName + ' $index',);
      }
    );
  }
}