import 'dart:convert';

class ModelDisease {
  final int id;
  final String name;
  final String description;
  ModelDisease({
    required this.id,
    required this.name,
    required this.description,
  });

  // factory ModelDisease.fromMap(Map<String, dynamic> json) {
  //   return switch (json) {
  //     {
  //       'id': int id,
  //       'name': String name,
  //       'description': String description,
  //     } =>
  //       ModelDisease(
  //         id: id,
  //         name: name,
  //         description: description,
  //       ),
  //     _ => throw ArgumentError('Invalid Json'),
  //   };
  // }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }

  factory ModelDisease.fromMap(Map<String, dynamic> map) {
    return ModelDisease(
      id: map['id']?.toInt() ?? 0,
      name: map['name']?.toString() ?? '',
      description: map['description']?.toString() ?? '',
    );
  }

  String toJson() => json.encode(toMap());
  factory ModelDisease.fromJson(String source) =>
      ModelDisease.fromMap(json.decode(source));
}
