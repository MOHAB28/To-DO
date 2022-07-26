import 'package:flutter/material.dart';


class AddTasksHeaderBuilder extends StatelessWidget {
  const AddTasksHeaderBuilder({
    Key? key,
    required String title,
  }) : 
  _title = title,
  super(key: key);
  final String _title;
  @override
  Widget build(BuildContext context) {
    return Text(
      _title,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 16.0,
      ),
    );
  }
}