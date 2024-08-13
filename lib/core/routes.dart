import 'package:flutter/material.dart';
import 'package:routines/core/error/errorpage.dart';
import 'package:routines/features/auth/presentation/pages/configPage.dart';
import 'package:routines/features/auth/presentation/pages/selection_page.dart';

class AppRoutes {
  static const String home = '/';
  static const String config = '/config';
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (context) => SelectionPage());
      case config:
        try {
          final Map<String, dynamic> args =
              settings.arguments as Map<String, dynamic>;
          final String year = args["year"];
          final String coreSection = args["coreSection"];
          final List<String> electiveDetails = args["electiveDetails"];
          return MaterialPageRoute(
              builder: (context) => ConfigPage(
                    year: year,
                    electiveSubjects: electiveDetails,
                    coreSection: coreSection,
                  ));
        } catch (e) {
          return MaterialPageRoute(
              builder: (context) => ErrorPage(
                    error: 'An Error Occured',
                  ));
        }

      default:
        return MaterialPageRoute(
            builder: (context) => ErrorPage(
                  error: 'An Error Occured',
                ));
    }
  }
}
