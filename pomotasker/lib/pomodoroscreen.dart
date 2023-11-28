//Extends the main screen of the timer

/**
 * This is the homepage the most complicated part of the flutter project
 * This is where the main structure of of the timer and the to-do list features
 */
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'style_utils.dart';

//Import timer features
import 'package:custom_timer/custom_timer.dart';

//Import to-do features
import '/util/todo_tile.dart';
import '/util/dialog_box.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '/data/database.dart';
import 'package:pomotasker/util/todo_tile.dart';
import 'package:pomotasker/data/database.dart';

//Runns the app
void main() => runApp(PomoTasker());

//Extends the StatefulWidget
class PomoTasker extends StatefulWidget {
//Initiates the state of the timer
  @override
  _MyTimerState createState() => _MyTimerState();
}

/**
 * The program flows is it combines both timer and to-do feature in one class
 * We can improve this by separating them so we can have more control on each 
 * feature. If you want to find where the widgets was placed checkout 
 * the body inside the return statement you will find there the method 
 * that generates the timer and below it is the code of the to-do 
 * list
 */
class _MyTimerState extends State<PomoTasker>
    with SingleTickerProviderStateMixin {
  int type = 0;
  late CustomTimerController _controller = CustomTimerController(
      /**
     * Sets the controller of the timer 
     */
      vsync: this,
      begin: Duration(minutes: 00, seconds: 20), //Beginning of the timer
      end: Duration(minutes: 00, seconds: 00), //Expected end of the timer
      initialState: CustomTimerState
          .reset, //Initial state is reset which is goes back to the begin time
      interval: CustomTimerInterval
          .milliseconds); //Changes the timer time by milliseconds

  //If the session is done it disposes the timer
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  //reference the hive box
  /**
   * This gets the box (db) which was opened in the main method
   */
  final _taskBox = Hive.box('pomobox');
  ToDoDatabase db = ToDoDatabase();

/**
 * This function acts as the loading of tasks in the to-do widget 
 */
  @override
  void initState() {
    // if this is the 1st time ever opening the app, then create default data
    /**
     * You can find references /data/database.dart
     * It will load Make tutorial and do Exercises task 
     * when the user opens the app for the first time 
     */
    if (_taskBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      /**
       * If there is changes in the database (if the app was already opened once)
       * then it will load the data from the previous session (the timer resets)
       */
      // There is already existing data
      db.loadData();
    }
    super.initState();
  }

  //Text Editing controller
  /**
   * This is the controller for the add task textbox
   */
  final _tcontroller = TextEditingController();

  //This is a checkbox of the previous version of the task manager DO NOT DELETE
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
  }

  //Save new task
  /**
   * When the user press confirm button on the createNewTask it closes the dialogue 
   * saves in the database and shows the new task on the screen
   */
  void saveNewTask() {
    setState(() {
      db.toDoList.add([_tcontroller.text, false]);
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

/**
 * This creates a dialogueBox where prompts the user of the task details 
 * TODO: NEEDS TO ADD THE DEADLINE DATE FORM AND DESCRIPTION TEXTBOX
 */
  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _tcontroller,
            onSave: saveNewTask,
            onCancel: () => Navigator.of(context).pop(),
          );
        });
  }

/**
 * When the user swipes left the user needs to press the check icon to confirm if
 * the task is complete. Upon pressing it will remove the task from the database
 * This could also acts as the delete button.....
 */
  void taskComplete(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //Hugs the whole components of the app
      home: Scaffold(
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            /**
             * BuildCustomTimer is the method that creates the whole 
             * timer feature
             */
            BuildCustomTimer(_controller),
            /**
             * ListView is handles the rendering of tasks got from the databases
             * It reliles on the ToDoTile class on the 
             * todo_tile.dart file 
             * basically it also acts as the for loop of the tasks 
             */
            ListView.builder(
              shrinkWrap: true,
              itemCount: db.toDoList.length,
              itemBuilder: (context, index) {
                return ToDoTile(
                  taskName: db.toDoList[index][0],
                  taskCompleted: db.toDoList[index][1],
                  onChanged: (value) => checkBoxChanged(value, index),
                  taskCompleteFunction: (context) => taskComplete(index),
                );
              },
            ),
            /**
             * This is the button that generates the dialogue box
             */
            FloatingActionButton(
                onPressed: createNewTask, child: Icon(Icons.add)),
          ],
        ),
      ),
    );
  }
}

/**
 * This handles the working and break times of the timer 
 * a small error here is the button double inputs for some reason
 * therefore I implemented pressedOnce boolean to prevent the double input
 */
Expanded BuildCustomTimer(CustomTimerController _controller) {
  bool working = true;
  bool shortBreak = false;
  bool longBreak = false;
  bool pressedOnce = false;
  String timerType = "Working";
  _controller.state.addListener(() {
    if (_controller.state.value == CustomTimerState.finished) {
      // print("The " + _controller.state.value.toString());
      if (pressedOnce) {
        if (!working) {
          print("Back to work!");
          working = true;
          _controller.jumpTo(Duration(seconds: 20));
          pressedOnce = false;
          timerType = "Working";
        } else if (working && !shortBreak) {
          print("ShortBreak");
          working = false;
          shortBreak = true;
          timerType = "Short Break";
          _controller.jumpTo(Duration(seconds: 8));
          _controller.start();
          pressedOnce = false;
        } else if (working && shortBreak && !longBreak) {
          print("LongBreak");
          working = false;
          shortBreak = false;
          _controller.jumpTo(Duration(seconds: 12));
          _controller.start();
          timerType = "Long Break";
          pressedOnce = false;
        }
      } else {
        _controller.start();
        pressedOnce = true;
      }
    }
  });
  /**
   * This returns the timer itself which is also has the buttons 
   * and the name of the mode of timer
   */
  return Expanded(
    child: Column(children: <Widget>[
      CustomTimer(
          controller: _controller,
          builder: (state, remaining) {
            return Column(
              children: [
                Text(timerType),
                // Text("${state.name}", style: TextStyle(fontSize: 24)),
                Text("${remaining.minutes}:${remaining.seconds}",
                    style: TextStyle(fontSize: 24)),
              ],
            );
          }),
      SizedBox(height: 24.0),
      Row(
        children: [
          createButton("Start/Pause", _controller),
          createButton("Reset", _controller),
          createButton("Stop", _controller),
          createButton("Edit", _controller),
        ],
      )
    ]),
  );
}

/**
 * This is creates the button for the timer you can edit here for the front-end
 */
Expanded createButton(String button, CustomTimerController _controller) {
  return Expanded(
    child: FilledButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
      ),
      onPressed: () {
        if (button == "Start/Pause") {
          _controller.start();
        } else if (button == "Pause") {
          _controller.pause();
        } else if (button == "Reset") {
          _controller.reset();
        } else if (button == "Stop") {
          _controller.finish();
          // print("Stop button pressed");
        } else if (button == "Modify") {
          // Updated label for Edit button
          // Handle Modify button press
        }
      },
      child: Text(button),
    ),
  );
}
