import 'package:exam_1/widgets/drawer.dart';
import 'package:exam_1/widgets/tasklist.dart';
import 'package:exam_1/widgets/tasktile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final bool showOnlyPrioritized;
  final bool showOnlyTaskCompleted;
  const HomePage(
      {super.key,
      required this.showOnlyPrioritized,
      required this.showOnlyTaskCompleted});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      drawer: DrawerFb1(),
      body: SizedBox(
        width: double.infinity,
        child: Consumer<TaskList>(
          builder: (context, todoListModel, child) {
            final data = widget.showOnlyPrioritized
                ? todoListModel.getPrioritizedTasks()
                : widget.showOnlyTaskCompleted
                    ? todoListModel.getCheckBoxTasks()
                    : todoListModel.toDoList;

            data.sort((a, b) => a[0].compareTo(b[0]));

            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                String title = data[index][0];
                final bool isChecked = data[index][1];
                String paragraph = data[index][2];
                bool isPrio = data[index][3];

                return GestureDetector(
                  onTap: () {
                    todoListModel.openTaskDetails(
                      context,
                      title,
                      paragraph,
                    );
                  },
                  child: Stack(
                    children: [
                      TodoTile(
                        //status cb
                        onChanged: (value) =>
                            todoListModel.checkBoxChanged(value, index),
                        //prio cb
                        onPrioChanged: (value) =>
                            todoListModel.prioritizedChanged(value, index),
                        isPrio: isPrio,
                        taskCompleted: isChecked,
                        deleteFunction: (context) =>
                            todoListModel.deleteTask(index),
                        taskName: title,
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurpleAccent,
        onPressed: () {
          TaskList taskList = Provider.of<TaskList>(context, listen: false);
          taskList.createNewTask(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
