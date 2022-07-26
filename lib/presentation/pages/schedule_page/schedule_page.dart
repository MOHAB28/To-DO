import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../cubit/todo_cubit.dart';
import '../../cubit/todo_states.dart';
import '../../widgets/calender_item_builder.dart';
import '../../widgets/schdule_item_builder.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  List<DateTime> _items = [];
  @override
  void initState() {
    _items = [];
    _items = List<DateTime>.generate(
      360,
      (i) => DateTime.utc(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      ).add(Duration(days: i)),
    );
    TodoBloc.get(context)
        .getTasksWithSpecificDates(DateFormat.yMd().format(DateTime.now()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = TodoBloc.get(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            cubit.getAllTasks('SCHEDULE PAGE');
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: 100,
                child: ListView.separated(
                  itemCount: _items.length,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.all(20.0),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (ctx, i) {
                    return CalenderItemBuilder(
                      date: _items[i],
                      currentIndex: i,
                    );
                  },
                  separatorBuilder: (ctx, i) {
                    return const SizedBox(width: 20.0);
                  },
                ),
              ),
              if (state is GetTasksBySpecificDateLoading) ...[
                const Center(child: Text('Loading...')),
              ] else if (state is GetTasksBySpecificDateSuccess) ...[
                if (state.todos.isEmpty) ...[
                  const Center(
                    child: Text('No tasks at this date'),
                  ),
                ] else ...[
                  ListView.separated(
                    padding: const EdgeInsets.all(10.0),
                    itemCount: state.todos.length,
                    shrinkWrap: true,
                    itemBuilder: (ctx, i) {
                      return ScheduleItemBuilder(
                        todo: state.todos[i],
                      );
                    },
                    separatorBuilder: (ctx, i) {
                      return const SizedBox(height: 15.0);
                    },
                  ),
                ]
              ]
            ],
          );
        },
      ),
    );
  }
}
