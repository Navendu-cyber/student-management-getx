class Validators {
  static String? name(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name cannot be empty';
    }
    if (value.trim().length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }

  /// Age: non-empty, numeric, between 10 and 100
  static String? age(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Age cannot be empty';
    }
    final ageNum = int.tryParse(value.trim());
    if (ageNum == null) {
      return 'Age must be a number';
    }
    if (ageNum < 10 || ageNum > 100) {
      return 'Age must be between 10 and 100';
    }
    return null;
  }

  /// Course: non-empty
  static String? course(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Course cannot be empty';
    }
    return null;
  }

  /// Student ID: non-empty, alphanumeric, length 4-10
  static String? studentId(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Student ID cannot be empty';
    }
    final id = value.trim();
    if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(id)) {
      return 'Student ID must be alphanumeric';
    }
    if (id.length < 4 || id.length > 10) {
      return 'Student ID must be 4-10 characters';
    }
    return null;
  }
}
