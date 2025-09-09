import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/controllers/student_controller.dart';
import 'package:test/modules/custom_widgets/list_card.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    final StudentController studentController =
        Get.find<StudentController>(); // Use injected controller

    return Scaffold(
      appBar: AppBar(
        title: const Text('Student List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => Get.snackbar('Info', 'Search not implemented yet'),
          ),
        ],
        backgroundColor: Colors.purpleAccent,
      ),
      body: Obx(
        () => studentController.students.isEmpty
            ? const Center(child: Text('No students found'))
            : ListView.builder(
                itemCount: studentController.students.length,
                itemBuilder: (context, index) {
                  return ListCard(
                    studentDetail: studentController.students[index],
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showAddStudentDialog(context, studentController),
        label: const Text('Add Student'),
        icon: const Icon(Icons.add),
      ),
    );
  }

  void showAddStudentDialog(
    BuildContext context,
    StudentController controller,
  ) {
    final nameController = TextEditingController();
    final ageController = TextEditingController();
    final idController = TextEditingController();
    final courseController = TextEditingController();
    final imagePathController = TextEditingController();

    Get.dialog(
      AlertDialog(
        title: const Text('Add Student'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: ageController,
              decoration: const InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: idController,
              decoration: const InputDecoration(labelText: 'Student ID'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: courseController,
              decoration: const InputDecoration(labelText: 'Course'),
            ),
            TextField(
              controller: imagePathController,
              decoration: const InputDecoration(labelText: 'Image Path'),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              try {
                final age = int.parse(ageController.text);
                final id = int.parse(idController.text);
                controller.addStudent(
                  nameController.text,
                  age,
                  id,
                  courseController.text,
                  imagePathController.text,
                );
                Get.back();
              } catch (e) {
                Get.snackbar('Error', 'Invalid input: $e');
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
