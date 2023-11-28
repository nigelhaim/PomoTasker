import 'package:flutter/material.dart';
import 'package:pomotasker/util/box_button.dart';

/**
 * This is where the dialogue box happens where the user inputs 
 * the task details 
 * TODO: IMPROVE THE DIALOGUE BOX FOR THE OTHER TASK DETAILS 
 * TODO: IMPLEMENT DATE FORM 
 * You can refer the code to improve the form made by Angelo 
 */
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
              /**
               * Textfield for the title
               */
              TextField(
                controller: controller,
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
              Row(
                children: [
                  //TODO: IMPROVE BUTTONS CHECKOUT BOX_BUTTONS
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
