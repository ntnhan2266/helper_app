import '../models/user.dart';
import '../models/service_details.dart';
import '../models/user_maid.dart';

class MaidReview {
  String id;
  ServiceDetails booking;
  double ratting;
  String content;
  int helpful;
  User createdBy;
  UserMaid maid;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime deletedAt;

  MaidReview({
    this.id,
    this.booking,
    this.ratting,
    this.content,
    this.helpful,
    this.createdBy,
    this.maid,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'ratting': ratting,
      'content': content,
      'booking': booking.id,
      'maid': maid.id,
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
      maid: json['maid'] != null ? UserMaid.fromJson(json['createdBy']) : null,
    );
  }
}
