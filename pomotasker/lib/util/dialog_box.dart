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
      scrollable: true,
      actionsAlignment: MainAxisAlignment.center,
      backgroundColor: Colors.redAccent,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Title TextField
          Text(
            "Task Name",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.white,
            ),
            child: TextField(
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              controller: title_controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Insert Task Name Here",
              ),
            ),
          ),
          // Date TextField
          Text(
            "Date",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.white,
            ),
            child: TextField(
              controller: date_controller,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                filled: false,
              ),
              readOnly: true,
              onTap: () {
                _selectDate(context);
              },
            ),
          ),

          // Time TextField
          Text(
            "Time",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.white,
            ),
            child: TextField(
              controller: time_controller,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                filled: false,
              ),
              readOnly: true,
              onTap: () {
                _selectTime(context);
              },
            ),
          ),
          // Description TextField
          Text(
            "Task Description",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.white,
            ),
            child: TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              controller: desc_controller,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10),
                hintText: "Insert your task description here",
              ),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(0, 22, 71, 62),
            disabledBackgroundColor: Colors.white,
          ),
          onPressed: onCancel,
          child: const Text(
            'Cancel',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(0, 22, 71, 62),
            disabledBackgroundColor: Colors.white,
          ),
          onPressed: onSave,
          child: const Text(
            'OK',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
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
