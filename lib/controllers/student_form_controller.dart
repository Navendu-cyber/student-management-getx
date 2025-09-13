import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test/controllers/student_controller.dart';

class StudentFormController extends GetxController {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final studentIdController = TextEditingController();
  final courseController = TextEditingController();
  final emailController = TextEditingController();
  final dobcontroller = TextEditingController();
  final Rx<DateTime?> dob = Rx<DateTime?>(null);
  var imagePath = ''.obs;
  final currentStep = 0.obs;

  final formKeyStep1 = GlobalKey<FormState>();
  final formKeyStep2 = GlobalKey<FormState>();

  @override
  void onClose() {
    nameController.dispose();
    ageController.dispose();
    studentIdController.dispose();
    courseController.dispose();
    emailController.dispose();
    dobcontroller.dispose();
    super.onClose();
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? file = await picker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      imagePath.value = file.path; // update reactive variable
    }
  }

  void goToNextStep() {
    if (formKeyStep1.currentState!.validate()) {
      currentStep.value = 1;
    }
  }

  void resetForm() {
    nameController.clear();
    ageController.clear();
    studentIdController.clear();
    courseController.clear();
    emailController.clear();
    dobcontroller.clear();
    dob.value = null;
    imagePath.value = '';
    currentStep.value = 0;
  }

  void saveStudent() {
    if (formKeyStep2.currentState!.validate() && dob.value != null) {
      final studentCtrl = Get.find<StudentController>();
      final name = nameController.text.capitalize;
      studentCtrl.addStudent(
        name!,
        int.parse(ageController.text),
        int.parse(studentIdController.text),
        courseController.text,
        imagePath.toString(), // image path optional
        emailController.text,
        dob.value!,
      );
      resetForm();
      Get.back();
    } else {
      Get.snackbar("Error", "Please complete all fields");
    }
  }
}
