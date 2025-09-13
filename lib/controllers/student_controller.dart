import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:test/modules/models/student_model.dart';

class StudentController extends GetxController {
  var students = <StudentModel>[].obs;
  final Box<StudentModel> studentBox;

  StudentController(this.studentBox);
  @override
  void onInit() {
    super.onInit();
    students.addAll(studentBox.values);
  }

  @override
  void onClose() {
    studentBox.close();
    super.onClose();
  }

  addStudent(
    String name,
    int age,
    int studentId,
    String course,
    String imagepath,
    String email,
    DateTime dob,
  ) {
    if (studentBox.containsKey(studentId)) {
      Get.snackbar('Error', 'Student ID $studentId already exist');
      return;
    }
    final student = StudentModel(
      name,
      age,
      studentId,
      course,
      imagepath,
      email,
      dob,
    );
    students.add(student);
    studentBox.put(studentId, student);
  }
}
