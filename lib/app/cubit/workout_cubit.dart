import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/workout.dart';

part 'workout_state.dart';

class WorkoutCubit extends Cubit<WorkoutState> {
  WorkoutCubit() : super(const WorkoutInitial());

  editWorkout(Workout workout, int index) {
    emit(WorkoutEditing(workout, index, null));
  }

  navigateBackToHome() {
    emit(const WorkoutInitial());
  }

  editExercise(int exerciseIndex) {
    emit(WorkoutEditing(
        state.workout, (state as WorkoutEditing).workoutIndex, exerciseIndex));
  }
}
