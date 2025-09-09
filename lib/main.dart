import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:test/database/hive_setup.dart';
import 'package:test/screens/homescreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialiseHive();
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.purpleAccent,
        ),
      ),

      debugShowCheckedModeBanner: false,
      home: Homescreen(),
    );
  }
}
