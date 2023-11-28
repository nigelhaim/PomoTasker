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
          child: Container(
            padding: EdgeInsets.all(24),
            child: Row(children: [
              Text(taskName),
            ]),
            decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(12)),
          ),
        ));
  }
}
