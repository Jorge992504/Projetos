import 'dart:convert';

class ProductsModel {
  final int id;
  final String name;
  final String photo;
  ProductsModel({
    required this.id,
    required this.name,
    required this.photo,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'foto': photo,
    };
  }

  factory ProductsModel.fromMap(Map<String, dynamic> map) {
    return ProductsModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name']?.toString() ?? '',
      photo: map['foto']?.toString() ?? '',
    );
  }

  String toJson() => json.encode(toMap());
  factory ProductsModel.fromJson(String source) =>
      ProductsModel.fromMap(json.decode(source));
}
