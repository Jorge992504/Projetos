// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ClientTimelineItem {
  final String title;
  final String description;
  final String date;
  final bool active;
  ClientTimelineItem({
    required this.title,
    required this.description,
    required this.date,
    required this.active,
  });

  ClientTimelineItem copyWith({
    String? title,
    String? description,
    String? date,
    bool? active,
  }) {
    return ClientTimelineItem(
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      active: active ?? this.active,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'date': date,
      'active': active,
    };
  }

  factory ClientTimelineItem.fromMap(Map<String, dynamic> map) {
    return ClientTimelineItem(
      title: map['title'] ?? "",
      description: map['description'] ?? "",
      date: map['date'] ?? "",
      active: map['active'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory ClientTimelineItem.fromJson(String source) =>
      ClientTimelineItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ClientTimelineItem(title: $title, description: $description, date: $date, active: $active)';
  }

  @override
  bool operator ==(covariant ClientTimelineItem other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.description == description &&
        other.date == date &&
        other.active == active;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        description.hashCode ^
        date.hashCode ^
        active.hashCode;
  }
}
