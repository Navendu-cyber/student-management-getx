import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/controllers/student_form_controller.dart';

class AddStudentBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final formController = Get.put(StudentFormController());

    return Obx(() {
      if (formController.currentStep.value == 0) {
        return SizedBox(
          height: 450,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(18.0),
              child: Form(
                key: formController.formKeyStep1,
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
                            padding: EdgeInsets.all(3), 
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
                    SizedBox(height: 20),
                    TextFormField(
                      controller: formController.nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        labelText: "Name",
                      ),
                      validator: (val) => val == null || val.trim().isEmpty
                          ? "Name required"
                          : null,
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      controller: formController.ageController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        labelText: "Age",
                      ),
                      validator: (val) {
                        if (val == null || val.isEmpty) return "Age required";
                        if (int.tryParse(val) == null || int.parse(val) <= 0) {
                          return "Enter valid age";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      controller: formController.studentIdController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        labelText: "Student ID",
                      ),
                      validator: (val) =>
                          val == null || val.isEmpty ? "ID required" : null,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlue,
                      ),
                      onPressed: formController.goToNextStep,
                      child: Text(
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
              child: Column(
                children: [
                  TextFormField(
                    controller: formController.courseController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      labelText: "Course",
                    ),
                    validator: (val) => val == null || val.trim().isEmpty
                        ? "Course required"
                        : null,
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    controller: formController.emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      labelText: "Email",
                    ),
                    validator: (val) {
                      if (val == null || val.isEmpty) return "Email required";
                      if (!GetUtils.isEmail(val)) return "Enter valid email";
                      return null;
                    },
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    readOnly: true,
                    controller: formController.dobcontroller,
                    keyboardType: TextInputType.emailAddress,

                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () async {
                          final pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );
                          if (pickedDate != null) {
                            formController.dob.value = pickedDate;
                            formController.dobcontroller.text =
                                "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                          }
                        },
                        icon: Icon(Icons.calendar_month),
                      ),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      labelText: "Date of Birth",
                    ),
                    validator: (val) {
                      if (val == null || val.isEmpty) return "Dob is Required";

                      return null;
                    },
                  ),

                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: formController.saveStudent,
                    child: Text("Save"),
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
