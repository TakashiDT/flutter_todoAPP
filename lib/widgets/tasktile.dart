import 'package:exam_1/widgets/star_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class TodoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  final bool isPrio;

  Function(bool?)? onChanged;
  Function(bool?)? onPrioChanged;
  Function(BuildContext)? deleteFunction;

  TodoTile({
    super.key,
    required this.onChanged,
    required this.taskCompleted,
    required this.taskName,
    required this.onPrioChanged,
    required this.deleteFunction,
    required this.isPrio,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Slidable(
          endActionPane: ActionPane(
            motion: const StretchMotion(),
            children: [
              SlidableAction(
                onPressed: deleteFunction,
                icon: Icons.delete,
                backgroundColor: Colors.red,
                borderRadius: BorderRadius.circular(12),
              )
            ],
          ),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
                color: Colors.deepPurpleAccent,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(60, 12, 12, 12),
                    offset: Offset(10, 9),
                    blurRadius: 1,
                  ),
                ]),
            child: Row(
              children: [
                //My status cb
                Checkbox(
                  value: taskCompleted,
                  onChanged: onChanged,
                  checkColor: Colors.white,
                  activeColor: Colors.green,
                ),
                Expanded(
                  child: Text(
                    taskName.toUpperCase(),
                    style: GoogleFonts.bebasNeue(
                      textStyle: TextStyle(
                          color: Colors.white,
                          letterSpacing: 1,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          decoration: taskCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none),
                    ),
                  ),
                ),
                //My Priority cb
                Align(
                  alignment: Alignment.topRight,
                  child: StarCheckbox(
                    onPrioChanged: onPrioChanged,
                    isPrioritized: isPrio,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
