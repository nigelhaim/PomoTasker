//Extends the main screen of the timer
import 'package:flutter/material.dart';
import 'utils.dart';

class PomodoroScreen extends StatelessWidget {
  Expanded createButton(String button) {
    return Expanded(
      child: FilledButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.redAccent,
          foregroundColor: Colors.white,
        ),
        onPressed: () {
          print('$button has been pressed');
        },
        child: Text(button),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor:
            Colors.greenAccent, //To be changed in the preffered theme color
        title: Text(
          "PomoTasker",
          style: textStyle(24, Colors.redAccent,
              FontWeight.w700), //Refer on the utils.dart file
        ),
      ),
      body: Center(
        child: Row(children: <Widget>[
          createButton('Start/Pause'),
          createButton('Stop'),
          createButton('Edit'),
          createButton('Reset'),
        ]),
      ),
    );
  }
}
