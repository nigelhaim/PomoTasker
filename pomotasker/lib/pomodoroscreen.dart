//Extends the main screen of the timer
import 'package:flutter/material.dart';
import 'package:pomotasker/data/database.dart';
import 'package:pomotasker/util/todo_tile.dart';
import 'style_utils.dart';

//Import timer features
import 'package:custom_timer/custom_timer.dart';


//Import to-do features
import '/util/todo_tile.dart';
import '/util/dialog_box.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '/data/database.dart';

void main() => runApp(PomoTasker());

class PomoTasker extends StatefulWidget {
  @override
  _MyTimerState createState() => _MyTimerState();
}

class _MyTimerState extends State<PomoTasker>
    with SingleTickerProviderStateMixin {
  int type = 0;
  late CustomTimerController _controller = CustomTimerController(
      /**
     * Sets the controller of the timer 
     */
      vsync: this,
      begin: Duration(minutes: 00, seconds: 20),
      end: Duration(minutes: 00, seconds: 00),
      initialState: CustomTimerState.reset,
      interval: CustomTimerInterval.milliseconds);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  //reference the hive box
  final _taskBox = Hive.box('pomobox');
  ToDoDatabase db = ToDoDatabase();

  @override
  void initState() {
    // if this is the 1st time ever opening the app, then create default data
    if (_taskBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      // There is already existing data
      db.loadData();
    }
    super.initState();
  }

  //Text Editing controller
  final _tcontroller = TextEditingController();

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
  }

  //Save new task
  void saveNewTask() {
    setState(() {
      db.toDoList.add([_tcontroller.text, false]);
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

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
            BuildCustomTimer(_controller),
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
            FloatingActionButton(
                onPressed: createNewTask, child: Icon(Icons.add)),//Nigel's button 
              taskButton(), //Angelo's button
          ],
        ),
      ),
    );
  }
}

class taskButton extends StatelessWidget {
  const taskButton({super.key});
  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Add Task'),
          content: Column(
            children: [
              Text("Task Name"),
              const TextField(
                decoration: InputDecoration(
                  hintText: "Task Name",
                ),
              ),
              Text("Date & Time"),
              const TextField(
                decoration: InputDecoration(
                  hintText: "mm/dd//yy hh:mm",
                ),
              ),
              Text("Task Description"),
              const TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 50),
                  hintText: "Insert your task description here",
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      ),
      child: const Text('Add Task'),
    );
  }
}

class timerButtons extends StatelessWidget {
  const timerButtons({super.key});
  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Edit Timer'),
          content: Column(
            children: [
              const Text("Work Time"),
              const TextField(
                decoration: InputDecoration(
                  hintText: "25:00",
                ),
              ),
              const Text("Short Break"),
              const TextField(
                decoration: InputDecoration(
                  hintText: "5:00",
                ),
              ),
              const Text("Long Break"),
              const TextField(
                decoration: InputDecoration(
                  hintText: "15:00",
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      ),
      child: const Text('Edit Timer'),
    );
  }
}

Expanded buildCustomTimer(CustomTimerController _controller) {
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
          _controller.jumpTo(const Duration(seconds: 20));
          pressedOnce = false;
          timerType = "Working";
        } else if (working && !shortBreak) {
          print("ShortBreak");
          working = false;
          shortBreak = true;
          timerType = "Short Break";
          _controller.jumpTo(const Duration(seconds: 8));
          _controller.start();
          pressedOnce = false;
        } else if (working && shortBreak && !longBreak) {
          print("LongBreak");
          working = false;
          shortBreak = false;
          _controller.jumpTo(const Duration(seconds: 12));
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
                    style: const TextStyle(fontSize: 24)),
              ],
            );
          }),
      const SizedBox(height: 24.0),
      Row(
        children: [
          createButton("Start/Pause", _controller),
          createButton("Reset", _controller),
          createButton("Stop", _controller),
          timerButtons(),
        ],
      )
    ]),
  );
}

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
          timerButtons();
        }
      },
      child: Text(button),
    ),
  );
}
