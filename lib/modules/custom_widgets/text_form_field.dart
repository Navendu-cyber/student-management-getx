import 'package:flutter/material.dart';

class StudentFormField extends StatelessWidget {
  final String label;
  final IconData icon;
  final TextEditingController controller = TextEditingController();
  final TextInputType keyboardType;
  final String? Function(String) validator;
  StudentFormField({
    super.key,
    required this.label,
    required this.validator,
    required this.icon,
    required TextEditingController controller,
    required this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,

      decoration: InputDecoration(
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        labelText: label,
        icon: Icon(icon),
      ),
    );
  }
}
