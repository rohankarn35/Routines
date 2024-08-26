import 'package:flutter/material.dart';

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
            ListTile(
              leading: const Icon(Icons.menu, color: Colors.white),
              title: const Text('Menu', style: TextStyle(color: Colors.white)),
              onTap: () {
                // Handle Menu tap
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.info, color: Colors.white),
              title: const Text('About', style: TextStyle(color: Colors.white)),
              onTap: () {
                // Handle About tap
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.white),
              title:
                  const Text('Logout', style: TextStyle(color: Colors.white)),
              onTap: () {
                // Handle Logout tap
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
