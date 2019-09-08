import 'package:flutter/material.dart';

class ServiceCategoryItem extends StatelessWidget {
  final String imgURL;
  final String serviceName;

  const ServiceCategoryItem({this.serviceName, this.imgURL});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: new Card(
        elevation: 5.0,
        child: new Container(
          alignment: Alignment.center,
          child: new Text(serviceName),
        ),
      ),
    );
  }
}