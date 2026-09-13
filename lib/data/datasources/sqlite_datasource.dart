import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/todo_model.dart';

class SqliteDatasource {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final path = join(await getDatabasesPath(), 'todos_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE todos(
            id INTEGER PRIMARY KEY,
            todoText TEXT,
            completed INTEGER,
            userId INTEGER
          )
        ''');
      },
    );
  }

  // Insere ou substitui tarefas vindas da API
  Future<void> insertTodo(TodoModel todo) async {
    final db = await database;
    await db.insert(
      'todos', 
      todo.toMap(), 
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Busca as tarefas salvas para exibir na Home (RF04)
  Future<List<Map<String, dynamic>>> getLocalTodos() async {
    final db = await database;
    return await db.query('todos');
  }

  // Atualiza o status de completado no banco (RF07)
  Future<void> updateTodoStatus(int id, int isCompleted) async {
    final db = await database;
    await db.update(
      'todos',
      {'completed': isCompleted},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}