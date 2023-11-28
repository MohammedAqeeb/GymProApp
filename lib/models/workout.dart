import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_app_complete/models/exercise.dart';

class Workout extends Equatable {
  final String? title;

  final List<Exercises> exercise;

  const Workout({
    required this.title,
    required this.exercise,
  });

  factory Workout.fromJson(Map<String, dynamic> json) {
    List<Exercises> exercise = [];
    int index = 0;
    int startTime = 0;

    for (var ex in (json['exercises'] as Iterable)) {
      exercise.add(Exercises.fromJson(ex, index, startTime));
      index++;
      print('--$index--');
      startTime += exercise.last.prelude! + exercise.last.duration!;
    }

    return Workout(
      title: json['title'] as String?,
      exercise: exercise,
    );
  }

  int getTotalTime() {
    int totalTime = exercise.fold(
      0,
      (previousValue, getExercise) =>
          previousValue + getExercise.prelude! + getExercise.duration!,
    );
    return totalTime;
  }

  Workout copyWith({
    String? title,
  }) {
    return Workout(
      title: title ?? this.title,
      exercise: exercise,
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'exercise': exercise,
      };

  @override
  List<Object?> get props => [title, exercise];

  @override
  bool get stringify => true;
}
