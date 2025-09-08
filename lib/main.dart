import 'package:flutter/material.dart';
import 'package:test/screens/homescreen.dart';

void main() {
  runApp(TodoApp());

}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Homescreen(),
    );
  }
}
