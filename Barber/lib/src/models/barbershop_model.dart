// ignore_for_file: public_member_api_docs, sort_constructors_first
class BarbershopModel {
  final int id;
  final String name;
  final String email;
  final String openingDays;
  final int openingHours;
  BarbershopModel({
    required this.id,
    required this.name,
    required this.email,
    required this.openingDays,
    required this.openingHours,
  });

  factory BarbershopModel.fromMap(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'name': String name,
        'email': String email,
        'opening_dyas': String openingDays,
        'opening_hours': int openingHours,
      } =>
        BarbershopModel(
          id: id,
          name: name,
          email: email,
          openingDays: openingDays,
          openingHours: openingHours,
        ),
      _ => throw ArgumentError('Invalid Json'),
    };
  }
}
