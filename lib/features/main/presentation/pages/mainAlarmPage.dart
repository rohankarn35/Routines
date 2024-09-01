import 'dart:async';
import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:intl/intl.dart';
import 'package:routines/features/main/presentation/pages/widgets/clockWidget.dart';
import 'package:routines/features/main/presentation/pages/widgets/shakingAlarmIcon.dart';
import 'package:slide_to_act/slide_to_act.dart';

class MainAlarmPage extends StatefulWidget {
  final int id; // Use lower camel case for variable names
  const MainAlarmPage({super.key, required this.id});

  @override
  State<MainAlarmPage> createState() => _MainAlarmPageState();
}

class _MainAlarmPageState extends State<MainAlarmPage> {
  @override
  void initState() {
    super.initState();
    FlutterRingtonePlayer().playAlarm();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 4,
                    ),
                    child: ClockWidget(),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 2.5,
                  ),
                  ShakingAlarmIcon(),
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 35, left: 30, right: 30),
              child: SlideAction(
                text: 'Slide to cancel',
                // textStyle: TextStyle(),
                outerColor: const Color.fromARGB(255, 97, 13, 7),
                onSubmit: () async {
                  Navigator.pop(context);
                  await Alarm.stop(widget.id);
                  FlutterRingtonePlayer().stop();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
