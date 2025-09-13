import 'dart:io';
import 'package:flutter/material.dart';
import 'package:test/modules/models/student_model.dart';

class DetailScreen extends StatelessWidget {
  final StudentModel studentDetail;

  const DetailScreen({super.key, required this.studentDetail});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          style: TextStyle(color: Colors.black),
          "Student Detail",
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.blueAccent, width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: size.width * 0.18,
                    backgroundImage: FileImage(File(studentDetail.imagepath)),
                    backgroundColor: Colors.grey[200],
                  ),
                ),
                const SizedBox(height: 20),

                Text(
                  studentDetail.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),
                Text(
                  "Course : ${studentDetail.course}",
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),

                const SizedBox(height: 20),

                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        _buildDetailRow(
                          Icons.cake,
                          "Age",
                          "${studentDetail.age}",
                        ),
                        const Divider(),
                        _buildDetailRow(
                          Icons.calendar_month,
                          "DOB",
                          "${studentDetail.dob.day}/${studentDetail.dob.month}/${studentDetail.dob.year}",
                        ),
                        const Divider(),
                        _buildDetailRow(
                          Icons.email,
                          "Email",
                          studentDetail.email,
                        ),
                        const Divider(),
                        _buildDetailRow(
                          Icons.badge,
                          "Student ID",
                          studentDetail.studentid.toString(),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: 50,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        label: Text(
                          style: TextStyle(color: Colors.black),
                          'Update',
                        ),
                        icon: Icon(
                          size: 24,
                          Icons.edit_document,
                          color: Colors.lightBlue,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: 50,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                        ),
                        onPressed: () {},
                        label: Text(
                          style: TextStyle(color: Colors.black),
                          'Delete',
                        ),
                        icon: Icon(
                          Icons.delete_outline,
                          color: Colors.black,
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String title, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.blueAccent),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        Text(value, style: const TextStyle(fontSize: 16)),
      ],
    );
  }
}
