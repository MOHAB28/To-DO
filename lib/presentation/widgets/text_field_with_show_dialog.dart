import 'package:flutter/material.dart';

import '../pages/add_task_page/add_task_page.dart';
import 'custom_text_form_field_builder.dart';

class CustomTextFormFieldBuilderWithShowDialog
    extends CustomTextFormFieldBuilder {
  CustomTextFormFieldBuilderWithShowDialog({
    Key? key,
    required TextEditingController controller,
    required String hintText,
    required BuildContext pageCtx,
    required List actions,
    required bool showTrailing,
  }) : super(
          key: key,
          controller: controller,
          hintText: hintText,
          textColor: Colors.grey[400]!,
          suffixIcon: IconButton(
            icon: Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Colors.grey[400],
              size: 25.0,
            ),
            onPressed: () {
              showDialog(
                context: pageCtx,
                builder: (context) => Dialog(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: actions
                        .map(
                          (e) => ListTile(
                            title: Text(e),
                            trailing: showTrailing
                                ? Container(
                                    height: 20.0,
                                    width: 20.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(color[e]!),
                                    ),
                                  )
                                : null,
                            onTap: () {
                              controller.text = e;
                              Navigator.pop(context);
                            },
                          ),
                        )
                        .toList(),
                  ),
                ),
              );
            },
          ),
        );
}
