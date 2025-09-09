import 'package:hive_flutter/adapters.dart';
import 'package:test/database/box_open.dart';
import 'package:test/modules/models/student_model.dart';

Future initialiseHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(StudentModelAdapter());
  await openBoxes();
}
