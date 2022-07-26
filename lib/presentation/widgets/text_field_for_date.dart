import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'custom_text_form_field_builder.dart';

class CustomTextFormFieldBuilderWithWidgetForDate extends CustomTextFormFieldBuilder {
  CustomTextFormFieldBuilderWithWidgetForDate({
    Key? key,
    required TextEditingController controller,
    required BuildContext pageCtx,
  }) : super(
          key: key,
          controller: controller,
          hintText: DateFormat.yMd().format(DateTime.now()),
          textColor: Colors.grey[400]!,
          suffixIcon: IconButton(
            icon: Icon(
              Icons.calendar_month,
              color: Colors.grey[400],
            ),
            onPressed:() async {
                  DateTime? date = await showDatePicker(
                    context: pageCtx,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1990),
                    lastDate: DateTime(2120),
                  );
                  if (date != null) {
                    controller.text = DateFormat.yMd().format(date);
                  }
                },
          ),
        );
}
