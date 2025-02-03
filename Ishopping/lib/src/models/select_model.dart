// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SelectModel {
  final int id;
  final String name;
  final String photo;
  SelectModel({
    required this.id,
    required this.name,
    required this.photo,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'photo': photo,
    };
  }

  factory SelectModel.fromMap(Map<String, dynamic> map) {
    return SelectModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name']?.toString() ?? '',
      photo: map['photo']?.toString() ?? '',
    );
  }

  String toJson() => json.encode(toMap());
  factory SelectModel.fromJson(String source) =>
      SelectModel.fromMap(json.decode(source));
}
