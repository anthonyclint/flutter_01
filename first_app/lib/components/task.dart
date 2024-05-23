import 'package:first_app/components/difficulty.dart';
import 'package:flutter/material.dart';

class Task extends StatefulWidget {//statefulWidget é capaz de "mudar" - está sendo usado para que o contador funcione
  final String name; // variável que é inicializada
  final String image;
  final int hardship; // variável da dificuldade

  const Task(this.name, this.image, this.hardship, {super.key}); //construtor

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  int nivel = 0; // deve ficar antes do override para que o contador funcione na tela

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
                        child: Image.asset(
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
                        SizedBox(// esse container serve pra limitar o texto, impedir overflow
                          width: 200,
                          child: Text(
                            widget.name,
                            style: const TextStyle(
                              fontSize: 24,
                              overflow: TextOverflow.ellipsis, // apresenta reticências
                            ),
                          ),
                        ),
                        Difficulty(hardshipLevel: widget.hardship),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            nivel++;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        child: const Center(
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
                    child: SizedBox(
                      width: 200,
                      child: LinearProgressIndicator(
                        //barra de progresso
                        color: Colors.white,
                        value: (widget.hardship > 0) ? (nivel / widget.hardship) / 10 : 1, // para que a barra de progressão seja relacionada à dificuldade e verificando se a dificuldade não é zero
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'Nível: $nivel',
                      style: const TextStyle(
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
    );
  }
}