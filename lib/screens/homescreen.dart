import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/controllers/student_controller.dart';
import 'package:test/modules/custom_widgets/list_card.dart';
import 'package:test/screens/addbottom.dart';
import 'package:test/screens/detail_screen.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  void _showAddStudentBottomSheet() {
    Get.bottomSheet(
      ignoreSafeArea: false,
      AddStudentBottomSheet(),
      elevation: 8.0,
      enableDrag: true,
      isDismissible: true,
      isScrollControlled: true,
      barrierColor: Colors.black.withOpacity(0.5),
      backgroundColor:
          Get.theme.bottomSheetTheme.backgroundColor ?? Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        side: BorderSide(color: Colors.grey, width: 0.5),
      ),
      enterBottomSheetDuration: const Duration(milliseconds: 300),
      settings: const RouteSettings(name: 'AddStudentSheet'),
    );
  }

  @override
  Widget build(BuildContext context) {
    final studentController = Get.find<StudentController>();
    final searchController = TextEditingController();
    final isNavigating = false.obs;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Student List'),
        actions: const [Icon(Icons.search)],
        backgroundColor: Colors.lightBlue,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search by name...',
                prefixIcon: Icon(
                  Icons.search,
                  color: Get.theme.iconTheme.color,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Get.theme.primaryColor,
                    width: 2,
                  ),
                ),
                filled: true,
                fillColor: Get.theme.brightness == Brightness.dark
                    ? Colors.grey[800]
                    : Colors.grey[100],
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              onChanged: (value) {
                studentController.searchQuery.value = value;
              },
            ),
          ),

          Expanded(
            child: Obx(
              () => studentController.filteredStudents.isEmpty
                  ? const Center(child: Text('No Students yet'))
                  : ListView.builder(
                      itemCount: studentController.filteredStudents.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Get.to(
                              () => DetailScreen(
                                studentDetail:
                                    studentController.filteredStudents[index],
                              ),
                            );
                          },
                          child: ListCard(
                            studentDetail:
                                studentController.filteredStudents[index],
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.lightBlue,
        onPressed: isNavigating.value
            ? null
            : () {
                isNavigating.value = true;
                _showAddStudentBottomSheet();
                isNavigating.value = false;
              },
        label: const Text('Add Student'),
        icon: const Icon(Icons.add),
        elevation: 40.0,
      ),
    );
  }
}
