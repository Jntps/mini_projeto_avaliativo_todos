import '../models/todo_model.dart';
import '../datasources/api_datasource.dart';
import '../datasources/sqlite_datasource.dart';
import 'result.dart';

class TodoRepository {
  final ApiDatasource _apiDatasource;
  final SqliteDatasource _sqliteDatasource;

  TodoRepository(this._apiDatasource, this._sqliteDatasource);

  // Busca da API e salva no SQLite (RF04)
  Future<Result<List<TodoModel>, Exception>> syncTodos() async {
    try {
      final rawData = await _apiDatasource.getTodos();
      
      // Converte a lista dinâmica (JSON) para uma lista de Objetos TodoModel
      final List<TodoModel> todosApi = rawData.map((json) => TodoModel.fromJson(json)).toList();

      // Salva cada TODO no banco de dados local
      for (var todo in todosApi) {
        await _sqliteDatasource.insertTodo(todo);
      }

      // Retorna a lista diretamente do banco local
      return await getLocalTodos();
    } catch (e) {
      return Failure(Exception('Falha ao sincronizar tarefas: $e'));
    }
  }

  // Busca exclusiva no banco de dados local
  Future<Result<List<TodoModel>, Exception>> getLocalTodos() async {
    try {
      final localData = await _sqliteDatasource.getLocalTodos();
      final todos = localData.map((map) {
        return TodoModel(
          id: map['id'],
          todoText: map['todoText'],
          isCompleted: map['completed'] == 1,
          userId: map['userId'],
        );
      }).toList();
      
      return Success(todos);
    } catch (e) {
      return Failure(Exception('Falha ao ler banco local: $e'));
    }
  }

  // Atualiza a tarefa no banco quando o usuário marcar o checkbox (RF07)
  Future<Result<void, Exception>> toggleTodoStatus(TodoModel todo) async {
    try {
      todo.toggleCompletion(); // Altera o status no objeto (Polimorfismo/Encapsulamento)
      await _sqliteDatasource.updateTodoStatus(todo.id, todo.isCompleted ? 1 : 0);
      return Success(null);
    } catch (e) {
      return Failure(Exception('Falha ao atualizar tarefa: $e'));
    }
  }
}