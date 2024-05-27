import 'package:first_app/data/task_dao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart'; //importar manualmente


/*
* FUTURE para que o método aguarde a resposta do banco
* Como o método getDatabase é Future foi preciso adicionar
* a palavra async e await, para que a resposta do banco seja
* aguardada.
*/
Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'task.db');

  //openDatabase abre o banco num "path",
  //caso ele não exista, então é criado.
  return openDatabase(path, onCreate: (db, version) {
    db.execute(TaskDao.tableSql);
  },
    version: 1,
  );
}





