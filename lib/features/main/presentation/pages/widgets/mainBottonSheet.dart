import 'package:flutter/material.dart';
import 'package:routines/features/main/presentation/pages/widgets/customListtile.dart';
import 'package:routines/features/main/presentation/pages/widgets/customRoutineDialog.dart';

class MainBottomSheet {
  static void mainshowModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color.fromRGBO(24, 24, 32, 1),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomListTile.customListTile(
                Icons.notifications, "Turn on Notification", () {},
                trailing: Switch(
                    activeColor: Colors.green.shade600,
                    value: false,
                    onChanged: (bool val) {
                      val = !val;
                    })),
            CustomListTile.customListTile(Icons.alarm, "Wake me up", () {},
                trailing: Switch(
                    activeColor: Colors.green.shade600,
                    value: false,
                    onChanged: (bool val) {
                      val = !val;
                    })),
            CustomListTile.customListTile(Icons.add, "Add Routines", () {
              Navigator.pop(context);
              final TextEditingController subjectTextController =
                  TextEditingController();
              final TextEditingController teacherTextController =
                  TextEditingController();
              final TextEditingController roomNoTextController =
                  TextEditingController();

              CustomDialog().showCustomDialog(context, null, null, null, null,
                  subjectTextController: subjectTextController,
                  teacherTextController: teacherTextController,
                  roomNoTextController: roomNoTextController);
            }),
            CustomListTile.customListTile(Icons.info, "About", () {}),
            CustomListTile.customListTile(Icons.logout, "Logout", () {}),
          ],
        );
      },
    );
  }
}
