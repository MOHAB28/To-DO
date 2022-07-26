import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../pages/add_task_page/add_task_page.dart';
import 'custom_text_form_field_builder.dart';

class CustomTextFormFieldBuilderWithWidgetForTime
    extends CustomTextFormFieldBuilder {
  CustomTextFormFieldBuilderWithWidgetForTime({
    Key? key,
    required TextEditingController controller,
    required BuildContext pageCtx,
  }) : super(
          key: key,
          controller: controller,
          hintText: DateFormat('HH:mm a').format(DateTime.now()),
          textColor: Colors.grey[400]!,
          suffixIcon: IconButton(
            icon: Icon(
              Icons.watch_later_outlined,
              color: Colors.grey[400],
            ),
            onPressed: () async {
              TimeOfDay? time = await showTimePicker(
                context: pageCtx,
                initialTime: TimeOfDay.now(),
                initialEntryMode: TimePickerEntryMode.input,
              );
              if (time != null) {
                controller.text = formatTimeOfDay(time);
              }
            },
          ),
        );
}
