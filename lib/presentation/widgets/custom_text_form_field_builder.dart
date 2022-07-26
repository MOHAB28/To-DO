import 'package:flutter/material.dart';

class CustomTextFormFieldBuilder extends StatelessWidget {
  const CustomTextFormFieldBuilder({
    Key? key,
    required String hintText,
    required TextEditingController controller,
    void Function(String)? onChanged,
    double borderRadius = 10,
    Color textColor = Colors.black,
    Widget? suffixIcon,
  })  : _hintText = hintText,
        _borderRadius = borderRadius,
        _textColor = textColor,
        _suffixIcon = suffixIcon,
        _controller = controller,
        _onChanged = onChanged,
        super(key: key);

  final String _hintText;
  final double _borderRadius;
  final Color _textColor;
  final Widget? _suffixIcon;
  final void Function(String)? _onChanged;
  final TextEditingController _controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        color: _textColor,
      ),
      controller: _controller,
      onChanged: _onChanged,
      readOnly: _suffixIcon == null ? false : true,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
        hintText: _hintText,
        hintStyle: TextStyle(color: Colors.grey[400]),
        fillColor: Colors.grey[200],
        filled: true,
        suffixIcon: _suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
          borderSide: BorderSide.none,
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
          borderSide: BorderSide.none,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

