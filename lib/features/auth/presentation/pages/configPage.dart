import 'package:flutter/material.dart';

class ConfigPage extends StatelessWidget {
  final String coreSection;
  final List<String> electiveSection;
  const ConfigPage(
      {super.key, required this.coreSection, required this.electiveSection});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(),
    );
  }
}
