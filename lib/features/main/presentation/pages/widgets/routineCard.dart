import 'package:flutter/material.dart';

class RoutineCard extends StatelessWidget {
  final String subject;
  final String roomNo;
  final String time;
  final String subjectTeacher;

  const RoutineCard({
    super.key,
    required this.subject,
    required this.roomNo,
    required this.time,
    required this.subjectTeacher,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromRGBO(24, 24, 32, 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subject,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subjectTeacher,
                      style: const TextStyle(
                        color: Colors.white38,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: false,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      roomNo,
                      style: const TextStyle(
                        color: Colors.white60,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Text(
                      time,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: const Divider(color: Colors.white24),
            ),
          ],
        ),
      ),
    );
  }
}
