import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:flutter_system_ringtones/flutter_system_ringtones.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:routines/core/cubits/appUser/app_user_cubit.dart';
import 'package:routines/core/data/daySchedule.dart';
import 'package:routines/core/data/subject.dart';
import 'package:routines/core/routes.dart';
import 'package:routines/core/theme/theme.dart';
import 'package:routines/features/auth/data/models/HiveModel/UserEntityModel.dart';
import 'package:routines/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:routines/features/auth/presentation/pages/selection_page.dart';
import 'package:routines/features/main/presentation/bloc/routine_bloc.dart';
import 'package:routines/features/main/presentation/pages/mainAlarmPage.dart';
import 'package:routines/features/main/presentation/pages/mainpage.dart';
import 'package:routines/features/main/presentation/pages/notification.dart';
import 'package:routines/injection.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDir.path);

  Hive.registerAdapter(SubjectAdapter());
  Hive.registerAdapter(DayScheduleAdapter());
  Hive.registerAdapter(UserentitymodelAdapter());

  await Hive.openBox<DaySchedule>('timetable');
  await Hive.openBox<Userentitymodel>('user');
  tz.initializeTimeZones();

  // print(await FlutterSystemRingtones.getAlarmSounds());

  initDependencies();
  await Alarm.init();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => serviceLocator<AuthBloc>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<AppUserCubit>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<RoutineBloc>(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initS
    // tate
    super.initState();
    context.read<AuthBloc>().add(AuthCheckUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Routines',
      theme: AppTheme.darkThemeMode,
      onGenerateRoute: AppRoutes.generateRoute,
      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) {
          return state is AppUserLoggedIn;
        },
        builder: (context, isUserLoggin) {
          if (isUserLoggin) {
            return Mainpage();
          } else {
            return SelectionPage();
          }
        },
      ),
      // home: NotificationPage(),
    );
  }
}
