import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app_complete/app/cubit/workout_cubit.dart';
import 'package:flutter_bloc_app_complete/app/home_screen.dart';
import 'package:flutter_bloc_app_complete/bloc/workout_cubit.dart';

import 'app/edit/workout/edit_screen.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Workouts',
      theme: ThemeData(
        primaryColor: Colors.blue,
        useMaterial3: false,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            color: Color.fromARGB(255, 66, 74, 96),
          ),
        ),
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<WorkoutsCubit>(create: (BuildContext context) {
            WorkoutsCubit workoutsCubit = WorkoutsCubit();

            if (workoutsCubit.state.isEmpty) {
              workoutsCubit.getWorkouts();
            } else {
              print('Empty');
            }

            return workoutsCubit;
          }),
          BlocProvider<WorkoutCubit>(
            create: (BuildContext context) => WorkoutCubit(),
          ),
        ],
        child: BlocBuilder<WorkoutCubit, WorkoutState>(
          builder: (context, state) {
            if (state is WorkoutInitial) {
              return const HomeScreen();
            } else if (state is WorkoutEditing) {
              return const EditWorkoutScreen();
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
