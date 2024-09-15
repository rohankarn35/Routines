import 'package:flutter/material.dart';

class ChatOptionsMenu extends StatelessWidget {
  final Widget child;
  final Function(String) onOptionSelected;

  ChatOptionsMenu({required this.child, required this.onOptionSelected});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: (LongPressStartDetails details) {
        _showOptionsMenu(context, details.globalPosition);
      },
      child: child,
    );
  }

  void _showOptionsMenu(BuildContext context, Offset position) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy,
        position.dx + 12,
        position.dy,
      ),
      items: <PopupMenuEntry>[
        const PopupMenuItem(
          value: 'Edit',
          child: Row(
            children: [
              Icon(Icons.edit),
              SizedBox(width: 8),
              Text('Edit'),
            ],
          ),
        ),
        const PopupMenuItem(
          value: 'Delete',
          child: Row(
            children: [
              Icon(Icons.delete),
              SizedBox(width: 8),
              Text('Delete'),
            ],
          ),
        ),
      ],
    ).then((value) {
      if (value != null) {
        onOptionSelected(value);
      }
    });
  }
}
