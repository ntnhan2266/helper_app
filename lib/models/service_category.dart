import 'package:flutter/foundation.dart';

class ServiceCategory {
  final int id;
  final String imgURL;
  final String serviceName;

  ServiceCategory({
    @required this.id, 
    this.imgURL, 
    this.serviceName
  });
}