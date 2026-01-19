// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MessageModel {
  int? id;
  int? usuarioFrom;
  int? usuarioTo;
  String? message;
  String? foto;
  DateTime? dataTime;
  bool? isMe;
  MessageModel({
    this.id,
    this.usuarioFrom,
    this.usuarioTo,
    this.message,
    this.foto,
    this.dataTime,
    this.isMe,
  });

  MessageModel copyWith({
    int? id,
    int? usuarioFrom,
    int? usuarioTo,
    String? message,
    String? foto,
    DateTime? dataTime,
    bool? isMe,
  }) {
    return MessageModel(
      id: id ?? this.id,
      usuarioFrom: usuarioFrom ?? this.usuarioFrom,
      usuarioTo: usuarioTo ?? this.usuarioTo,
      message: message ?? this.message,
      foto: foto ?? this.foto,
      dataTime: dataTime ?? this.dataTime,
      isMe: isMe ?? this.isMe,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'usuarioFrom': usuarioFrom,
      'usuarioTo': usuarioTo,
      'message': message,
      'foto': foto,
      'dataTime': dataTime != null
          ? '${dataTime!.year.toString().padLeft(4, '0')}-'
                '${dataTime!.month.toString().padLeft(2, '0')}-'
                '${dataTime!.day.toString().padLeft(2, '0')}'
          : null,
      'isMe': isMe,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map['id'] != null ? map['id'] as int : null,
      usuarioFrom: map['usuarioFrom'] != null
          ? map['usuarioFrom'] as int
          : null,
      usuarioTo: map['usuarioTo'] != null ? map['usuarioTo'] as int : null,
      message: map['message'] != null ? map['message'] as String : null,
      foto: map['foto'] != null ? map['foto'] as String : null,
      dataTime: map['dataTime'] != null
          ? DateTime.parse(map['dataTime'] as String)
          : null,
      isMe: map['isMe'] != null ? map['isMe'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) =>
      MessageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MessageModel(id: $id, usuarioFrom: $usuarioFrom, usuarioTo: $usuarioTo, message: $message, foto: $foto, dataTime: $dataTime, isMe: $isMe)';
  }

  @override
  bool operator ==(covariant MessageModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.usuarioFrom == usuarioFrom &&
        other.usuarioTo == usuarioTo &&
        other.message == message &&
        other.foto == foto &&
        other.dataTime == dataTime &&
        other.isMe == isMe;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        usuarioFrom.hashCode ^
        usuarioTo.hashCode ^
        message.hashCode ^
        foto.hashCode ^
        dataTime.hashCode ^
        isMe.hashCode;
  }
}
