import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app_complete/app/cubit/workout_cubit.dart';
import 'package:flutter_bloc_app_complete/bloc/workout_cubit.dart';
import 'package:flutter_bloc_app_complete/constants/helper.dart';
import 'package:flutter_bloc_app_complete/models/workout.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 238, 121, 99),
        elevation: 0,
        title: const Text('Workout App'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.event_available_rounded),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<WorkoutsCubit, List<Workout>>(
        builder: (context, workouts) => buildExpansionTitle(workouts),
      ),
    );
  }

  Widget buildExpansionTitle(List<Workout> workouts) {
    return ExpansionPanelList.radio(
      children: workouts
          .map(
            (workout) => ExpansionPanelRadio(
              canTapOnHeader: true,
              value: workout,
              headerBuilder: (BuildContext context, bool isExpanded) {
                return ListTile(
                  visualDensity: const VisualDensity(
                    horizontal: 0,
                    vertical: VisualDensity.maximumDensity,
                  ),
                  leading: IconButton(
                    onPressed: () =>
                        BlocProvider.of<WorkoutCubit>(context).editWorkout(
                      workout,
                      workouts.indexOf(workout),
                    ),
                    icon: const Icon(
                      Icons.edit,
                      color: Color.fromARGB(255, 102, 102, 102),
                    ),
                  ),
                  title: Text(workout.title ?? 'NA'),
                  trailing: Text(timeFormatter(workout.getTotalTime(), true)),
                );
              },
              body: buildExpansionBody(workout),
            ),
          )
          .toList(),
    );
  }

  Widget buildExpansionBody(Workout workout) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: workout.exercise.length,
      itemBuilder: (context, index) {
        return ListTile(
          visualDensity: const VisualDensity(
            horizontal: 0,
            vertical: VisualDensity.maximumDensity,
          ),
          leading: Text(timeFormatter(workout.exercise[index].prelude!, true)),
          title: Text(workout.exercise[index].title ?? 'NA'),
          trailing:
              Text(timeFormatter(workout.exercise[index].duration!, true)),
        );
      },
    );
  }
}
