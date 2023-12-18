import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc_app_complete/models/exercise.dart';
import 'package:flutter_bloc_app_complete/models/workout.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class WorkoutsCubit extends HydratedCubit<List<Workout>> {
  WorkoutsCubit() : super([]);

  getWorkouts() async {
    final List<Workout> workouts = [];

    final allWorkout =
        jsonDecode(await rootBundle.loadString('assets/workouts.json'));

    for (var loadWorkout in (allWorkout) as Iterable) {
      workouts.add(Workout.fromJson(loadWorkout));
    }
    emit(workouts);
  }

  saveWorkout(Workout workout, int index) {
    Workout newWorkout = Workout(title: workout.title, exercise: []);
    // ignore: unused_local_variable
    int exIndex = 0;
    // ignore: unused_local_variable
    int startTime = 0;

    for (var newExercise in workout.exercise) {
      newWorkout.exercise.add(
        Exercises(
          title: newExercise.title,
          prelude: newExercise.prelude,
          duration: newExercise.duration,
          index: newExercise.index,
          startTime: newExercise.startTime,
        ),
      );
      exIndex++;
      startTime = newExercise.prelude! + newExercise.duration!;
    }

    state[index] = newWorkout;

    emit([...state]);
  }

  @override
  List<Workout> fromJson(Map<String, dynamic> json) {
    List<Workout> workouts = [];

    json['workouts'].forEach((element) => workouts.add(
          Workout.fromJson(element),
        ));

    return workouts;
  }

  @override
  Map<String, dynamic>? toJson(List<Workout> state) {
    // ignore: unnecessary_type_check
    if (state is List<Workout>) {
      var json = {
        'workouts': [],
      };

      for (var workout in state) {
        json['workouts']!.add(workout.toJson());
      }
      return json;
    } else {
      return null;
    }
  }
}
