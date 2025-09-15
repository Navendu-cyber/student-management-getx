import 'dart:io';

import 'package:flutter/material.dart';
import 'package:test/modules/models/student_model.dart';

class ListCard extends StatelessWidget {
  final StudentModel studentDetail;
  const ListCard({super.key, required this.studentDetail});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Card(
        borderOnForeground: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        margin: EdgeInsets.all(8),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 40,
                backgroundImage: studentDetail.imagepath.isEmpty
                    ? AssetImage('assets/download.jpeg')
                    : FileImage(File(studentDetail.imagepath)),
              ),
            ),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name: ${studentDetail.name}",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Course: ${studentDetail.course}',
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(Icons.chevron_right_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
