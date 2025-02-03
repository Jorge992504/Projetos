// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MessageModel {
  final int senderId;
  final int receiverId;
  final String text;

  MessageModel({
    required this.senderId,
    required this.receiverId,
    required this.text,
  });

  MessageModel copyWith({
    int? senderId,
    int? receiverId,
    String? text,
  }) {
    return MessageModel(
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      text: text ?? this.text,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'senderId': senderId,
      'receiverId': receiverId,
      'text': text,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      senderId: map['senderId'] as int,
      receiverId: map['receiverId'] as int,
      text: map['text'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) =>
      MessageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'MessageModel(senderId: $senderId, receiverId: $receiverId, text: $text)';

  @override
  bool operator ==(covariant MessageModel other) {
    if (identical(this, other)) return true;

    return other.senderId == senderId &&
        other.receiverId == receiverId &&
        other.text == text;
  }

  @override
  int get hashCode => senderId.hashCode ^ receiverId.hashCode ^ text.hashCode;
}
