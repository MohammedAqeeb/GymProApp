import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app_complete/app/cubit/workout_cubit.dart';
import 'package:flutter_bloc_app_complete/app/edit/exercise/edit_exercise.dart';
import 'package:flutter_bloc_app_complete/bloc/workout_cubit.dart';
import 'package:flutter_bloc_app_complete/constants/helper.dart';
import 'package:flutter_bloc_app_complete/models/workout.dart';

import '../../../models/exercise.dart';

class EditWorkoutScreen extends StatelessWidget {
  const EditWorkoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () =>
          BlocProvider.of<WorkoutCubit>(context).navigateBackToHome(),
      child: BlocBuilder<WorkoutCubit, WorkoutState>(
        builder: (context, state) {
          WorkoutEditing workoutEditing = state as WorkoutEditing;
          return Scaffold(
            appBar: buildAppBar(context, workoutEditing),
            body: buildBody(workoutEditing),
          );
        },
      ),
    );
  }

  AppBar buildAppBar(BuildContext context, WorkoutEditing workoutEditing) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 238, 121, 99),
      elevation: 0,
      title: InkWell(
        child: Text(
          workoutEditing.workout!.title!,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        onTap: () {
          showDialog(
            context: context,
            builder: (_) {
              final controller =
                  TextEditingController(text: workoutEditing.workout!.title);
              return AlertDialog(
                content: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    label: Text('Workout title'),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      if (controller.text.isNotEmpty) {
                        Navigator.pop(context);
                        Workout renameTitle = workoutEditing.workout!.copyWith(
                          title: controller.text,
                        );

                        BlocProvider.of<WorkoutCubit>(context).editWorkout(
                          renameTitle,
                          workoutEditing.workoutIndex!,
                        );
                        BlocProvider.of<WorkoutsCubit>(context).saveWorkout(
                          renameTitle,
                          workoutEditing.exerciseIndex!,
                        );
                      }
                    },
                    child: const Text('Rename'),
                  ),
                ],
              );
            },
          );
        },
      ),
      leading: BackButton(
        color: Colors.white,
        onPressed: () {
          BlocProvider.of<WorkoutCubit>(context).navigateBackToHome();
        },
      ),
    );
  }

  Widget buildBody(WorkoutEditing workoutEditing) {
    return ListView.builder(
      itemCount: workoutEditing.workout!.exercise.length,
      itemBuilder: (context, index) {
        Exercises exercises = workoutEditing.workout!.exercise[index];

        if (workoutEditing.exerciseIndex == index) {
          return EditExerciseScreen(
            workout: workoutEditing.workout!,
            workoutIndex: workoutEditing.workoutIndex,
            exerciseIndex: workoutEditing.exerciseIndex!,
          );
        } else {
          return ListTile(
            leading: Text(timeFormatter(exercises.prelude!, true)),
            trailing: Text(timeFormatter(exercises.duration!, true)),
            title: Text(exercises.title!),
            onTap: () =>
                BlocProvider.of<WorkoutCubit>(context).editExercise(index),
          );
        }
      },
    );
  }
}
