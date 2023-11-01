import 'package:flutter/material.dart';

class StarCheckbox extends StatefulWidget {
  final bool isPrioritized;
  final ValueChanged<bool?>? onPrioChanged;

  StarCheckbox({
    required this.isPrioritized,
    required this.onPrioChanged,
  });

  @override
  _StarCheckboxState createState() => _StarCheckboxState();
}

class _StarCheckboxState extends State<StarCheckbox> {
  bool isprio = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {
        widget.onPrioChanged?.call(!widget.isPrioritized);
      },
      child: IconButton(
          icon: Icon(
            widget.isPrioritized ? Icons.bookmark : Icons.bookmark,
            color: widget.isPrioritized ? Colors.yellow : Colors.grey,
            size: 40,
          ),
          onPressed: null),
    );
  }
}
