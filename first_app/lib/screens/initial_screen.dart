import 'package:first_app/data/task_inherited.dart';
import 'package:first_app/screens/form_screen.dart';
import 'package:flutter/material.dart';


class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: const Text(
          'TAREFAS',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 8, bottom: 70),
        children: TaskInherited.of(context).taskList,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {// propriedade do botão ao ser pressionado
          setState(() {//propriedade que verifica um determinado comportamento em mudanças.
            Navigator.push(
                context, //context da tela inicial
                MaterialPageRoute(
                    builder: (contextNew) => FormScreen(
                          taskContext: context, //enviando o context da tela inicial para o task Inherited
                        ),
                ),
            );
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
