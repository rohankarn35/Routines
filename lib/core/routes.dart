import 'package:flutter/material.dart';
import 'package:routines/core/error/errorpage.dart';
import 'package:routines/features/auth/presentation/pages/configPage.dart';
import 'package:routines/features/auth/presentation/pages/selection_page.dart';
import 'package:routines/features/main/presentation/pages/mainpage.dart';

class AppRoutes {
  static const String home = '/';
  static const String config = '/config';
  static const String mainPage = '/mainPage';
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (context) => SelectionPage());
      case config:
        try {
          final Map<String, dynamic> args =
              settings.arguments as Map<String, dynamic>;
          final String year = args["year"];
          final String branch = args["branch"];
          final String coreSection = args["coreSection"];
          final Map<String, dynamic> electiveDetails = args["electiveDetails"];
          return MaterialPageRoute(
              builder: (context) => ConfigPage(
                    year: year,
                    electiveSubjects: electiveDetails,
                    coreSection: coreSection,
                    branch: branch,
                  ));
        } catch (e) {
          return MaterialPageRoute(
              builder: (context) => ErrorPage(
                    error: 'An Error Occured',
                  ));
        }
      case mainPage:
        return MaterialPageRoute(builder: (context) => Mainpage());
      default:
        return MaterialPageRoute(
            builder: (context) => ErrorPage(
                  error: 'An Error Occured',
                ));
    }
  }
}
