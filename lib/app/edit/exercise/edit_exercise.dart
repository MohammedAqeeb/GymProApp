import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app_complete/bloc/workout_cubit.dart';
import 'package:flutter_bloc_app_complete/constants/helper.dart';
import 'package:flutter_bloc_app_complete/models/workout.dart';
import 'package:numberpicker/numberpicker.dart';

class EditExerciseScreen extends StatefulWidget {
  final Workout? workout;
  final int? workoutIndex;
  final int exerciseIndex;
  const EditExerciseScreen({
    this.workout,
    this.workoutIndex,
    required this.exerciseIndex,
    super.key,
  });

  @override
  State<EditExerciseScreen> createState() => _EditExerciseScreenState();
}

class _EditExerciseScreenState extends State<EditExerciseScreen> {
  TextEditingController? textEditingController;

  @override
  void initState() {
    textEditingController = TextEditingController(
      text: widget.workout!.exercise[widget.exerciseIndex].title,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            // ------ Prelude --------
            Expanded(
              child: GestureDetector(
                child: NumberPicker(
                  value:
                      widget.workout!.exercise[widget.exerciseIndex].prelude!,
                  minValue: 0,
                  itemHeight: 30,
                  maxValue: 3599,
                  textMapper: (newValue) =>
                      timeFormatter(int.parse(newValue), false),
                  onChanged: (value) => setState(
                    () {
                      widget.workout!.exercise[widget.exerciseIndex] = widget
                          .workout!.exercise[widget.exerciseIndex]
                          .copyWith(prelude: value);
                    },
                  ),
                ),
              ),
            ),
            // ------ Exercise Title --------
            Expanded(
              flex: 3,
              child: TextField(
                controller: textEditingController,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  widget.workout!.exercise[widget.exerciseIndex] = widget
                      .workout!.exercise[widget.exerciseIndex]
                      .copyWith(title: value);

                  BlocProvider.of<WorkoutsCubit>(context)
                      .saveWorkout(widget.workout!, widget.exerciseIndex);
                },
              ),
            ),
            // ------ Duration --------
            Expanded(
              child: GestureDetector(
                child: NumberPicker(
                  value:
                      widget.workout!.exercise[widget.exerciseIndex].duration!,
                  minValue: 0,
                  itemHeight: 30,
                  maxValue: 3599,
                  textMapper: (newValue) =>
                      timeFormatter(int.parse(newValue), false),
                  onChanged: (value) => setState(
                    () {
                      widget.workout!.exercise[widget.exerciseIndex] = widget
                          .workout!.exercise[widget.exerciseIndex]
                          .copyWith(duration: value);
                    },
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
