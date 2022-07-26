import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../cubit/todo_cubit.dart';

class CalenderItemBuilder extends StatelessWidget {
  const CalenderItemBuilder({
    Key? key,
    required DateTime date,
    required int currentIndex,
  })  : _date = date,
        _currentIndex = currentIndex,
        super(key: key);
  final DateTime _date;
  final int _currentIndex;
  @override
  Widget build(BuildContext context) {
    var cubit = TodoBloc.get(context);
    int selectedIndex = TodoBloc.get(context).selectedIndex;
    return GestureDetector(
      onTap: () {
        cubit.changeDay(_currentIndex);
        cubit.getTasksWithSpecificDates(DateFormat.yMd().format(_date));
      },
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: selectedIndex == _currentIndex ? Colors.green : Colors.white,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                DateFormat('EEE').format(_date),
                style: TextStyle(
                  color: selectedIndex == _currentIndex
                      ? Colors.white
                      : Colors.black,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                '${_date.day}',
                style: TextStyle(
                  color: selectedIndex == _currentIndex
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
