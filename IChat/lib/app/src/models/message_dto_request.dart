// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MessageDtoRequest {
  String? userReceiver;
  String? message;
  MessageDtoRequest({this.userReceiver, this.message});

  MessageDtoRequest copyWith({String? userReceiver, String? message}) {
    return MessageDtoRequest(
      userReceiver: userReceiver ?? this.userReceiver,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'userReceiver': userReceiver, 'message': message};
  }

  factory MessageDtoRequest.fromMap(Map<String, dynamic> map) {
    return MessageDtoRequest(
      userReceiver: map['userReceiver'] ?? "",
      message: map['message'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageDtoRequest.fromJson(String source) =>
      MessageDtoRequest.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'MessageDtoRequest(userReceiver: $userReceiver, message: $message)';

  @override
  bool operator ==(covariant MessageDtoRequest other) {
    if (identical(this, other)) return true;

    return other.userReceiver == userReceiver && other.message == message;
  }

  @override
  int get hashCode => userReceiver.hashCode ^ message.hashCode;
}
