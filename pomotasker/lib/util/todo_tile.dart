import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
              // checkbox
              // Checkbox(
              //   value: taskCompleted,
              //   onChanged: onChanged,
              //   activeColor: Colors.green,
              // ),

              //task name
              Text(taskName),
            ]),
            decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(12)),
          ),
        ));
  }
}
