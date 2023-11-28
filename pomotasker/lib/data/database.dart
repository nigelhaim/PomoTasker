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
      ["Make Tutorial", false],
      ["Do Exercise", false],
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
