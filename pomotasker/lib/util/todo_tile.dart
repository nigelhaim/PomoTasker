import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

/**
 * This is handles the tile of the to-do list in the main screen 
 * it uses a flutter_slidable package
 * TODO: IMPROVE THE SLIDING PART
 * TODO: MAKE A BUTTON THAT OPENS THE FORM FOR THE EDIT
 */
class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;

  Function(BuildContext)? taskCompleteFunction;

  ToDoTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.taskCompleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        //This handles the slidable part of the program
        child: Slidable(
          endActionPane: ActionPane(
            motion: StretchMotion(),
            children: [
              SlidableAction(
                onPressed: taskCompleteFunction,
                icon: Icons.check,
                backgroundColor: Colors.blue,
              )
            ],
          ),
          child: /*Container(
            padding: EdgeInsets.all(27),
            child: Row(children: [
              Text(taskName),
            ]),
            decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(12)),
          ), */


          //container for task
          Container(
            margin: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            padding: EdgeInsets.all(0),
            width: 300,
            height: 70,
            decoration: BoxDecoration(
              color: Color(0xffc55e57),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  margin: EdgeInsets.all(0),
                  padding: EdgeInsets.all(0),
                  width: 60,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Color(0xfff2766e),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Icon(
                    Icons.arrow_back,
                    color: Color(0xff212435),
                    size: 24,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,                    
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(taskName,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontStyle: FontStyle.normal,
                              fontSize: 20,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
        ));
  }
}
