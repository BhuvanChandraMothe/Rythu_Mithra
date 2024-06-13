import 'package:flutter/material.dart';

class Comment extends StatelessWidget {
  final String username;
  final String time;
  final String text;
  const Comment(
      {super.key,
      required this.text,
      required this.time,
      required this.username});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 158, 154, 154),
          borderRadius: BorderRadius.circular(4),
        ),
        margin: const EdgeInsets.only(bottom: 5),
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //comment
            Text(text),

            //user and time
            Row(
              children: [
                Text(
                  username,
                  style: TextStyle(color: Colors.grey[600]),
                ),
                Text(' • ', style: TextStyle(color: Colors.grey[600])),
                Text(time, style: TextStyle(color: Colors.grey[600])),
              ],
            ),
          ],
        ));
  }
}
