import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app_complete/models/workout.dart';

class WorkoutCubit extends Cubit<List<Workout>> {
  WorkoutCubit() : super([]);

  getWorkouts() async {
    final List<Workout> workouts = [];

    final allWorkout =
        jsonDecode(await rootBundle.loadString('assets/workouts.json'));

    for (var loadWorkout in (allWorkout) as Iterable) {
      workouts.add(Workout.fromJson(loadWorkout));
    }
    emit(workouts);
  }
}
