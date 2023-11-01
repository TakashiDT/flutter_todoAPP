import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class MyButton2 extends StatelessWidget {
  final String text;

  VoidCallback onPressed;
  MyButton2({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Colors.deepPurple,
      child: Text(
        text,
        style: GoogleFonts.bebasNeue(
          textStyle: const TextStyle(
              fontSize: 20,
              letterSpacing: 2,
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
