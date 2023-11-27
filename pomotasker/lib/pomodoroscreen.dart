//Extends the main screen of the timer
import 'package:flutter/material.dart';
import 'style_utils.dart';
import 'package:custom_timer/custom_timer.dart';

// Expanded timer() {
//   return Expanded(
//       child: Row(children: <Widget>[
//     createButton('Start/Pause'),
//     createButton('Stop'),
//     createButton('Edit'),
//     createButton('Reset'),
//   ]));
// }

void main() => runApp(PomoTasker());

class PomoTasker extends StatefulWidget {
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       elevation: 0,
  //       backgroundColor:
  //           Colors.greenAccent, //To be changed in the preffered theme color
  //       title: Text(
  //         "PomoTasker",
  //         style: textStyle(24, Colors.redAccent,
  //             FontWeight.w700), //Refer on the utils.dart file
  //       ),
  //     ),
  //     body: Center(
  //       child: Column(children: <Widget>[timer(), timer()]),
  //     ),
  //   );
  // }

  @override
  _MyTimerState createState() => _MyTimerState();
}

class _MyTimerState extends State<PomoTasker>
    with SingleTickerProviderStateMixin {
  late CustomTimerController _controller = CustomTimerController(
      vsync: this,
      begin: Duration(minutes: 1, seconds: 05),
      end: Duration(minutes: 00, seconds: 00),
      initialState: CustomTimerState.reset,
      interval: CustomTimerInterval.milliseconds);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
            ],
          )),
    );
  }
}

Expanded BuildCustomTimer(CustomTimerController _controller) {
  String s;
  return Expanded(
    child: Column(children: <Widget>[
      CustomTimer(
          controller: _controller,
          builder: (state, remaining) {
            return Column(
              children: [
                Text("${state.name}", style: TextStyle(fontSize: 24)),
                Text("${remaining.minutes}:${remaining.seconds}",
                    style: TextStyle(fontSize: 24))
              ],
            );
            s = state.name;
          }),
      SizedBox(height: 24.0),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          createButton("Start", _controller),
        ],
      )
    ]),
  );
}

Expanded createButton(String button, var _controller) {
  return Expanded(
    child: FilledButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
      ),
      onPressed: () {
        if (button == "Start") {
          button = "Pause";
          _controller.start();
        } else if (button == "Pause") {
          button = "Start";
          _controller.pause();
        }
      },
      child: Text("Start/Pause"),
    ),
  );
}
