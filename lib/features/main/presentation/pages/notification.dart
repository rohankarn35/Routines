import 'dart:async';
import 'dart:io';

import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:routines/features/main/presentation/pages/mainAlarmPage.dart';

// @pragma('vm:entry-point')
// void printHello() {
//   final DateTime now = DateTime.now();
//   print("[$now] Hello, world!");
// }

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  static StreamSubscription<AlarmSettings>? ringSubscription;

  Future<void> checkAndroidScheduleExactAlarmPermission() async {
    final status = await Permission.scheduleExactAlarm.status;
    if (status.isDenied) {
      final res = await Permission.scheduleExactAlarm.request();
    }
  }

  Future<void> requestStoragePermission() async {
    PermissionStatus status = await Permission.audio.request();

    if (status.isGranted) {
    } else if (status.isDenied) {
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  Future<void> stopAlarm(int alarmId) async {
    try {
      bool isCancelled = await Alarm.stop(alarmId);
      if (isCancelled) {
        print("Alarm with ID $alarmId stopped successfully.");
      } else {
        print("Failed to stop the alarm with ID $alarmId.");
      }
    } catch (e) {
      print("Error stopping the alarm: $e");
    }
  }

  Future<void> requestManageExternalStoragePermission() async {}

  Future<List<FileSystemEntity>> getMusicFiles() async {
    final directory = Directory('/storage/emulated/0/Music/');
    List<FileSystemEntity> files = directory.listSync();
    List<FileSystemEntity> musicFiles = files.where((file) {
      return file.path.endsWith('.mp3'); // Filter only mp3 files
    }).toList();
    return musicFiles;
  }

  Future<void> setAlarmWithMusic(String musicPath) async {
    DateTime dateTime = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      9, // hour
      0, // minute
      0, // second
    );

    final alarmSettings = AlarmSettings(
        id: 42,
        dateTime: DateTime.now().add(Duration(seconds: 10)),
        assetAudioPath: musicPath,
        loopAudio: true,
        vibrate: true,
        // volume: 0.8,
        fadeDuration: 3.0,
        notificationTitle: 'Good Morning',
        notificationBody: 'Click here to dismiss Alarm',
        androidFullScreenIntent: true);
    await Alarm.set(
      alarmSettings: alarmSettings,
    );
  }

  setalarm() async {
    List<FileSystemEntity> musicFiles = await getMusicFiles();
    if (musicFiles.isNotEmpty) {
      String musicPath = musicFiles.first.path;
      print(musicPath);
      await setAlarmWithMusic(musicPath);
    } else {
      print("there is no any music files in the system");
    }
  }

  printAlarm() {
    print("hello this is alarm");
  }

  Future<void> navigateToRingScreen(AlarmSettings alarmSettings) async {
    await Navigator.push(context,
        MaterialPageRoute<void>(builder: (context) => MainAlarmPage(id: 42)));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // checkAndroidScheduleExactAlarmPermission();
    // requestStoragePermission();
    ringSubscription ??= Alarm.ringStream.stream.listen(navigateToRingScreen);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    ringSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {
              // await AndroidAlarmManager.oneShot(
              //   const Duration(seconds: 5),
              //   0,
              //   printHello,
              // );
              await requestStoragePermission();
              setalarm();
            },
            child: Text('Set Alarm'),
          ),
          // ElevatedButton(
          //   onPressed: () async {
          //     // await AndroidAlarmManager.oneShot(
          //     //   const Duration(seconds: 5),
          //     //   0,
          //     //   printHello,
          //     // );
          //     await requestStoragePermission();
          //     stopAlarm(42);
          //     FlutterRingtonePlayer().stop();
          //   },
          //   child: Text('cancel alarm'),
          // ),
        ],
      )),
    );
  }
}
