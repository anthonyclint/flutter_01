import 'package:first_app/components/difficulty.dart';
import 'package:first_app/data/task_dao.dart';
import 'package:flutter/material.dart';

class Task extends StatefulWidget {//statefulWidget é capaz de "mudar" - está sendo usado para que o contador funcione
  final String name; // variável que é inicializada
  final String image;
  final int hardship; // variável da dificuldade

  Task(this.name, this.image, this.hardship, {super.key}); //construtor

  int nivel = 0; // deve ficar aqui para que ao adicionar novas tarefas as já existentes não resetem

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {

  // método para verificar se o endereço da imagem é de internet ou de pasta
  bool assetOrNetwork(){
    if(widget.image.contains('http')){
      return false;
    }
    return true;
  }

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
                        child: assetOrNetwork() ? Image.asset(widget.image, fit: BoxFit.cover,)
                            : Image.network(widget.image, fit: BoxFit.cover),
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
                        onLongPress: (){
                          TaskDao().delete(widget.name);
                        },
                        onPressed: () {
                          setState(() {
                            widget.nivel++;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            //alterando o formato do botão
                            borderRadius: BorderRadius.circular(10.0),
                          ),
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
                        value: (widget.hardship > 0) ? (widget.nivel / widget.hardship) / 10 : 1, // para que a barra de progressão seja relacionada à dificuldade e verificando se a dificuldade não é zero
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'Nível: ${widget.nivel}',
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