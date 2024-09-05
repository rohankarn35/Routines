import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routines/features/main/presentation/bloc/routine_bloc.dart';
import 'package:routines/features/main/presentation/pages/widgets/customAddRoutinesDialog.dart';
import 'package:routines/features/main/presentation/pages/widgets/dailytabbar.dart';
import 'package:routines/features/main/presentation/pages/widgets/mainBottonSheet.dart';

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
    int currentDayIndex = DateTime.now().weekday - 1;
    _tabController =
        TabController(length: 7, vsync: this, initialIndex: currentDayIndex);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoutineBloc, RoutineState>(
      buildWhen: (previous, current) {
        return current is RoutineLoadFromHiveState;
      },
      builder: (context, state) {
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
            actions: [
              IconButton(
                icon: const Icon(Icons.menu_rounded, color: Colors.white),
                onPressed: () =>
                    MainBottomSheet.mainshowModalBottomSheet(context),
              ),
            ],
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
          body: DailyRoutineTabBarView(
            tabController: _tabController,
          ),
        );
      },
    );
  }
}
