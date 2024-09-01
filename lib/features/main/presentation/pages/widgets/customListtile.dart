import 'package:flutter/material.dart';

class CustomListTile {
  static Widget customListTile(
      IconData icon, String title, GestureTapCallback onTap,
      {Widget? trailing}) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.white,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
      trailing: trailing ?? null,
      onTap: onTap,
    );
  }
}
