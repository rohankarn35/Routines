import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routines/features/auth/presentation/bloc/auth_bloc.dart';

class ConfigPage extends StatefulWidget {
  final String year;
  final String coreSection;
  final Map<String, dynamic> electiveSubjects;
  final String branch;

  const ConfigPage(
      {super.key,
      required this.year,
      required this.coreSection,
      required this.electiveSubjects,
      required this.branch});

  @override
  _ConfigPageState createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<String> electiveSection = [];

  void convertElectivetoList() {
    if (widget.electiveSubjects.isNotEmpty) {
      electiveSection = widget.electiveSubjects.values
          .map((value) => value.toString())
          .toList();
      ;
    }
  }

  void _configRoutine() {
    context.read<AuthBloc>().add(AuthTeacherCombineEvent(
        year: widget.year,
        branch: widget.branch,
        coreSection: widget.coreSection,
        electiveList: electiveSection));
    context.read<AuthBloc>().add(AuthConfigRoutinesEvent(
        year: widget.year,
        coreSection: widget.coreSection,
        electiveSections: electiveSection));
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
    _configRoutine();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _message = "Please Wait";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _controller.value * 1.0 * -3.141592653589793,
                  child: const Icon(
                    Icons.settings,
                    size: 70,
                  ),
                );
              },
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height / 2.3,
              left: MediaQuery.of(context).size.width / 1.9,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _controller.value * 1.0 * 3.141592653589793,
                    child: const Icon(
                      Icons.settings,
                      size: 55,
                    ),
                  );
                },
              ),
            ),
            BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthConfigRoutinesState) {
                  _message = "Done";
                }
                if (state is AuthTeacherCombineState) {}
              },
              builder: (context, state) {
                return Positioned(
                    bottom: MediaQuery.of(context).size.height / 3,
                    child: Text(_message));
              },
            ),
            Positioned(
              bottom: 40,
              child:
                  IconButton(onPressed: () {}, icon: Icon(Icons.bubble_chart)),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
            )
          ],
        ),
      ),
    );
  }
}
