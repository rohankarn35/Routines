import 'package:flutter/material.dart';
import 'package:routines/core/error/errorpage.dart';
import 'package:routines/features/auth/presentation/pages/selection_page.dart';

class AppRoutes {
  static const String home = '/';
  static const String config = '/config';
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (context) => SelectionPage());

      default:
        return MaterialPageRoute(builder: (context) => ErrorPage());
    }
  }
}
