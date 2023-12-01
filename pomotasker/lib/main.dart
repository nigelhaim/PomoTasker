/**
 * Imports the material dart
 * pomodoroscreen (Main screen)
 * hive_flutter (Database)
 */
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'SplashScreen.dart'; // Adjust the import path as needed

void main() async {
  //init the hive
  await Hive.initFlutter();

  // Open a box
  /**x
   * Basically this is the database that saves the tasks on the phone
   */
  var box = await Hive.openBox('pomobox');
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(), // Display the splash screen initially
    );
  }
}
