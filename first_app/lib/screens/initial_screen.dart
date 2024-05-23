import 'package:flutter/material.dart';

import '../components/task.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  bool opacity = true;// variável que poderá ser alterada ao longo da execução

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
      body: AnimatedOpacity(
        opacity: opacity ? 1 : 0,
        duration: const Duration(milliseconds: 800),
        child: ListView(
          children: const [
            Task(
                'Aprender Flutter',
                'assets/images/bird.png',
                2),
            Task(
                'Meditação',
                'assets/images/meditation.jpeg',
                1),
            Task('Jogar',
                'assets/images/game.jpg', 2),
            Task(
                'Ler',
                'assets/images/book.jpg',
                3),
            Task(
                'Corrida',
                'assets/images/running.jpg',
                4
            ),
            SizedBox(height: 100,),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () { // propriedade do botão ao ser pressionado
          setState(() { //propriedade que verifica um determinado comportamento em mudanças.
            opacity = !opacity;
          });
        },
        child: const Icon(Icons.remove_red_eye),
      ),
    );
  }
}