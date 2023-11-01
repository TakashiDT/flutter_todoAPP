import 'dart:convert';
import 'package:exam_1/widgets/dialog_box.dart';
import 'package:exam_1/widgets/task_details.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskList extends ChangeNotifier {
  final _title = TextEditingController();
  final _paragraph = TextEditingController();

  final String key = 'isChecked';
  final String key2 = 'isPrioChecked';

  List<List<dynamic>> toDoList = [];
  List<List<dynamic>> deletedTasks = [];

  TaskList() {
    loadTask();
    loadDeletedTasks();
  }

  List<List<dynamic>> getPrioritizedTasks() {
    return toDoList.where((task) => task[3] == true).toList();
  }

  List<List<dynamic>> getCheckBoxTasks() {
    return toDoList.where((task) => task[01] == true).toList();
  }

  Future<void> loadTask() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedTasks = prefs.getStringList('tasks');

    if (savedTasks != null) {
      for (var task in savedTasks) {
        Map<String, dynamic> taskData = jsonDecode(task);
        bool isChecked = await loadCheckBoxState(taskData['title']);
        bool isPrioChecked = await loadPrioBoxState(taskData['title']);
        String paragraph = taskData['paragraph'];
        toDoList.add([taskData['title'], isChecked, paragraph, isPrioChecked]);
      }
    }

    notifyListeners();
  }

  Future<void> loadDeletedTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? deletedTasksData = prefs.getStringList('deletedTasks');

    if (deletedTasksData != null) {
      for (var task in deletedTasksData) {
        Map<String, dynamic> taskData = jsonDecode(task);
        bool isChecked = await loadCheckBoxState(taskData['title']);
        bool isPrioChecked = await loadPrioBoxState(taskData['title']);
        String paragraph = taskData['paragraph'];
        deletedTasks
            .add([taskData['title'], isChecked, paragraph, isPrioChecked]);
      }
    }
    notifyListeners();
  }

  Future<bool> loadCheckBoxState(String task) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('$key:$task') ?? false;
  }

  Future<bool> loadPrioBoxState(String task) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('$key2:$task') ?? false;
  }

  void saveTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tasks = toDoList.map((task) {
      Map<String, dynamic> taskData = {
        'title': task[0],
        'isChecked': task[1],
        'paragraph': task[2]
      };
      return jsonEncode(taskData);
    }).toList();

    List<String> deletedTasksStrings = deletedTasks.map((task) {
      Map<String, dynamic> taskData = {
        'title': task[0],
        'isChecked': task[1],
        'paragraph': task[2]
      };
      return jsonEncode(taskData);
    }).toList();

    prefs.setStringList('tasks', tasks);
    prefs.setStringList(
        'deletedTasks', deletedTasksStrings); // Save deleted tasks
    print('Tasks saved: $tasks');
  }

  void checkBoxChanged(bool? value, int index) async {
    if (value != null) {
      String task = toDoList[index][0] as String;
      toDoList[index][1] = value;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('$key:$task', value);

      saveTasks();
      notifyListeners();
    }
  }

  void prioritizedChanged(bool? value, int index) async {
    if (value != null) {
      String task = toDoList[index][0] as String;
      toDoList[index][3] = value;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('$key2:$task', value);
      print('Prioritized');

      saveTasks();
      notifyListeners();
    }
  }

  void createNewTask(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          titleController: _title,
          paragraphController: _paragraph,
          onSave: () => saveNewTask(context, _title.text, _paragraph.text),
          onCancel: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
    notifyListeners();
  }

  void saveNewTask(BuildContext context, String title, String paragraph) {
    if (title.isEmpty || paragraph.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text('Please Add a note'),
          );
        },
      );
    } else {
      toDoList.add([title, false, paragraph, false]);
      _title.clear();
      _paragraph.clear();
      saveTasks();
      Navigator.of(context).pop();

      notifyListeners();
    }
  }

  void restoreTask(int index) {
    List<dynamic> restoreTasks = deletedTasks.removeAt(index);
    toDoList.add(restoreTasks);

    saveTasks();
    notifyListeners();
  }

  //Permanently Delete
  void deleteEntirely(int index) {
    deletedTasks.removeAt(index);

    saveTasks();
    notifyListeners();
  }

  void deleteTask(int index) {
    List<dynamic> deletedTask = toDoList.removeAt(index);
    deletedTasks.add(deletedTask);

    saveTasks();

    notifyListeners();
  }

  void openTaskDetails(BuildContext context, String title, String paragraph) {
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        child: TaskDetailsPage(title: title, paragraph: paragraph),
      ),
    );
  }
}
