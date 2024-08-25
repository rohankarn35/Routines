import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routines/features/main/presentation/bloc/routine_bloc.dart';
import 'package:routines/features/main/presentation/pages/widgets/dailySchedule.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        backgroundColor: const Color.fromRGBO(24, 24, 32, 1),
        shadowColor: Colors.black.withOpacity(0.5),
        surfaceTintColor: const Color.fromRGBO(24, 24, 32, 1),
        title: const Padding(
          padding: EdgeInsets.only(top: 10),
          child: Text(
            "Routines",
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
            ),
          ),
        ),
        bottom: TabBar(
          dividerHeight: 0,
          physics: BouncingScrollPhysics(),
          controller: _tabController,
          isScrollable: true,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
          labelStyle: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
          indicator: const UnderlineTabIndicator(
            borderSide: BorderSide(width: 1, color: Colors.transparent),
          ),
          tabs: const [
            Tab(text: 'Monday'),
            Tab(text: 'Tuesday'),
            Tab(text: 'Wednesday'),
            Tab(text: 'Thursday'),
            Tab(text: 'Friday'),
            Tab(text: 'Saturday'),
            Tab(text: 'Sunday'),
          ],
        ),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: TabBarView(controller: _tabController, children: [
          BlocProvider(
            create: (context) =>
                RoutineBloc()..add(LoadDataFromHiveEvent(day: "MON")),
            child: buildDailySchedule("MON", context),
          ),
          BlocProvider(
            create: (context) =>
                RoutineBloc()..add(LoadDataFromHiveEvent(day: "TUE")),
            child: buildDailySchedule("TUE", context),
          ),
          BlocProvider(
            create: (context) =>
                RoutineBloc()..add(LoadDataFromHiveEvent(day: "WED")),
            child: buildDailySchedule("WED", context),
          ),
          BlocProvider(
            create: (context) =>
                RoutineBloc()..add(LoadDataFromHiveEvent(day: "THU")),
            child: buildDailySchedule("THU", context),
          ),
          BlocProvider(
            create: (context) =>
                RoutineBloc()..add(LoadDataFromHiveEvent(day: "FRI")),
            child: buildDailySchedule("FRI", context),
          ),
          BlocProvider(
            create: (context) =>
                RoutineBloc()..add(LoadDataFromHiveEvent(day: "SAT")),
            child: buildDailySchedule("SAT", context),
          ),
          BlocProvider(
            create: (context) =>
                RoutineBloc()..add(LoadDataFromHiveEvent(day: "SUN")),
            child: buildDailySchedule("SUN", context),
          ),
        ]),
      ),
    );
  }
}
