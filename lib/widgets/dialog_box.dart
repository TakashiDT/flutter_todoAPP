import 'package:exam_1/widgets/mybuttons.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DialogBox extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController paragraphController;

  VoidCallback onSave;
  VoidCallback onCancel;
  DialogBox({
    super.key,
    required this.onSave,
    required this.onCancel,
    required this.titleController,
    required this.paragraphController,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Container(
        height: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: "Add a Task Title"),
            ),
            const SizedBox(
              width: 5,
            ),
            TextField(
              controller: paragraphController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: "Add a Task"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyButton2(text: "Save", onPressed: onSave),
                const SizedBox(width: 5),
                MyButton2(text: "Cancel", onPressed: onCancel)
              ],
            )
          ],
        ),
      ),
    );
  }
}
