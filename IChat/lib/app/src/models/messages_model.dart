// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:image_picker/image_picker.dart';

class MessagesModel {
  int? id;
  String? userFrom;
  String? userTo;
  String? message;
  DateTime? sentAt;
  bool? isPick;
  XFile? image;
  MessagesModel({
    this.userFrom,
    this.userTo,
    this.message,
    this.sentAt,
    this.id,
    this.isPick,
    this.image,
  });

  MessagesModel copyWith({
    String? userFrom,
    String? userTo,
    String? message,
    DateTime? sentAt,
    int? id,
    bool? isPick,
    XFile? image,
  }) {
    return MessagesModel(
      userFrom: userFrom ?? this.userFrom,
      userTo: userTo ?? this.userTo,
      message: message ?? this.message,
      sentAt: sentAt ?? this.sentAt,
      id: id ?? this.id,
      isPick: isPick ?? this.isPick,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userFrom': userFrom,
      'userTo': userTo,
      'message': message,
      'sentAt': sentAt?.millisecondsSinceEpoch,
      'id': id,
      'isPick': isPick,
      'image': image,
    };
  }

  factory MessagesModel.fromMap(Map<String, dynamic> map) {
    return MessagesModel(
      userFrom: map['userFrom'] ?? "",
      userTo: map['userTo'] ?? "",
      message: map['message'] ?? "",
      sentAt: map['sentAt'] != null
          ? DateTime.parse(map['sentAt'])
          : DateTime.now(),
      id: map['id'] ?? 0,
      isPick: map['isPick'] ?? false,
      image: map['image'] != null ? XFile(map['image']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MessagesModel.fromJson(String source) =>
      MessagesModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MessagesModel(userFrom: $userFrom, userTo: $userTo, message: $message, sentAt: $sentAt, id: $id,isPick: $isPick, image: $image)';
  }

  @override
  bool operator ==(covariant MessagesModel other) {
    if (identical(this, other)) return true;

    return other.userFrom == userFrom &&
        other.userTo == userTo &&
        other.message == message &&
        other.sentAt == sentAt &&
        other.id == id &&
        other.isPick == isPick &&
        other.image == image;
  }

  @override
  int get hashCode {
    return userFrom.hashCode ^
        userTo.hashCode ^
        message.hashCode ^
        sentAt.hashCode ^
        id.hashCode ^
        isPick.hashCode ^
        image.hashCode;
  }
}
