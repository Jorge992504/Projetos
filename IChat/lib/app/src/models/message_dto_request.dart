// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MessageDtoRequest {
  String? userReceiver;
  String? message;
  bool? isPick;
  MessageDtoRequest({this.userReceiver, this.message, this.isPick});

  MessageDtoRequest copyWith({
    String? userReceiver,
    String? message,
    bool? isPick,
  }) {
    return MessageDtoRequest(
      userReceiver: userReceiver ?? this.userReceiver,
      message: message ?? this.message,
      isPick: isPick ?? this.isPick,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userReceiver': userReceiver,
      'message': message,
      'isPick': isPick,
    };
  }

  factory MessageDtoRequest.fromMap(Map<String, dynamic> map) {
    return MessageDtoRequest(
      userReceiver: map['userReceiver'] ?? "",
      message: map['message'] ?? "",
      isPick: map['isPick'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageDtoRequest.fromJson(String source) =>
      MessageDtoRequest.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'MessageDtoRequest(userReceiver: $userReceiver, message: $message, isPick; $isPick)';

  @override
  bool operator ==(covariant MessageDtoRequest other) {
    if (identical(this, other)) return true;

    return other.userReceiver == userReceiver &&
        other.message == message &&
        other.isPick == isPick;
  }

  @override
  int get hashCode =>
      userReceiver.hashCode ^ message.hashCode ^ isPick.hashCode;
}
