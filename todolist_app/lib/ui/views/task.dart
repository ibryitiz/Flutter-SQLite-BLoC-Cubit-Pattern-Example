import 'package:flutter/material.dart';

class Task extends StatelessWidget {
  const Task({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Task Page", style: TextStyle(color: Colors.purple[900], fontSize: 36, fontWeight: FontWeight.bold),),
    );
  }
}