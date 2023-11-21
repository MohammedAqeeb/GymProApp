import 'package:equatable/equatable.dart';

class Exercises extends Equatable {
  final String? title;
  final int? prelude, duration;
  final int? index, startTime;

  const Exercises({
    required this.title,
    required this.prelude,
    required this.duration,
    this.index,
    this.startTime,
  });

  factory Exercises.fromJson(
          Map<String, dynamic> json, int index, int startTime) =>
      Exercises(
        title: json["title"],
        prelude: json["prelude"],
        duration: json["duration"],
        index: index,
        startTime: startTime,
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "prelude": prelude,
        "duration": duration,
      };

  @override
  List<Object?> get props => [title, prelude, duration, index, startTime];

  @override
  bool get stringify => true;
}
