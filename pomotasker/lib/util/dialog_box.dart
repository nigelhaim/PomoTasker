import 'package:flutter/material.dart';
import 'package:pomotasker/util/box_button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.redAccent,
      content: Container(
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                controller: controller,
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
              Row(
                children: [
                  box_button(text: "Canel", onPressed: onCancel),
                  const SizedBox(
                    width: 8,
                  ),
                  box_button(text: "Confirm", onPressed: onSave),
                ],
              )
            ],
          )),
    );
  }
}
