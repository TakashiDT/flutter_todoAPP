import 'package:exam_1/widgets/drawer.dart';
import 'package:exam_1/widgets/tasklist.dart';
import 'package:exam_1/widgets/tasktile_deleted.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DeletedTasks extends StatefulWidget {
  const DeletedTasks({super.key});

  @override
  State<DeletedTasks> createState() => _DeletedTasksState();
}

class _DeletedTasksState extends State<DeletedTasks> {
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
            final data = todoListModel.deletedTasks;

            data.sort((a, b) => a[0].compareTo(b[0]));

            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final String title = data[index][0];
                final bool isChecked = data[index][1];
                final String paragraph = data[index][2];
                final bool isPrio = data[index][3];

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
                      TodoTileDeleted(
                        //status cb
                        onChanged: null,
                        //prio cb
                        onPrioChanged: null,
                        isPrio: isPrio,
                        taskCompleted: isChecked,
                        deleteFunction: (context) =>
                            todoListModel.deleteEntirely(index),
                        taskName: title,
                        restoreFunction: (context) =>
                            todoListModel.restoreTask(index),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
