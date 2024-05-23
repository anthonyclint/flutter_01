import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool opacity = true;
 // variável que poderá ser alterada ao longo da execução
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
        body: AnimatedOpacity(
          opacity: opacity ? 1 : 0,
          duration: Duration(milliseconds: 800),
          child: ListView(
            children: [
              Task(
                  'Aprender Flutter',
                  'https://pbs.twimg.com/media/Eu7m692XIAEvxxP?format=png&name=large',
                  2),
              Task(
                  'Meditação',
                  'https://manhattanmentalhealthcounseling.com/wp-content/uploads/2019/06/Top-5-Scientific-Findings-on-MeditationMindfulness-881x710.jpeg',
                  1),
              Task('Jogar',
                  'https://i.ibb.co/tB29PZB/kako-epifania-2022-2-c-pia.jpg', 2),
              Task(
                  'Ler',
                  'https://thebogotapost.com/wp-content/uploads/2017/06/636052464065850579-137719760_flyer-image-1.jpg',
                  3),
              Task(
                  'Corrida',
                  'https://www.corridaperfeita.com/wp-content/uploads/2023/03/blogpost-2.jpg',
                  4),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () { // propriedade do botão ao ser pressionado
            setState(() { //propriedade que verifica um determinado comportamento em mudanças.
              opacity = !opacity;
            });
        },
          child: Icon(Icons.remove_red_eye),
        ),
      ),
    );
  }
}

class Task extends StatefulWidget {
  //statefulWidget é capaz de "mudar" - está sendo usado para que o contador funcione
  final String name; // variável que é inicializada
  final String image;
  final int hardship; // variável da dificuldade

  const Task(this.name, this.image, this.hardship, {super.key}); //construtor

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  int nivel =
      0; // deve ficar antes do override para que o contador funcione na tela

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Stack(
          children: [
            Container(
              height: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.blue, // propriedade color foi retirada do lado de fora e incluído aqui dentro, para não haver conflito
              ),
            ),
            Column(
              children: [
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        color: Colors.black26,
                        height: 100,
                        width: 72,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image.network(
                            // network indica imagens da web
                            widget.image, //chamando a variável da imagem
                            fit: BoxFit
                                .cover, //indica que deve cobrir a área em que está contida
                          ),
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
                          Row(// utilizado para permitir que as estrelas fiquem em linha
                            children: [
                              Icon(
                                Icons.star,
                                size: 15,
                                color: (widget.hardship >= 1) ? Colors.blue : Colors.blue[100], //if ternário (condição) ? resultado1 : resultado2
                              ),
                              Icon(
                                Icons.star,
                                size: 15,
                                color: (widget.hardship >= 2) ? Colors.blue : Colors.blue[100],
                              ),
                              Icon(
                                Icons.star,
                                size: 15,
                                color: (widget.hardship >= 3) ? Colors.blue : Colors.blue[100],
                              ),
                              Icon(
                                Icons.star,
                                size: 15,
                                color: (widget.hardship >= 4) ? Colors.blue : Colors.blue[100],
                              ),
                              Icon(
                                Icons.star,
                                size: 15,
                                color: (widget.hardship >= 5) ? Colors.blue : Colors.blue[100],
                              ),
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
                        child: LinearProgressIndicator(
                          //barra de progresso
                          color: Colors.white,
                          value: (widget.hardship > 0) ? (nivel / widget.hardship) / 10 : 1, // para que a barra de progressão seja relacionada à dificuldade e verificando se a dificuldade não é zero
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
