import 'package:flutter/material.dart';

import '../service_category/service_category_list.dart';

class ServiceCategoryTab extends StatefulWidget {
  @override
  _ServiceCategoryTabState createState() => _ServiceCategoryTabState();
}

class _ServiceCategoryTabState extends State<ServiceCategoryTab> {
  @override
  Widget build(BuildContext context) {
    return ServiceCategoryList();
  }
}