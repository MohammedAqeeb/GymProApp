import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app_complete/models/exercise.dart';
import 'package:flutter_bloc_app_complete/models/workout.dart';

class WorkoutsCubit extends Cubit<List<Workout>> {
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
    print('logic called');
    print(workout.title);
    Workout newWorkout = Workout(title: workout.title, exercise: []);
    int index = 0;
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
      index++;
      startTime = newExercise.prelude! + newExercise.duration!;
    }

    state[index] = newWorkout;

    emit([...state]);
  }
}
