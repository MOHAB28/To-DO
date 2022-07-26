import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/todo_entity.dart';
import '../../cubit/todo_cubit.dart';
import '../../cubit/todo_states.dart';
import '../../widgets/custom_text_form_field_builder.dart';
import '../../widgets/task_item_builder.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  void _searchBloc() {
    TodoBloc.get(context).searchInTasks(_searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    var cubit = TodoBloc.get(context);
    List<TodoEntity> searchedTasks = TodoBloc.get(context).searchedTasks;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            cubit.getAllTasks('serch');
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                CustomTextFormFieldBuilder(
                  hintText: 'Search on title',
                  controller: _searchController,
                  onChanged: (String value) {
                    cubit.searchInTasks(value);
                  },
                ),
                if (_searchController.text.isEmpty) ...[
                  const Center(
                    child: Text('Enter title'),
                  ),
                ] else ...[
                  if (state is SearchInTasksLoading) ...[
                    const Center(child: Text('Loading...')),
                  ] else if (state is SearchInTasksSuccess) ...[
                    if (state.todos.isEmpty) ...[
                      const Center(
                        child: Text('No tasks'),
                      ),
                    ] else ...[
                      ListView.builder(
                        itemCount: state.todos.length,
                        shrinkWrap: true,
                        itemBuilder: (ctx, i) {
                          return TaskItemBuilder(
                            todo: state.todos[i],
                            event: _searchBloc,
                          );
                        },
                      ),
                    ]
                  ] else ...[
                    ListView.builder(
                      itemCount: searchedTasks.length,
                      shrinkWrap: true,
                      itemBuilder: (ctx, i) {
                        return TaskItemBuilder(
                          todo: searchedTasks[i],
                          event: _searchBloc,
                        );
                      },
                    ),
                  ]
                ]
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void deactivate() async {
    await TodoBloc.get(context).getAllTasks('serch dispose');

    super.deactivate();
  }
}
