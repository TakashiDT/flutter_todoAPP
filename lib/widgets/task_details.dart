import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskDetailsPage extends StatefulWidget {
  final String title;
  final String paragraph;
  const TaskDetailsPage(
      {super.key, required this.title, required this.paragraph});

  @override
  State<TaskDetailsPage> createState() => _TaskDetailsPageState();
}

class _TaskDetailsPageState extends State<TaskDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Flutter Examination',
          style: GoogleFonts.bebasNeue(
            textStyle: const TextStyle(
                fontSize: 20,
                letterSpacing: 2,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient:
              LinearGradient(colors: [Colors.deepPurpleAccent, Colors.white30]),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  widget.title,
                  style: GoogleFonts.bebasNeue(
                    textStyle: const TextStyle(
                        fontSize: 30,
                        letterSpacing: 2,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Align(
                child: Text(
                  widget.paragraph,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
