import 'package:json_annotation/json_annotation.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class Category {
  String id;
  String icon;
  String nameVi;
  String nameEn;

  Category({
    this.id,
    this.icon,
    this.nameVi,
    this.nameEn,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'],
      icon: json['icon'],
      nameVi: json['nameVi'],
      nameEn: json['nameEn'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'icon': icon,
      'nameVi': nameVi,
      'nameEn': nameEn,
    };
  }
}
