import 'package:flutter/material.dart';
import '../../domain/entities/todo_entity.dart';
import '../cubit/todo_cubit.dart';

class ScheduleItemBuilder extends StatelessWidget {
  const ScheduleItemBuilder({
    Key? key,
    required TodoEntity todo,
  })  : _todo = todo,
        super(key: key);
  final TodoEntity _todo;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Color(_todo.color),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _todo.startTime,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                _todo.title,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          _todo.isCompleted
              ? CircleCustomCheckBox(
                  isComplete: true,
                  id: _todo.id,
                  time: _todo.date,
                )
              : CircleCustomCheckBox(
                  isComplete: false,
                  id: _todo.id,
                  time: _todo.date,
                ),
        ],
      ),
    );
  }
}

class CircleCustomCheckBox extends StatelessWidget {
  const CircleCustomCheckBox({
    Key? key,
    required bool isComplete,
    required int id,
    required String time,
  })  : _isComplete = isComplete,
        _id = id,
        _time = time,
        super(key: key);
  final bool _isComplete;
  final int _id;
  final String _time;
  @override
  Widget build(BuildContext context) {
    var cubit = TodoBloc.get(context);
    return GestureDetector(
      onTap: _isComplete
          ? () {
            cubit.completeTheTask(id: _id, isComplete: 0).whenComplete(() => cubit.getTasksWithSpecificDates(_time));
            
            }
          : () {
            cubit.completeTheTask(id: _id, isComplete: 1).whenComplete(() => cubit.getTasksWithSpecificDates(_time));
            
            },
      child: Container(
        height: 20.0,
        width: 20.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            width: 1.0,
            color: Colors.white,
          ),
        ),
        child: _isComplete
            ? const Center(
                child: Icon(
                  Icons.done_rounded,
                  size: 15.0,
                  color: Colors.white,
                ),
              )
            : null,
      ),
    );
  }
}
