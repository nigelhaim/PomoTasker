/**
 * Imports the material dart
 * pomodoroscreen (Main screen)
 * hive_flutter (Database)
 */

import 'package:flutter/material.dart';
import 'package:pomotasker/pomodoroscreen.dart ';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  //init the hive
  await Hive.initFlutter();

  // Open a box
  /**x
   * Basically this is the database that saves the tasks on the phone 
   */
  var box = await Hive.openBox('pomobox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: PomoTasker()); //To edit this screen open pomodoroscreen.dart
  }
}
