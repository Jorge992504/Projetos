// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MessagesOfUserModel {
  String? userFrom;
  String? message;
  MessagesOfUserModel({this.userFrom, this.message});

  MessagesOfUserModel copyWith({String? userFrom, String? message}) {
    return MessagesOfUserModel(
      userFrom: userFrom ?? this.userFrom,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'userFrom': userFrom, 'message': message};
  }

  factory MessagesOfUserModel.fromMap(Map<String, dynamic> map) {
    return MessagesOfUserModel(
      userFrom: map['userFrom'] ?? "",
      message: map['message'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory MessagesOfUserModel.fromJson(String source) =>
      MessagesOfUserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'MessagesOfUserModel(userFrom: $userFrom, message: $message)';

  @override
  bool operator ==(covariant MessagesOfUserModel other) {
    if (identical(this, other)) return true;

    return other.userFrom == userFrom && other.message == message;
  }

  @override
  int get hashCode => userFrom.hashCode ^ message.hashCode;
}
