import 'package:flutter/material.dart';

class box_button extends StatelessWidget {
  final String text;
  VoidCallback onPressed;
  box_button({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        onPressed: onPressed,
        color: Colors.black,
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ));
  }
}
