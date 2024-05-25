import 'package:first_app/data/task_inherited.dart';
import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key, required this.taskContext}); // incluindo o contexto nos parâmetros

  final BuildContext taskContext; // criando a variável do contexto

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  // variáveis para os campos do formulário
  TextEditingController nameController = TextEditingController();
  TextEditingController difficultyController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  final _formKey = GlobalKey<FormState>(); // variável para a key do widget FORM

  bool valueValidator(String? value){
    if(value != null && value.isEmpty){
      return true;
    }
    return false;
  }

  bool hardshipValidator(String? value){
    if(value != null && value.isEmpty){
      if(int.parse(value) > 5 || int.parse(value) < 1){
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Form( // widget que permite observar as validações dos campos
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Nova Tarefa',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue,
        ),
        body: Center(//centraliza o container em todas as direções
          child: SingleChildScrollView( //esse widget faz com que o teclado não reajuste a tela do app
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
                      validator: (String? value){ //a variável pode estar vazia
                        if(valueValidator(value)){
                          return 'Insire o nome da tarefa!';
                        }
                        return null;
                      },
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
                      validator: (value){
                        if(hardshipValidator(value)){
                          return 'Insira uma dificuldade entre 1 e 5';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number, // propriedade que faz o teclado abrir com o tipo de dado esperado pelo campo
                      controller: difficultyController,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(), // aplicando borda no campo
                        hintText: 'Dificuldade', //
                        fillColor: Colors.white70, // cor desejada para o campo
                        filled: true, // necessário para que o campo seja preenchido com a cor desejada
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      onChanged: (text){
                        setState(() {});
                      },
                      validator: (value){
                        if(valueValidator(value)){
                          return 'Insira uma URL de imagem!';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.url,
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
                    onPressed: () {
                      if(_formKey.currentState!.validate()){

                        //enviando os campos do formulário para o método que cria tasks
                        TaskInherited.of(widget.taskContext).newTask( //widget.taskContext é o contexto da tela inicial que foi enviado para o taskInherited
                            nameController.text,
                            imageController.text,
                            int.parse(difficultyController.text)
                        );

                        //método para apresentar um snackbar quando todos os campos foram preenchidos e o botão for acionado
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Criando nova tarefa!'),
                          ),
                        );

                        Navigator.pop(context); // para voltar para tela principal
                      }
                    },
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
        ),
      ),
    );
  }
}
