//Extends the main screen of the timer

import 'package:flutter/material.dart';
import 'style_utils.dart';

//Import timer features
import 'package:custom_timer/custom_timer.dart';

//Import to-do features
import '/util/todo_tile.dart';
import '/util/dialog_box.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '/data/database.dart';

import 'package:pomotasker/util/task_Button.dart';
import 'package:google_fonts/google_fonts.dart';

//Runs the app
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

Duration getWorkTime() {
  final _timerBox = Hive.box('pomobox');
  TimerData tb = TimerData();
  if (_timerBox.get("WORKTIMER") == null) {
    tb.initWorkTime();
  } else {
    tb.loadWorkTimer();
  }
  final time = tb.loadWorkTimer();
  Duration wt = Duration(minutes: time?['min'], seconds: time?['sec']);
  return wt;
}

Duration getShortTime() {
  final _timerBox = Hive.box('pomobox');
  TimerData tb = TimerData();
  if (_timerBox.get("SHORTTIMER") == null) {
    tb.initShortTime();
  } else {
    tb.loadShortTimer();
  }
  final time = tb.loadShortTimer();
  Duration wt = Duration(minutes: time?['min'], seconds: time?['sec']);
  return wt;
}

Duration getLongTime() {
  final _timerBox = Hive.box('pomobox');
  TimerData tb = TimerData();
  if (_timerBox.get("LONGTIMER") == null) {
    tb.initLongTime();
  } else {
    tb.loadLongTimer();
  }
  final time = tb.loadLongTimer();
  Duration wt = Duration(minutes: time?['min'], seconds: time?['sec']);
  return wt;
}

Duration workTime = getWorkTime();
Duration shortTime = getShortTime();
Duration longTime = getLongTime();

class _MyTimerState extends State<PomoTasker>
    with SingleTickerProviderStateMixin {
  int type = 0;
  late CustomTimerController _controller = CustomTimerController(
      /**
     * Sets the controller of the timer
     */

      vsync: this,
      begin: workTime,
      //Beginning of the timer
      end: Duration(minutes: 00, seconds: 00),
      //Expected end of the timer
      initialState: CustomTimerState.reset,
      //Initial state is reset which is goes back to the begin time
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
  final _title_controller = TextEditingController();

  // final _month_controller = TextEditingController();
  // final _day_controller = TextEditingController();
  // final _year_controller = TextEditingController();
  // final _hour_controller = TextEditingController();
  // final _min_controller = TextEditingController();
  // final _am_pm_controller = TextEditingController();
  final _date_controller = TextEditingController();
  final _time_controller = TextEditingController();
  final _desc_controller = TextEditingController();

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
      db.toDoList.add([
        _title_controller.text,
        false,
        // _month_controller.text,
        // _day_controller.text,
        // _year_controller.text,
        // _hour_controller.text,
        // _min_controller.text,
        // _am_pm_controller.text,
        _date_controller.text,
        _time_controller.text,
        _desc_controller.text
      ]);
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
            title_controller: _title_controller,
            // month_controller: _month_controller,
            // day_controller: _day_controller,
            // year_controller: _year_controller,
            // hour_controller: _hour_controller,
            // min_controller: _min_controller,
            // am_pm_controller: _am_pm_controller,
            date_controller: _date_controller,
            time_controller: _time_controller,
            desc_controller: _desc_controller,
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
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFFF0F4F4),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xFFF0F4F4),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              // Logo & app name
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    // Logo
                    Image(
                      image: AssetImage("assets/logo.png"),
                      height: 40,
                      width: 60,
                      fit: BoxFit.scaleDown,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                      // App name
                      child: Text(
                        "PomoTasker",
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.clip,
                        style: GoogleFonts.ubuntuMono(
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                          color: Color(0xFFC65F58),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            // Timer portion
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  // "timer text
                  Expanded(
                    flex: 3,
                    child: BuildCustomTimer(_controller),
                  ),
                ],
              ),
            ),

            // Centered ListView for rendering tasks
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: ListView.builder(
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
                ),
              ),
            ),

            // Button that generates the dialogue box
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: FloatingActionButton(
                onPressed: createNewTask,
                backgroundColor: Color(0xFFF2756D), // Set color to F2756D
                child: Icon(
                  Icons.add,
                  size: 35, // Increase size by 2
                  color: Colors.white, // Set color to white
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class timerButtons extends StatelessWidget {
  TextEditingController _workMinutes = TextEditingController();
  TextEditingController _workSeconds = TextEditingController();
  TextEditingController _shortMinutes = TextEditingController();
  TextEditingController _shortSeconds = TextEditingController();
  TextEditingController _longMinutes = TextEditingController();
  TextEditingController _longSeconds = TextEditingController();

  Duration workTime = getWorkTime();
  Duration shortTime = getShortTime();
  Duration longTime = getLongTime();

  final _timerBox = Hive.box('pomobox');
  TimerData tb = TimerData();
  timerButtons({super.key});
  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: TextButton.styleFrom(
        backgroundColor: Color.fromRGBO(242, 117, 109, 1.0),
        foregroundColor: Color.fromRGBO(54, 54, 54, 1.0),
      ),
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          backgroundColor: Color.fromRGBO(242, 117, 109, 1.0),
          title: const Center(
              child: Text(
            'Edit Timer',
            style: TextStyle(fontWeight: FontWeight.w900),
          )),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Work Time",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.only(right: 10),
                        width: 90,
                        child: TextField(
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                          controller: _workMinutes,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: workTime.inMinutes.toString(),
                          ),
                        ),
                      ),
                      Text(":",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        width: 90,
                        child: TextField(
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                          controller: _workSeconds,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '00',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Text(
                "Short Break",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.only(right: 10),
                        width: 90,
                        child: TextField(
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                          controller: _shortMinutes,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: shortTime.inMinutes.toString(),
                          ),
                        ),
                      ),
                      Text(":",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        width: 90,
                        child: TextField(
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                          controller: _shortSeconds,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '00',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Text(
                "Long Break",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 90,
                      padding: EdgeInsets.only(right: 10),
                      child: TextField(
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                        controller: _longMinutes,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: longTime.inMinutes.toString(),
                        ),
                      ),
                    ),
                    Text(
                      ":",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Container(
                      width: 90,
                      padding: EdgeInsets.only(left: 10),
                      child: TextField(
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                        controller: _longSeconds,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '00',
                        ),
                      ),
                    ),
                  ],
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
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(363636),
                disabledBackgroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context, 'OK');
                tb.updateWorkTimer(
                    int.parse(_workMinutes.text), int.parse(_workSeconds.text));
                tb.updateShortTimer(int.parse(_shortMinutes.text),
                    int.parse(_shortSeconds.text));
                tb.updateLongTimer(
                    int.parse(_longMinutes.text), int.parse(_longSeconds.text));
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      child: const Text(
        'Edit Timer',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: 'UbuntuMono',
          fontSize: 16, // Set the font size
          color: Color(0xFF363636),
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

Column BuildCustomTimer(CustomTimerController _controller) {
  bool working = true;
  bool shortBreak = false;
  bool longBreak = false;
  bool pressedOnce = false;
  String timerType = "Time to Work!";
  _controller.state.addListener(() {
    if (_controller.state.value == CustomTimerState.finished) {
      // print("The " + _controller.state.value.toString());
      workTime = getWorkTime();
      _controller.begin = workTime;
      shortTime = getShortTime();
      longTime = getLongTime();
      if (pressedOnce) {
        if (!working) {
          print("Back to work!");
          working = true;
          _controller.jumpTo(workTime);
          pressedOnce = false;
          timerType = "Working";
        } else if (working && !shortBreak) {
          print("ShortBreak");
          working = false;
          shortBreak = true;
          timerType = "Short Break";
          _controller.jumpTo(shortTime);
          _controller.start();
          pressedOnce = false;
        } else if (working && shortBreak && !longBreak) {
          print("LongBreak");
          working = false;
          shortBreak = false;
          _controller.jumpTo(longTime);
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
  return Column(
    children: [
      CustomTimer(
        controller: _controller,
        builder: (state, remaining) {
          return Column(
            children: [
              Text(
                timerType,
                style: GoogleFonts.ubuntu(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
              Text(
                "${remaining.minutes}:${remaining.seconds}",
                style: GoogleFonts.ubuntuMono(
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  fontSize: 95,
                  color: Color(0xFF363636), // Change the color as needed
                ),
              ),
            ],
          );
        },
      ),

      //buttons container
      Expanded(
        flex: 1,

        //container that contains all the 4 text buttons
        child: Container(
          margin: EdgeInsets.all(0),
          padding: EdgeInsets.all(0),
          width: 270,
          height: 85,
          decoration: BoxDecoration(
            color: Color(0x00000000),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.zero,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 1,

                //container that contains the 2 top buttons (start/pause, stop)
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(0),
                  padding: EdgeInsets.all(0),
                  width: 270,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Color(0x00000000),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.zero,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      //start/pause text button
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                          child: createButton("Start", _controller),
                        ),
                      ),

                      //stop text button
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                          child: createButton("Stop", _controller),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 5.0),
              Expanded(
                flex: 1,

                //container that contains the 2 bottom buttons (edit, reset)
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(0),
                  padding: EdgeInsets.all(0),
                  width: 300,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Color(0x00000000),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.zero,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      //edit text button
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                          child: timerButtons(),
                        ),
                      ),

                      //reset text button
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                          child: createButton("Reset", _controller),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

/**
 * This is creates the button for the timer you can edit here for the front-end
 */

Expanded createButton(String button, CustomTimerController _controller) {
  return Expanded(
    child: FilledButton(
      style: TextButton.styleFrom(
        backgroundColor: Color.fromRGBO(242, 117, 109, 1.0),
        foregroundColor: Color.fromRGBO(54, 54, 54, 1.0),
      ),
      onPressed: () {
        if (button == "Start") {
          const Text("Pause");
          _controller.start();
        } else if (button == "Pause") {
          _controller.pause();
        } else if (button == "Reset") {
          _controller.reset();
          workTime = getWorkTime();
          shortTime = getShortTime();
          longTime = getLongTime();
        } else if (button == "Stop") {
          _controller.finish();
          // print("Stop button pressed");
        } else if (button == "Modify") {
          timerButtons();
        }
      },
      child: Text(
        button,
        style: GoogleFonts.ubuntu(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Color(0xFF363636),
        ),
      ),
    ),
  );
}
