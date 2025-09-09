import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:test/modules/models/student_model.dart';

class ListCard extends StatelessWidget {
  final StudentModel studentDetail;
  const ListCard({super.key, required this.studentDetail});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Row(
        children: [
          Column(
            children: [
              CircleAvatar(
                backgroundImage: studentDetail.imagepath.isEmpty
                    ? AssetImage('assets/error.jpeg')
                    : AssetImage(studentDetail.imagepath),
              ),
              Text(studentDetail.name),
            ],
          ),
        ],
      ),
    );
  }
}
