import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../cubit/todo_cubit.dart';
import '../../widgets/custom_button_builder.dart';
import '../add_task_page/add_task_page.dart';
import '../schedule_page/schedule_page.dart';
import '../search_page/search_page.dart';
import 'all_tasks_page/all_tasks_page.dart';
import 'completed_tasks_page/complete_task_page.dart';
import 'favorite_tasks_page/favorite_tasks_page.dart';
import 'uncompleted_tasks_page/uncomplete_task_page.dart';

class BoardPage extends StatefulWidget {
  const BoardPage({Key? key}) : super(key: key);

  @override
  State<BoardPage> createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> {
  @override
  void initState() {
    TodoBloc.get(context).getAllTasks('BOARD PAGE');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = TodoBloc.get(context);
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Board'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (context) => const SearchPage()),
                );
              },
              icon: const Icon(Icons.search),
            ),
            IconButton(
              onPressed: () {
                TodoBloc.get(context).changeDay(0);

                Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => const SchedulePage()),
                );
              },
              icon: const Icon(Icons.calendar_today_rounded),
            ),
          ],
          bottom: TabBar(
            indicatorColor: Colors.black,
            isScrollable: false,
            physics: const NeverScrollableScrollPhysics(),
            labelPadding: EdgeInsets.zero,
            onTap: (int index) {
              if (index == 0) {
                cubit.getAllTasks('ON TAP BOARD');
              } else if (index == 1) {
                cubit.getCompletedTasks();
              } else if (index == 2) {
               cubit.getUncompletedTasks();
              } else if (index == 3) {
                cubit.getFavTasks();
              }
            },
            tabs: const [
              Tab(text: 'All'),
              Tab(text: 'Completed'),
              Tab(text: 'Uncompleted'),
              Tab(text: 'Favorite'),
            ],
          ),
        ),
        body: const TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            AllTasksPage(),
            CompleteTaskPage(),
            UnCompleteTaskPage(),
            FavoriteTasksPage(),
          ],
        ),
        bottomSheet: Container(
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomButtonBuilder(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddTaskPage(),
                      fullscreenDialog: true,
                    ),
                  );
                },
                title: 'Add a task',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
