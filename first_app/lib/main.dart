import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          leading: Container(),
          title: Text(
            'TAREFAS',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.blue,
        ),
        body: ListView(
          children: [
            Task('Aprender Flutter', 'https://pbs.twimg.com/media/Eu7m692XIAEvxxP?format=png&name=large'),
            Task('Meditação', 'https://manhattanmentalhealthcounseling.com/wp-content/uploads/2019/06/Top-5-Scientific-Findings-on-MeditationMindfulness-881x710.jpeg'),
            Task('Jogar', 'https://i.ibb.co/tB29PZB/kako-epifania-2022-2-c-pia.jpg'),
            Task('Ler', 'https://thebogotapost.com/wp-content/uploads/2017/06/636052464065850579-137719760_flyer-image-1.jpg'),
            Task('Corrida', 'https://www.corridaperfeita.com/wp-content/uploads/2023/03/blogpost-2.jpg'),
          ],
        ),
        floatingActionButton: FloatingActionButton(onPressed: () {}),
      ),
    );
  }
}

class Task extends StatefulWidget {
  //statefulWidget é capaz de "mudar" - está sendo usado para que o contador funcione
  final String name; // variável que é inicializada
  final String image;
  final int hardship; // variável da dificuldade

  const Task(this.name, this.image, {super.key}); //construtor

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  int nivel = 0; // deve ficar antes do override para que o contador funcione na tela

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Stack(
          children: [
            Container(
              color: Colors.blue,
              height: 140,
            ),
            Column(
              children: [
                Container(
                  color: Colors.white,
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        color: Colors.black26,
                        height: 100,
                        width: 72,
                        child: Image.network( // network indica imagens da web
                          widget.image, //chamando a variável da imagem
                          fit: BoxFit.cover, //indica que deve cobrir a área em que está contida
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center, //centraliza as estrelas e o texto
                        crossAxisAlignment: CrossAxisAlignment.start, // indica que devem estar alinhadas à esquerda
                        children: [
                          Container(// esse container serve pra limitar o texto, impedir overflow
                            width: 200,
                            child: Text(
                              widget.name,
                              style: TextStyle(
                                fontSize: 24,
                                overflow: TextOverflow.ellipsis, // apresenta reticências
                              ),
                            ),
                          ),
                          Row( // utilizado para permitir que as estrelas fiquem em linha
                            children: [
                              Icon(Icons.star, size: 15, color: Colors.blue),
                              Icon(Icons.star, size: 15, color: Colors.blue),
                              Icon(Icons.star, size: 15, color: Colors.blue),
                              Icon(Icons.star, size: 15, color: Colors.blue[100]),
                              Icon(Icons.star, size: 15, color: Colors.blue[100]),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              nivel++;
                            });
                            print(nivel);
                          },
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.arrow_drop_up,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                Text(
                                  'UP',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: LinearProgressIndicator( //barra de progresso
                          color: Colors.white,
                          value: nivel / 10,
                        ),
                        width: 200,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'Nível: $nivel',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
