import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/todo_entity.dart';
import '../../cubit/todo_cubit.dart';
import '../../cubit/todo_states.dart';
import '../../widgets/add_task_header_builder.dart';
import '../../widgets/custom_button_builder.dart';
import '../../widgets/custom_text_form_field_builder.dart';
import '../../widgets/text_field_for_date.dart';
import '../../widgets/text_field_for_time.dart';
import '../../widgets/text_field_with_show_dialog.dart';
import '../add_task_page/add_task_page.dart';

class EditTaskPage extends StatefulWidget {
  final TodoEntity todo;
  const EditTaskPage({
    Key? key,
    required this.todo,
  }) : super(key: key);

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();
  final TextEditingController _reminderController = TextEditingController();
  final TextEditingController _repeatController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  final GlobalKey _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _titleController.text = widget.todo.title;
    _dateController.text = widget.todo.date;
    _startTimeController.text = widget.todo.startTime;
    _endTimeController.text = widget.todo.endTime;
    _reminderController.text = remindAt.keys
        .firstWhere((element) => remindAt[element] == widget.todo.remind);
    _repeatController.text = widget.todo.repeat;
    _colorController.text =
        color.keys.firstWhere((element) => color[element] == widget.todo.color);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = TodoBloc.get(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit a task'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            cubit.getAllTasks('EDIT PAGE');
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocListener<TodoBloc, TodoState>(
        listener: (context, state) {
          if (state is EditTaskSuccess) {
            cubit.getAllTasks('EDIT TASK');
            Navigator.pop(context);
          }
        },
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                const AddTasksHeaderBuilder(
                  title: 'Title',
                ),
                const SizedBox(height: 10.0),
                CustomTextFormFieldBuilder(
                  hintText: 'Design team meeting',
                  controller: _titleController,
                ),

                // Date
                const SizedBox(height: 20.0),
                const AddTasksHeaderBuilder(
                  title: 'Date',
                ),
                const SizedBox(height: 10.0),
                CustomTextFormFieldBuilderWithWidgetForDate(
                  controller: _dateController,
                  pageCtx: context,
                ),

                // Start time & End time
                const SizedBox(height: 20.0),
                SizedBox(
                  height: 110,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const AddTasksHeaderBuilder(
                              title: 'Start time',
                            ),
                            const SizedBox(height: 10.0),
                            CustomTextFormFieldBuilderWithWidgetForTime(
                              controller: _startTimeController,
                              pageCtx: context,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const AddTasksHeaderBuilder(
                              title: 'End time',
                            ),
                            const SizedBox(height: 10.0),
                            CustomTextFormFieldBuilderWithWidgetForTime(
                              controller: _endTimeController,
                              pageCtx: context,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Reminder
                const SizedBox(height: 10.0),
                const AddTasksHeaderBuilder(
                  title: 'Reminder',
                ),
                const SizedBox(height: 10.0),
                CustomTextFormFieldBuilderWithShowDialog(
                  actions: remindAt.keys.toList(),
                  controller: _reminderController,
                  hintText: _reminderController.text.isEmpty
                      ? '5 minutes before'
                      : '${_reminderController.text} before',
                  pageCtx: context,
                  showTrailing: false,
                ),

                // Repeat
                const SizedBox(height: 20.0),
                const AddTasksHeaderBuilder(
                  title: 'Repeat',
                ),
                const SizedBox(height: 10.0),
                CustomTextFormFieldBuilderWithShowDialog(
                  hintText: _repeatController.text.isEmpty
                      ? 'None'
                      : _repeatController.text,
                  controller: _repeatController,
                  actions: const ['None', 'Daily'],
                  pageCtx: context,
                  showTrailing: false,
                ),

                // Color
                const SizedBox(height: 20.0),
                const AddTasksHeaderBuilder(
                  title: 'Color',
                ),
                const SizedBox(height: 10.0),
                CustomTextFormFieldBuilderWithShowDialog(
                  hintText: color.keys.first,
                  controller: _colorController,
                  actions: color.keys.toList(),
                  pageCtx: context,
                  showTrailing: true,
                ),
                const SizedBox(height: 20.0),
                CustomButtonBuilder(
                  onTap: () async {
                    if (_titleController.text.isEmpty) {
                      FlushbarHelper.createError(
                        message: 'Enter task title',
                      ).show(context);
                    } else if (_dateController.text.isEmpty) {
                      FlushbarHelper.createError(
                        message: 'Enter task Date',
                      ).show(context);
                    } else if (_startTimeController.text.isEmpty) {
                      FlushbarHelper.createError(
                        message: 'Enter task start time',
                      ).show(context);
                    } else if (_endTimeController.text.isEmpty) {
                      FlushbarHelper.createError(
                        message: 'Enter task end time',
                      ).show(context);
                    } else {
                      await cubit.editTask(
                        CubitInput(
                          notificationId: widget.todo.notificationId,
                          date: _dateController.text,
                          endTime: _endTimeController.text,
                          color: _colorController.text.isEmpty
                              ? color.values.first
                              : color[_colorController.text]!,
                          isFav: widget.todo.isFav,
                          isCompleted: widget.todo.isCompleted,
                          remind: _reminderController.text.isNotEmpty
                              ? remindAt[_reminderController.text]!
                              : remindAt.values.first,
                          repeat: _repeatController.text.isEmpty
                              ? 'None'
                              : _repeatController.text,
                          startTime: _startTimeController.text,
                          title: _titleController.text,
                        ),
                      );
                    }
                  },
                  title: 'Edit a task',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _dateController.dispose();
    _startTimeController.dispose();
    _endTimeController.dispose();
    _reminderController.dispose();
    _repeatController.dispose();
    _colorController.dispose();
    super.dispose();
  }
}
