// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DbLite {
  final int? id;
  final String? text;
  DbLite({
    this.id,
    this.text,
  });

  DbLite copyWith({
    int? id,
    String? text,
  }) {
    return DbLite(
      id: id ?? this.id,
      text: text ?? this.text,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'text': text,
    };
  }

  factory DbLite.fromMap(Map<String, dynamic> map) {
    return DbLite(
      id: map['id'] != null ? map['id'] as int : null,
      text: map['text'] != null ? map['text'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DbLite.fromJson(String source) =>
      DbLite.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'DbLite(id: $id, text: $text)';

  @override
  bool operator ==(covariant DbLite other) {
    if (identical(this, other)) return true;

    return other.id == id && other.text == text;
  }

  @override
  int get hashCode => id.hashCode ^ text.hashCode;
}
