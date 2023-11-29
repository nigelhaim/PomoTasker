import 'package:hive_flutter/hive_flutter.dart';

/**
 * This is the database part of the to-do list 
 * it handles the laoding and updating functions 
 * for the database no need for front-end to touch this
 */
class ToDoDatabase {
  List toDoList = [];

  //reference our box
  final _taskBox = Hive.box('pomobox');

  void createInitialData() {
    toDoList = [
      [
        "Make Tutorial",
        false,
        11,
        22,
        2023,
        7,
        00,
        "PM",
        "Make a tutorial for flutter"
      ],
      [
        "Review Interpolation",
        false,
        11,
        22,
        2023,
        10,
        00,
        "PM",
        "Make a tutorial for flutter"
      ],
    ];
  }

  //Load the data
  void loadData() {
    toDoList = _taskBox.get("TODOLIST");
  }

  //update the database
  void updateDataBase() {
    _taskBox.put("TODOLIST", toDoList);
  }
}

class TimerData {
  final _timerBox = Hive.box('pomobox');
  Duration workTimer = Duration(minutes: 00, seconds: 00);
  void initWorkTime() {
    workTimer = Duration(minutes: 25, seconds: 00);
    _timerBox.put('WORKTIMER', {'min': 25, 'sec': 00});
  }

  void initShortTime() {
    workTimer = Duration(minutes: 10, seconds: 00);
    _timerBox.put('SHORTTIMER', {'min': 10, 'sec': 00});
  }

  void initLongTime() {
    workTimer = Duration(minutes: 15, seconds: 00);
    _timerBox.put('LONGTIMER', {'min': 15, 'sec': 00});
  }

  void updateWorkTimer(int m, int s) {
    _timerBox.put('WORKTIMER', {'min': m, 'sec': s});
    print("Updated WorkTimer");
  }

  void updateShortTimer(int m, int s) {
    _timerBox.put('SHORTTIMER', {'min': m, 'sec': s});
    print("Updated ShortTimer");
  }

  void updateLongTimer(int m, int s) {
    _timerBox.put('LONGTIMER', {'min': m, 'sec': s});
    print("Updated LongTimer");
  }

  loadWorkTimer() {
    return _timerBox.get('WORKTIMER');
  }

  loadShortTimer() {
    return _timerBox.get('SHORTTIMER');
  }

  loadLongTimer() {
    return _timerBox.get('LONGTIMER');
  }
}
