import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:test/controllers/student_controller.dart';
import 'package:test/modules/custom_widgets/list_card.dart';

class Homescreen extends StatelessWidget {
  final StudentController studentController = Get.find<StudentController>();
  Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student List '),
        actions: [Icon(Icons.search)],
        backgroundColor: Colors.purpleAccent,
      ),

      body: Obx(() {
        return studentController.students.isEmpty
            ? Center(child: Text('No Students yet'))
            : ListView.builder(
                itemCount: studentController.students.length,
                itemBuilder: (context, index) {
                 return ListCard(studentDetail: studentController.students[index]);
                },
              );
      }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text('Add Student'),
        icon: Icon(Icons.add),
        elevation: 40.0,
      ),
    );
  }
}
