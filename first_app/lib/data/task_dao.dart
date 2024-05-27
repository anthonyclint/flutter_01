import 'package:first_app/data/database.dart';
import 'package:first_app/components/task.dart';
import 'package:sqflite/sqlite_api.dart';

class TaskDao {
  // Criando a tabela e suas colunas
  //static - a tabela terá o mesmo valor para qualquer instância da classe
  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_name TEXT, '
      '$_difficulty INTEGER,'
      '$_image TEXT)';


  // Varíaveis dos nomes da tabela e das colunas
  //static - todas as variáveis terão o mesmo valor para todas as instâncias
  static const String _tableName = 'taskTable';
  static const String _name = 'name';
  static const String _difficulty = 'difficulty';
  static const String _image = 'image';

  // Métodos com o banco são async

  //Método para salvar uma nova tarefa ou atualizar existente
  save(Task task) async {
    print('Acessando o save: ');
    final Database bancoDeDados = await getDatabase();
    var itemExists = await find(task.name);
    Map<String, dynamic> mapTask = toMap(task);

    if(itemExists.isEmpty){
      print('A tarefa não existia.');
      return await bancoDeDados.insert(_tableName, mapTask);
    }
    else{
      print('A tarefa já existia.');

      return await bancoDeDados.update(
        _tableName,
        mapTask,
        where: '$_name = ?',
        whereArgs: [task.name],
      );
    }
  }

  //Método para tornar Task em MAP
  Map<String, dynamic> toMap(Task task){
    print('Convertendo Task em Map');
    final Map<String, dynamic> taskMap = Map();

    taskMap[_name] = task.name;
    taskMap[_image] = task.image;
    taskMap[_difficulty] = task.hardship;

    print('Mapa de tarefas: $taskMap');

    return taskMap;
  }

  //Método para encontrar todas as tarefas
  Future<List<Task>> findAll() async {
    print('Acessando o findAll: ');
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result = await bancoDeDados.query(_tableName);

    print('Procurando dados no banco de dados... Encontrado: $result');

    return toList(result);
  }

  //método para tornar MAP em List
  List<Task> toList(List<Map<String, dynamic>> tasksMap) {
    print('Convertendo para List: ');
    final List<Task> tarefas = [];

    for (Map<String, dynamic> line in tasksMap) {
      final Task task = Task(line[_name], line[_image], line[_difficulty]);

      tarefas.add(task);
    }
    print('Lista de tarefas $tarefas');
    return tarefas;
  }

  //Método para encontrar uma tarefa específica
  Future<List<Task>> find(String taskName) async {
    print('Acessando o find: ');
    final Database bancoDeDados = await getDatabase();

    List<Map<String, dynamic>> result = await bancoDeDados.query(
      _tableName,
      where: '$_name = ?',
      whereArgs: [taskName],
    );

    print('Tarefa encontrada: ${toList(result)}');
    return toList(result);

  }

  delete(String taskName) async {
    print('Deletando a tarefa: $taskName');
    final Database bancoDeDados = await getDatabase();
    return bancoDeDados.delete(
        _tableName,
        where: '$_name = ?',
        whereArgs: [taskName],
    );
  }
}