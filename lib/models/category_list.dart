import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import './category.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()

class CategoryList with ChangeNotifier {
  List<Category> categories;

  CategoryList({this.categories});

  void getDate(List<Category> categories) {
    this.categories = categories;
    notifyListeners();
  }
}
