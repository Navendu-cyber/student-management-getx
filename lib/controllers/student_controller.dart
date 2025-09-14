import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:test/modules/models/student_model.dart';

class StudentController extends GetxController {
  var students = <StudentModel>[].obs;
  var filteredStudents = <StudentModel>[].obs;
  var searchQuery = ''.obs;
  late Box<StudentModel> studentBox;

  StudentController(this.studentBox);
  @override
  void onInit() {
    super.onInit();
    studentBox = Hive.box<StudentModel>('students');

    students.value = studentBox.values.toList();
    filteredStudents.value = students;

    debounce<String>(
      searchQuery,
      (_) => filterStudents(),
      time: Duration(milliseconds: 300),
    );
  }

  @override
  void onClose() {
    studentBox.close();
    super.onClose();
  }

  void filterStudents() {
    final query = searchQuery.value.toLowerCase();
    if (query.isEmpty) {
      filteredStudents.value = students;
    } else {
      filteredStudents.value = students
          .where((student) => student.name.toLowerCase().contains(query))
          .toList();
    }
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

  void updateStudent(
    int studentId, {
    String? name,
    int? age,
    String? course,
    String? imagePath,
    String? email,
    DateTime? dob,
  }) {
    try {
      if (!studentBox.containsKey(studentId)) {
        Get.snackbar('Error', 'Student ID $studentId not found');
        return;
      }

      final existingStudent = studentBox.get(studentId)!;

      final updatedStudent = StudentModel(
        name ?? existingStudent.name,
        age ?? existingStudent.age,
        studentId,
        course ?? existingStudent.course,
        imagePath ?? existingStudent.imagepath,
        email ?? existingStudent.email,
        dob ?? existingStudent.dob,
      );

      studentBox.put(studentId, updatedStudent);

      final index = students.indexWhere((s) => s.studentid == studentId);
      if (index != -1) {
        students[index] = updatedStudent;
      }

      Get.snackbar('Success', 'Student updated successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update student: $e');
    }
  }

  void deleteStudent(String id){
    
  }

  StudentModel? getStudentById(int studentId) {
    return students.firstWhereOrNull(
          (student) => student.studentid == studentId,
        ) ??
        studentBox.get(studentId);
  }
}
