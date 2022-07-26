import 'package:flutter/material.dart';

class CustomButtonBuilder extends StatelessWidget {
  const CustomButtonBuilder({
    Key? key,
    required String title,
    required VoidCallback onTap,
  })  : _title = title,
        _onTap = onTap,
        super(key: key);

  final String _title;
  final VoidCallback _onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _onTap();
      },
      child: Container(
        margin: const EdgeInsets.all(20.0),
        height: 60.0,
        decoration: BoxDecoration(
          color: const Color(0xff25C06D),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            _title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
