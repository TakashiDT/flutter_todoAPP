import 'package:exam_1/widgets/deletedtaskpage.dart';
import 'package:exam_1/widgets/homepage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

// ignore: must_be_immutable
class DrawerFb1 extends StatelessWidget {
  int activeScreenIndex = 0;
  DrawerFb1({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.deepPurple,
        child: ListView(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  Text(
                    "TODO APP",
                    style: GoogleFonts.bebasNeue(
                      textStyle: const TextStyle(
                          fontSize: 30,
                          letterSpacing: 2,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 12),
                  MenuItem(
                    text: 'All tasks',
                    icon: Icons.book,
                    onClicked: () => selectedItem(context, 0),
                  ),
                  const SizedBox(height: 5),
                  MenuItem(
                    text: 'Priority Tasks',
                    icon: Icons.bookmark,
                    onClicked: () => selectedItem(context, 1),
                  ),
                  const SizedBox(height: 5),
                  MenuItem(
                    text: 'Completed Tasks',
                    icon: Icons.check_box,
                    onClicked: () => selectedItem(context, 2),
                  ),
                  const SizedBox(height: 5),
                  MenuItem(
                    text: 'Deleted Taks',
                    icon: Icons.delete,
                    onClicked: () => selectedItem(context, 3),
                  ),
                  const SizedBox(height: 8),
                  const Divider(color: Colors.white70),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

int activeScreenIndex = 0;

void selectedItem(BuildContext context, int index) {
  Navigator.of(context).pop();

  if (index != activeScreenIndex) {
    activeScreenIndex = index;

    switch (index) {
      case 0:
        Navigator.of(context).pushReplacement(
          PageTransition(
            child: const HomePage(
              showOnlyPrioritized: false,
              showOnlyTaskCompleted: false,
            ),
            type: PageTransitionType.fade,
          ),
        );

        break;

      case 1:
        Navigator.of(context).pushReplacement(
          PageTransition(
            type: PageTransitionType.fade,
            child: const HomePage(
              showOnlyPrioritized: true,
              showOnlyTaskCompleted: false,
            ),
          ),
        );

        break;

      case 2:
        Navigator.of(context).pushReplacement(
          PageTransition(
            type: PageTransitionType.fade,
            child: const HomePage(
              showOnlyPrioritized: false,
              showOnlyTaskCompleted: true,
            ),
          ),
        );

        break;

      case 3:
        Navigator.of(context).pushReplacement(
          PageTransition(
              type: PageTransitionType.fade, child: const DeletedTasks()),
        );

        break;
    }
  }
}

class MenuItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback? onClicked;
  final Function(bool)? onTogglePriority;

  const MenuItem({
    required this.text,
    required this.icon,
    this.onClicked,
    Key? key,
    this.onTogglePriority,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const color = Colors.white;
    const hoverColor = Colors.white70;

    return ListTile(
        leading: Icon(icon, color: color),
        title: Text(text, style: const TextStyle(color: color)),
        hoverColor: hoverColor,
        onTap: () {
          if (onTogglePriority != null) {
            onTogglePriority!(false);
          }
          onClicked?.call();
        });
  }
}

class SearchFieldDrawer extends StatelessWidget {
  const SearchFieldDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const color = Colors.white;

    return TextField(
      style: const TextStyle(color: color, fontSize: 14),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        hintText: 'Search',
        hintStyle: const TextStyle(color: color),
        prefixIcon: const Icon(
          Icons.search,
          color: color,
          size: 20,
        ),
        filled: true,
        fillColor: Colors.white12,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
      ),
    );
  }
}
