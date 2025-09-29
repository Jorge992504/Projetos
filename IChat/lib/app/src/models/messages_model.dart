// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MessagesModel {
  int? id;
  String? userFrom;
  String? userTo;
  String? message;
  DateTime? sentAt;
  MessagesModel({
    this.userFrom,
    this.userTo,
    this.message,
    this.sentAt,
    this.id,
  });

  MessagesModel copyWith({
    String? userFrom,
    String? userTo,
    String? message,
    DateTime? sentAt,
    int? id,
  }) {
    return MessagesModel(
      userFrom: userFrom ?? this.userFrom,
      userTo: userTo ?? this.userTo,
      message: message ?? this.message,
      sentAt: sentAt ?? this.sentAt,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userFrom': userFrom,
      'userTo': userTo,
      'message': message,
      'sentAt': sentAt?.millisecondsSinceEpoch,
      'id': id,
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
    );
  }

  String toJson() => json.encode(toMap());

  factory MessagesModel.fromJson(String source) =>
      MessagesModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MessagesModel(userFrom: $userFrom, userTo: $userTo, message: $message, sentAt: $sentAt, id: $id)';
  }

  @override
  bool operator ==(covariant MessagesModel other) {
    if (identical(this, other)) return true;

    return other.userFrom == userFrom &&
        other.userTo == userTo &&
        other.message == message &&
        other.sentAt == sentAt &&
        other.id == id;
  }

  @override
  int get hashCode {
    return userFrom.hashCode ^
        userTo.hashCode ^
        message.hashCode ^
        sentAt.hashCode ^
        id.hashCode;
  }
}
