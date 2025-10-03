// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PathMessageModelRequest {
  String? path;
  PathMessageModelRequest({this.path});

  PathMessageModelRequest copyWith({String? path}) {
    return PathMessageModelRequest(path: path ?? this.path);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'path': path};
  }

  factory PathMessageModelRequest.fromMap(Map<String, dynamic> map) {
    return PathMessageModelRequest(path: map['path'] ?? "");
  }

  String toJson() => json.encode(toMap());

  factory PathMessageModelRequest.fromJson(String source) =>
      PathMessageModelRequest.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  String toString() => 'PathMessageModelRequest(path: $path)';

  @override
  bool operator ==(covariant PathMessageModelRequest other) {
    if (identical(this, other)) return true;

    return other.path == path;
  }

  @override
  int get hashCode => path.hashCode;
}
