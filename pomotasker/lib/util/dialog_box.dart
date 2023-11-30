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
  final title_controller;
  final date_controller;
  final time_controller;
  final desc_controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  DialogBox({
    Key? key,
    required this.title_controller,
    required this.date_controller,
    required this.time_controller,
    required this.desc_controller,
    required this.onSave,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Title TextField
            Text("Task Name"),
            TextField(
              controller: title_controller,
              decoration: InputDecoration(
                hintText: "Task Name",
              ),
            ),

            // Date TextField
            Text("Date"),
            TextField(
              controller: date_controller,
              decoration: InputDecoration(
                labelText: 'Date',
                filled: true,
                prefixIcon: Icon(Icons.calendar_today),
              ),
              readOnly: true,
              onTap: () {
                _selectDate(context);
              },
            ),

            // Time TextField
            Text("Time"),
            TextField(
              controller: time_controller,
              decoration: InputDecoration(
                labelText: 'Time',
                filled: true,
                prefixIcon: Icon(Icons.alarm),
              ),
              readOnly: true,
              onTap: () {
                _selectTime(context);
              },
            ),

            // Description TextField
            Text("Task Description"),
            TextField(
              controller: desc_controller,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 50),
                hintText: "Insert your task description here",
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: onCancel,
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: onSave,
          child: const Text('OK'),
        ),
      ],
    );
  }

  Future<String> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(9999),
    );
    if (picked != null) {
      date_controller.text = picked.toString().split(" ")[0];
    }
    return "";
  }

  Future<String> _selectTime(BuildContext context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      time_controller.text = picked.format(context).toString();
    }
    return "";
  }
}
