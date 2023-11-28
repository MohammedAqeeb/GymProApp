part of 'workout_cubit.dart';

abstract class WorkoutState extends Equatable {
  final Workout? workout;
  final int? elapsed;

  const WorkoutState(this.workout, this.elapsed);
}

class WorkoutInitial extends WorkoutState {
  const WorkoutInitial() : super(null, 0);

  @override
  List<Object?> get props => [workout, elapsed];
}

class WorkoutEditing extends WorkoutState {
  final int? workoutIndex;
  final int? exerciseIndex;
  const WorkoutEditing(
    Workout? workout,
    this.workoutIndex,
    this.exerciseIndex,
  ) : super(workout, 0);

  @override
  List<Object?> get props => [workout, workoutIndex, exerciseIndex];
}
