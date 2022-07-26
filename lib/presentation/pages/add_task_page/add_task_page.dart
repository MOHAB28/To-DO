import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_task2/presentation/cubit/todo_states.dart';
import '../../../core/services/notification_services.dart';
import '../../cubit/todo_cubit.dart';
import '../../widgets/add_task_header_builder.dart';
import '../../widgets/custom_button_builder.dart';
import '../../widgets/custom_text_form_field_builder.dart';
import '../../widgets/text_field_for_date.dart';
import '../../widgets/text_field_for_time.dart';
import '../../widgets/text_field_with_show_dialog.dart';

String formatTimeOfDay(TimeOfDay tod) {
  final now = DateTime.now();
  final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
  final format = DateFormat.jm(); //"6:00 AM"
  return format.format(dt);
}

Map<String, int> remindAt = {
  '5 mins before': 5,
  '10 mins before': 10,
  '30 mins before': 30,
  '1 hour before': 60,
  '1 day before': 1440,
};

Map<String, int> color = {
  'Red': 0xffff0000,
  'Pink': 0xffeb1e62,
  'Yellow': 0xffffff00,
  'Orange': 0xffff9900,
  'Green': 0xff00ff00,
  'Blue': 0xff0000ff,
};

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();
  final TextEditingController _reminderController = TextEditingController();
  final TextEditingController _repeatController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();

  final GlobalKey _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var cubit = TodoBloc.get(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add task'),
      ),
      body: BlocListener<TodoBloc,TodoState>(
        listener: (context, state) {
          if(state is AddTaskSuccess) {
            cubit.getAllTasks('ADD TASK');
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
                      await  cubit.addTasks(
                        CubitInput(
                          notificationId: id,
                          date: _dateController.text,
                          endTime: _endTimeController.text,
                          color: _colorController.text.isEmpty
                              ? color.values.first
                              : color[_colorController.text]!,
                          isFav: false,
                          isCompleted: false,
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
                  title: 'Create a task',
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
