import 'package:first_app/components/task.dart';
import 'package:flutter/material.dart';

class TaskInherited extends InheritedWidget {
  TaskInherited({
    super.key,
    required Widget child,
  }) : super(child: child);

  //criando lista
  final List<Task> taskList = [
    Task('Aprender Flutter', 'assets/images/bird.png', 2),
    Task('Meditação', 'assets/images/meditation.jpeg', 1),
    Task('Jogar', 'assets/images/game.jpg', 2),
    Task('Ler', 'assets/images/book.jpg', 3),
    Task('Corrida', 'assets/images/running.jpg', 4),
  ];

  //criando método para inserir tasks
  void newTask(String name, String image, int hardship){
    taskList.add(Task(name, image, hardship));
  }


  static TaskInherited of(BuildContext context) {
    final TaskInherited? result = context.dependOnInheritedWidgetOfExactType<TaskInherited>();
    assert(result != null, 'No TaskInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(TaskInherited oldWidget) {
    return oldWidget.taskList.length != taskList.length;
  }
}
