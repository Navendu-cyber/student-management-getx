import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:test/controllers/student_form_controller.dart';
import 'package:test/modules/models/student_model.dart';

class UpdateBottomSheet extends StatelessWidget {
  final StudentModel studentDetail;

  UpdateBottomSheet({super.key, required this.studentDetail});

  @override
  Widget build(BuildContext context) {
    final formController = Get.find<StudentFormController>();
    formController.nameController.text = studentDetail.name;
    formController.ageController.text = studentDetail.age.toString();
    formController.courseController.text = studentDetail.course;
    formController.studentIdController.text = studentDetail.studentid
        .toString();
    formController.emailController.text = studentDetail.email;
    formController.dobcontroller.text = studentDetail.dob != null
        ? DateFormat('dd/MM/yyyy').format(studentDetail.dob)
        : '';
    formController.dob.value = studentDetail.dob;
    formController.imagePath.value = studentDetail.imagepath;

    return Obx(() {
      if (formController.currentStep.value == 0) {
        return SizedBox(
          height: 450,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Form(
                key: formController.formKeyStep1,
                autovalidateMode:
                    AutovalidateMode.always, // Validate pre-filled
                child: Column(
                  children: [
                    InkWell(
                      onTap: () => formController.pickImage(),
                      child: Obx(() {
                        if (formController.imagePath.isEmpty) {
                          return const CircleAvatar(
                            backgroundColor: Colors.lightBlue,
                            radius: 45,
                            child: Icon(
                              Icons.add_a_photo_outlined,
                              color: Colors.black,
                            ),
                          );
                        } else {
                          return Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.lightBlue,
                                width: 3,
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 45,
                              backgroundImage: FileImage(
                                File(formController.imagePath.value),
                              ),
                            ),
                          );
                        }
                      }),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: formController.nameController,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        labelText: "Name",
                      ),
                      validator: (val) => val == null || val.trim().isEmpty
                          ? "Name required"
                          : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: formController.ageController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        labelText: "Age",
                      ),
                      validator: (val) {
                        if (val == null || val.trim().isEmpty)
                          return "Age required";
                        final age = int.tryParse(val.trim());
                        if (age == null || age <= 0) return "Enter valid age";
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlue,
                      ),
                      onPressed: formController.goToNextStep,
                      child: const Text(
                        "Next",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      } else {
        return SizedBox(
          height: 400,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Form(
              key: formController.formKeyStep2,
              autovalidateMode: AutovalidateMode.always, // Validate pre-filled
              child: Column(
                children: [
                  TextFormField(
                    controller: formController.courseController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      labelText: "Course",
                    ),
                    validator: (val) => val == null || val.trim().isEmpty
                        ? "Course required"
                        : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: formController.emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      labelText: "Email",
                    ),
                    validator: (val) {
                      if (val == null || val.trim().isEmpty)
                        return "Email required";
                      if (!GetUtils.isEmail(val.trim()))
                        return "Enter valid email";
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    readOnly: true,
                    controller: formController.dobcontroller,
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () async {
                          final pickedDate = await showDatePicker(
                            context: context,
                            initialDate:
                                formController.dob.value ?? DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );
                          if (pickedDate != null) {
                            formController.dob.value = pickedDate;
                            formController.dobcontroller.text = DateFormat(
                              'dd/MM/yyyy',
                            ).format(pickedDate);
                          }
                        },
                        icon: const Icon(Icons.calendar_month),
                      ),
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      labelText: "Date of Birth",
                    ),
                    validator: (val) {
                      if (val == null || val.trim().isEmpty)
                        return "Dob is Required";
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: formController.goToPreviousStep,
                        child: const Text("Back"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          formController.updateStudent(studentDetail.studentid);
                          Get.back();
                        },
                        child: const Text("Save"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }
    });
  }
}
