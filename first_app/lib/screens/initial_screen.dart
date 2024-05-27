import 'package:first_app/components/task.dart';
import 'package:first_app/data/task_dao.dart';
//import 'package:first_app/data/task_inherited.dart';
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
        actions: [
          IconButton( //botão de refresh da tela
              onPressed: (){setState(() {});},
              icon: const Icon(Icons.refresh),
          )
        ],
        title: const Text(
          'TAREFAS',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 70),
          child: FutureBuilder<List<Task>>(
              future: TaskDao().findAll(),
              builder: (context,snapshot){ //snapshot responsável pelos dados
                List<Task>? items = snapshot.data;
                switch(snapshot.connectionState){

                  case ConnectionState.none:
                    return const Center(
                      child: Column(
                        children: [
                          CircularProgressIndicator(),
                          Text('Carregando...'),
                        ],
                      ),
                    );

                  case ConnectionState.waiting:
                    return const Center(
                      child: Column(
                        children: [
                          CircularProgressIndicator(),
                          Text('Carregando...'),
                        ],
                      ),
                    );

                  case ConnectionState.active:
                    return const Center(
                      child: Column(
                        children: [
                          CircularProgressIndicator(),
                          Text('Carregando...'),
                        ],
                      ),
                    );

                  case ConnectionState.done:
                    if(snapshot.hasData && items != null){ //se existe dados e se são diferentes de nulo
                      if(items.isNotEmpty){
                        return ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (BuildContext context, int index){
                            final Task task = items[index];
                            return task;
                          },
                        );
                      }
                      return const Center(
                        child: Column(
                          children: [
                            Icon(
                              Icons.error_outline,
                              size: 128,
                            ),
                            Text('Não há nenhuma tarefa!',
                                style: TextStyle(fontSize: 32),
                            )
                          ],
                        ),
                      );
                    }
                    return const Text('Erro ao carregar tarefas!');
                }
          }),
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
            ).then((value) => setState(() {
              print('Recarregando a tela inicial');
            }));
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
