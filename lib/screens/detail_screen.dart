import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/controllers/student_controller.dart';
import 'package:test/modules/models/student_model.dart';
import 'package:test/screens/update_bottom.dart';

class DetailScreen extends StatelessWidget {
  final StudentModel studentDetail;

  const DetailScreen({super.key, required this.studentDetail});

  void _showUpdateBottomSheet(StudentModel studentDetail) {
    Get.bottomSheet(
      UpdateBottomSheet(studentDetail: studentDetail),
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        side: BorderSide(color: Colors.grey, width: 0.5),
      ),
      barrierColor: Colors.black54,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final studentController = Get.find<StudentController>();
    return Obx(() {
      final updatedStudent = studentController.getStudentById(
        studentDetail.studentid,
      );
      final displayStudent = updatedStudent ?? studentDetail;
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Student Detail',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
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
                    backgroundImage: FileImage(File(displayStudent.imagepath)),
                    backgroundColor: Colors.grey[200],
                  ),
                ),
                const SizedBox(height: 20),

                Text(
                  displayStudent.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Course: ${displayStudent.course}",
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
                          displayStudent.age.toString(),
                        ),
                        const Divider(),
                        _buildDetailRow(
                          Icons.calendar_month,
                          "DOB",
                          "${displayStudent.dob.day}/${displayStudent.dob.month}/${displayStudent.dob.year}",
                        ),
                        const Divider(),
                        _buildDetailRow(
                          Icons.email,
                          "Email",
                          displayStudent.email,
                        ),
                        const Divider(),
                        _buildDetailRow(
                          Icons.badge,
                          "Student ID",
                          displayStudent.studentid.toString(),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: size.width * 0.4,
                      height: 50,
                      child: ElevatedButton.icon(
                        icon: const Icon(
                          Icons.edit_document,
                          color: Colors.white,
                        ),
                        label: const Text('Update'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                        ),
                        onPressed: () => _showUpdateBottomSheet(displayStudent),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.4,
                      height: 50,
                      child: ElevatedButton.icon(
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Colors.white,
                        ),
                        label: const Text('Delete'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                        ),
                        onPressed: () {
                          Get.defaultDialog(
                            title: 'Delete Student ',
                            middleText: 'Are you sure to delete this student ?',
                            textConfirm: 'Yes',
                            textCancel: 'No',
                            titleStyle: TextStyle(color: Colors.red),

                            onConfirm: () {
                              studentController.deleteStudent(
                                studentDetail.studentid,
                              );
                            },
                            onCancel: () => Get.back(),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

Widget _buildDetailRow(IconData icon, String title, String value) {
  return Row(
    children: [
      Icon(icon, color: Colors.blueAccent),
      const SizedBox(width: 12),
      Expanded(
        child: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      ),
      Text(value, style: const TextStyle(fontSize: 16)),
    ],
  );
}
