import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pomotasker/pomodoroscreen.dart'; // Adjust the import path as needed

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(milliseconds: 1900), // Adjust the duration as needed
          () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => PomoTasker(), // Navigate to your main screen
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Image(
                image: AssetImage("assets/logo.png"), // Adjust the image path
                height: 130,
                width: 170,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                "PomoTasker",
                textAlign: TextAlign.center,
                overflow: TextOverflow.clip,
                style: GoogleFonts.ubuntuMono(
                  fontWeight: FontWeight.w800,
                  fontStyle: FontStyle.normal,
                  fontSize: 30,
                  color: Color(0xffca615a), // Adjust the color as needed
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
