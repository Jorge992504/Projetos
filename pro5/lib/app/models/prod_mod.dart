import 'dart:convert';

//mapear para achar os produtos na BD
class ProdMod {
  final int id;
  final String name;
  final String description;
  final double price;
  final String image;
  ProdMod({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': name,
      'descricao': description,
      'preco': price,
      'fot': image,
    };
  }

  factory ProdMod.fromMap(Map<String, dynamic> map) {
    return ProdMod(
      id: map['id']?.toInt() ?? 0,
      name: map['nome']?.toString() ?? '',
      description: map['descricao']?.toString() ?? '',
      price: double.parse(map['preco']),
      image: map['foto']?.toString() ?? '',
    );
  }

  String toJson() => json.encode(toMap());
  factory ProdMod.fromJson(String source) =>
      ProdMod.fromMap(json.decode(source));
}
