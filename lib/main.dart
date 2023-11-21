import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app_complete/app/home_screen.dart';
import 'package:flutter_bloc_app_complete/bloc/workout_cubit.dart';
import 'package:flutter_bloc_app_complete/models/workout.dart';

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
      home: BlocProvider(
        create: (context) {
          WorkoutCubit workoutCubit = WorkoutCubit();
          if (workoutCubit.state.isEmpty) {
            print('LOADING');
            workoutCubit.getWorkouts();
          } else {
            print('Empty');
          }

          return workoutCubit;
        },
        child: BlocBuilder<WorkoutCubit, List<Workout>>(
          builder: (context, state) {
            return const HomeScreen();
          },
        ),
      ),
    );
  }
}
