import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import './service_category_item.dart';
import '../../models/category_list.dart';

class ServiceCategoryList extends StatefulWidget {
  @override
  _ServiceCategoryListState createState() => _ServiceCategoryListState();
}

class _ServiceCategoryListState extends State<ServiceCategoryList> {
  @override
  Widget build(BuildContext context) {
    final categoryListProvider =
        Provider.of<CategoryList>(context, listen: false);
    final categoriesData = categoryListProvider.categories;
    var categories = categoriesData;
    return GridView.builder(
        padding: EdgeInsets.all(
          ScreenUtil.instance.setWidth(10),
        ),
        itemCount: categories.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: ScreenUtil.instance.setWidth(10),
          mainAxisSpacing: ScreenUtil.instance.setWidth(10),
        ),
        itemBuilder: (BuildContext context, int index) {
          final item = categories[index];
          return ServiceCategoryItem(
            id: item.id,
            imgURL: item.icon,
            serviceName: Localizations.localeOf(context).languageCode == "en"
                ? item.nameEn
                : item.nameVi,
          );
        });
  }
}
