import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app_complete/bloc/workout_cubit.dart';
import 'package:flutter_bloc_app_complete/constants/helper.dart';
import 'package:flutter_bloc_app_complete/models/workout.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      child: BlocBuilder<WorkoutCubit, List<Workout>>(
        builder: (context, workouts) => ExpansionPanelList.radio(
          children: workouts
              .map(
                (workout) => ExpansionPanelRadio(
                  value: workout,
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      visualDensity: const VisualDensity(
                        horizontal: 0,
                        vertical: VisualDensity.maximumDensity,
                      ),
                      leading: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.edit),
                      ),
                      title: Text(workout.title ?? 'NA'),
                      trailing:
                          Text(timeFormatter(workout.getTotalTime(), true)),
                    );
                  },
                  body: buildExpansionBody(workout),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget buildExpansionBody(Workout workout) {
    return ListView.builder(
      shrinkWrap: true,
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
