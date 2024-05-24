import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  // variáveis para os campos do formulário
  TextEditingController nameController = TextEditingController();
  TextEditingController difficultyController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Nova Tarefa',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        //centraliza o container em todas as direções
        child: Container(
          height: 650,
          width: 375,
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 3), // aplicando borda
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, // distanciamento entre os campos
            crossAxisAlignment: CrossAxisAlignment.center, // centralização na tela/container
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: nameController,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(), // aplicando borda no campo
                    hintText: 'Nome', //
                    fillColor: Colors.white70, // cor desejada para o campo
                    filled:
                        true, // necessário para que o campo seja preenchido com a cor desejada
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: difficultyController,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(), // aplicando borda no campo
                    hintText: 'Dificuldade', //
                    fillColor: Colors.white70, // cor desejada para o campo
                    filled:
                        true, // necessário para que o campo seja preenchido com a cor desejada
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onChanged: (text){
                    setState(() {

                    });
                  },
                  controller: imageController,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(), // aplicando borda no campo
                    hintText: 'Imagem', //
                    fillColor: Colors.white70, // cor desejada para o campo
                    filled:
                        true, // necessário para que o campo seja preenchido com a cor desejada
                  ),
                ),
              ),
              Container(
                height: 100,
                width: 72,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 2,
                    color: Colors.blue,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10), // imagem com bordas arredondadas
                  child: Image.network(
                    imageController.text, // variável com a URL da imagem informada pelo usuário
                    errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace){ //função para capturar exceção
                      return Image.asset('assets/images/nophoto.png'); //caso não tenha uma URL retornar imagem de sem foto
                    },
                    fit: BoxFit.cover, // fazendo a imagem preencher o container
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    //alterando o formato do botão
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text(
                  'Adicionar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
