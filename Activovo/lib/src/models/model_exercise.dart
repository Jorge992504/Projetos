// ignore_for_file: public_member_api_docs, sort_constructors_first
class ModelExercise {
  final int id;
  final String name;
  final String description;
  final int series;
  final int repetitions;
  final String video;

  ModelExercise({
    required this.id,
    required this.description,
    required this.repetitions,
    required this.name,
    required this.series,
    required this.video,
  });

  factory ModelExercise.fromMap(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'name': String name,
        'description': String description,
        'series': int series,
        'repetitions': int repetitions,
        'video': String video,
      } =>
        ModelExercise(
          id: id,
          name: name,
          description: description,
          series: series,
          repetitions: repetitions,
          video: video,
        ),
      _ => throw ArgumentError('Invalid Json'),
    };
  }
}
