import '../models/service_details.dart';

class Notification {
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  ServiceDetails service;
  bool isRead;

  Notification({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.service,
    this.isRead = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt.toString(),
      'updatedAt': updatedAt.toString(),
      'service': service.id,
      'isRead': isRead,
    };
  }

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      id: json['_id'],
      createdAt: DateTime.parse(json['createdAt']).toLocal(),
      updatedAt: DateTime.parse(json['updatedAt']).toLocal(),
      service: json['booking'] != null
          ? ServiceDetails.fromJson(json['booking'])
          : null,
      isRead: json['isRead'],
    );
  }
}
