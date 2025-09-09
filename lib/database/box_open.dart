import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:test/controllers/student_controller.dart';
import 'package:test/modules/models/student_model.dart';

Future openBoxes() async {
  final box = await Hive.openBox<StudentModel>('students');
  Get.put(StudentController(box));
  return box;
}
