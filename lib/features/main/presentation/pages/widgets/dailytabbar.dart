import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routines/features/main/presentation/bloc/routine_bloc.dart';
import 'package:routines/features/main/presentation/pages/widgets/dailySchedule.dart';
import 'package:routines/injection.dart';

class DailyRoutineTabBarView extends StatelessWidget {
  final TabController tabController;

  const DailyRoutineTabBarView({Key? key, required this.tabController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> days = ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"];

    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: TabBarView(
        controller: tabController,
        children: days.map((day) {
          return BlocProvider(
            create: (context) => serviceLocator<RoutineBloc>()
              ..add(LoadDataFromHiveEvent(day: day)),
            child: buildDailySchedule(day, context),
          );
        }).toList(),
      ),
    );
  }
}
