import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/pomodoroscreen.dart'; // Import the PomodoroScreen.dart file
import 'package:shared_preferences/shared_preferences.dart';

class GetStarted extends StatelessWidget {
  final int counter;

  GetStarted({required this.counter});
  // Function to check if it's the first time opening the app
  Future<bool> isFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('firstTime') ?? true;
  }

  // Function to mark that the app has been opened
  Future<void> markFirstTimeOpened() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('firstTime', false);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: isFirstTime(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Future is still loading, return a loading indicator or an empty container
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          // Future encountered an error, handle it accordingly
          return Scaffold(
            body: Center(
              child: Text('Error loading data'),
            ),
          );
        } else {
          bool showGetStarted = snapshot.data ?? true;

          if (showGetStarted) {
            markFirstTimeOpened(); // Mark that the app has been opened
            return _buildGetStartedScreen(context);
          } else {
            // If it's not the first time, go directly to PomoTasker screen
            return PomoTasker();
          }
        }
      },
    );
  }

  Widget _buildGetStartedScreen(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
                padding: EdgeInsets.zero,
                width: 300,
                height: 60,
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
                    Image(
                      image: AssetImage("assets/logo.png"),
                      height: 50,
                      width: 60,
                      fit: BoxFit.cover,
                    ),
                    Text(
                      "Welcome to PomoTasker",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: GoogleFonts.ubuntuMono(
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                        fontSize: 18,
                        color: Color(0xff000000), // Adjust the color as needed
                      ),
                    ),
                    Text(
                      "Your Ultimate Productivity Companion!",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: GoogleFonts.ubuntuMono(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.italic,
                        fontSize: 9,
                        color: Color(0xff000000), // Adjust the color as needed
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                width: 300,
                height: 200,
                decoration: BoxDecoration(
                  color: Color(0x00000000),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.zero,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Image(
                        image: AssetImage("assets/illustration.jpg"),
                        height: 150,
                        width: 240,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 5),
                      child: Text(
                        "Boost your productivity with our sleek Pomodoro timer! Customize your work sessions to fit your unique workflow. Whether you prefer shorter bursts of focus or longer deep work sessions, PomoTasker adapts to your needs.",
                        textAlign: TextAlign.justify,
                        overflow: TextOverflow.clip,
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 12,
                          color:
                              Color(0xff000000), // Adjust the color as needed
                        ),
                      ),
                    ),
                    Divider(
                      color: Color(0xff808080),
                      height: 18,
                      thickness: 2.5,
                      indent: 30,
                      endIndent: 30,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 5),
                      child: Text(
                        "Effortlessly manage your tasks with our intuitive to-do list feature. Add, edit, and organize your tasks seamlessly. PomoTasker helps you stay on top of your priorities.",
                        textAlign: TextAlign.justify,
                        overflow: TextOverflow.clip,
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 12,
                          color:
                              Color(0xff000000), // Adjust the color as needed
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 30, 0, 100),
              child: MaterialButton(
                onPressed: () {
                  // Navigate to PomodoroScreen.dart when the button is pressed
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PomoTasker()),
                  );
                },
                color: Color(0xfff3766e),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  "Get Started",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                  ),
                ),
                textColor: Color(0xff000000),
                height: 40,
                minWidth: 140,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
