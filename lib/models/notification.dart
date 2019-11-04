import '../models/service_details.dart';

class Notification {
  String id;
  String message;
  DateTime createdAt;
  ServiceDetails service;
  String fromUser;
  bool isRead;

  Notification({
    this.id,
    this.message,
    this.createdAt,
    this.service,
    this.fromUser,
    this.isRead = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
      'createdAt': createdAt.toString(),
      'service': service.id,
      'fromUser': fromUser,
      'isRead': isRead,
    };
  }

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      id: json['_id'],
      message: json['message'],
      createdAt: DateTime.parse(json['createdAt']).toLocal(),
      service: json['booking'] != null
          ? ServiceDetails.fromJson(json['booking'])
          : null,
      fromUser: json['fromUser'],
      isRead: json['isRead'],
    );
  }
}
