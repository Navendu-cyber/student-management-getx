import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:test/modules/custom_widgets/validation_class.dart';
import 'package:image_picker/image_picker.dart';

void showStudentDialogGetx() {
  var formKey = GlobalKey<FormState>();
  final nameeController = TextEditingController();
  final ageController = TextEditingController();
  final courseController = TextEditingController();
  final studentIdController = TextEditingController();
  RxString imagepath = ''.obs;
  final picker = ImagePicker();

  Get.defaultDialog(
    title: "Add Student",
    content: Form(
      key: formKey,
      child: Column(
        children: [
          InkWell(
            onTap: () async {
              final permission = await Permission.photos.request();
              if (permission.isGranted) {
                final pickedpath = await picker.pickImage(
                  source: ImageSource.gallery,
                );
                if (pickedpath != null) {
                  imagepath.value = pickedpath.path;
                }
              } else {
                Get.snackbar(
                  'Error',
                  'Photo permission Denied',
                  backgroundColor: Colors.red,
                );
              }
            },
            child: CircleAvatar(
              radius: 35,
              backgroundImage: imagepath.value.isNotEmpty
                  ? FileImage(File(imagepath.value))
                  : null,
              child: imagepath.value.isEmpty ? const Icon(Icons.person) : null,
            ),
          ),
          TextFormField(
            autocorrect: true,
            controller: nameeController,
            decoration: InputDecoration(labelText: 'Student Name'),
            validator: Validators.name,
          ),
          TextFormField(
            autocorrect: true,
            controller: ageController,
            decoration: InputDecoration(labelText: 'Student Age'),
            validator: Validators.age,
          ),
          TextFormField(
            autocorrect: true,
            controller: courseController,
            decoration: InputDecoration(labelText: 'Course'),
            validator: Validators.course,
          ),
          TextFormField(
            autocorrect: true,
            controller: studentIdController,
            decoration: InputDecoration(labelText: 'Student id (numbers only)'),
            validator: Validators.studentId,
          ),
        ],
      ),
    ),
    actions: [
      TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
      TextButton(onPressed: () {
        if(formKey.currentState!.validate()){
          
        }
      }, child: const Text('Add')),
    ],
  );
}
