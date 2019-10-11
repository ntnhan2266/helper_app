import '../models/user.dart';

class MaidReview {
  String id;
  double ratting;
  String content;
  User createdBy;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime deletedAt;

  MaidReview({
    this.id,
    this.ratting,
    this.content,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ratting': ratting,
      'content': content,
      'createdBy': createdBy.id,
      'createdAt': createdAt.toString(),
      'updatedAt': updatedAt.toString(),
      'deletedAt': deletedAt.toString(),
    };
  }

  factory MaidReview.fromJson(Map<String, dynamic> json) {
    return MaidReview(
      id: json['_id'],
      ratting: json['ratting'],
      content: json['content'],
      createdBy:
          json['createdBy'] != null ? User().getData(json['createdBy']) : null,
      createdAt: DateTime.parse(json['createdAt']).toLocal(),
      updatedAt: DateTime.parse(json['updatedAt']).toLocal(),
      deletedAt: DateTime.parse(json['deletedAt']).toLocal(),
    );
  }

  static MaidReview getData(Map<String, dynamic> json) {
    return MaidReview(
      id: json['_id'],
      ratting: json['ratting'],
      content: json['content'],
      createdBy:
          json['createdBy'] != null ? User().getData(json['createdBy']) : null,
      createdAt: DateTime.parse(json['createdAt']).toLocal(),
      updatedAt: DateTime.parse(json['updatedAt']).toLocal(),
      deletedAt: DateTime.parse(json['deletedAt']).toLocal(),
    );
  }
}
