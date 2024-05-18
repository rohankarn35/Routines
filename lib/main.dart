import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:routines/core/theme/theme.dart';
import 'package:routines/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:routines/features/auth/presentation/pages/selection_page.dart';
import 'package:routines/injection.dart';

void main() {
  initDependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => serviceLocator<AuthBloc>(),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Routines',
      theme: AppTheme.darkThemeMode,
      home: const SelectionPage(),
    );
  }
}
