import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'GetStarted.dart'; // Import your GetStarted2.dart file

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Delay for 2 seconds (adjust as needed)
    Timer(Duration(seconds: 2), () {
      // Navigate to GetStarted screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => GetStarted(counter: 0), // Provide the initial value for counter
        ),
      );
    });
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
