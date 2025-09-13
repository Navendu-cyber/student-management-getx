import 'package:hive/hive.dart';
part 'student_model.g.dart';

@HiveType(typeId: 0)
class StudentModel {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final int age;
  @HiveField(2)
  final int studentid;
  @HiveField(3)
  final String course;
  @HiveField(4)
  final String imagepath;
  @HiveField(5)
  final String email;
  @HiveField(6)
  final DateTime dob;
  StudentModel(
    this.name,
    this.age,
    this.studentid,
    this.course,
    this.imagepath,
    this.email,
    this.dob,
  );
}
