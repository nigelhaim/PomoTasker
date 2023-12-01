// import 'package:flutter/material.dart';

// class taskButton extends StatelessWidget {
//   const taskButton({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return FilledButton(
//       onPressed: () => showDialog<String>(
//         context: context,
//         builder: (BuildContext context) => AlertDialog(
//           content: Column(
//             children: [
//               Text("Task Name"),
//               const TextField(
//                 decoration: InputDecoration(
//                   hintText: "Task Name",
//                 ),
//               ),
//               Text("Date & Time"),
//               const TextField(
//                 decoration: InputDecoration(
//                   hintText: "mm/dd//yy hh:mm",
//                 ),
//               ),
//               Text("Task Description"),
//               const TextField(
//                 decoration: InputDecoration(
//                   contentPadding: EdgeInsets.symmetric(vertical: 50),
//                   hintText: "Insert your task description here",
//                 ),
//               ),
//             ],
//           ),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () => Navigator.pop(context, 'Cancel'),
//               child: const Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () => Navigator.pop(context, 'OK'),
//               child: const Text('OK'),
//             ),
//           ],
//         ),
//       ),
//       child: const Icon(Icons.add),
//     );
//   }
// }
