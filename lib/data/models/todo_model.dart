class TodoModel {
  final int _id;
  final String _todoText;
  bool _isCompleted; // Não é final pois o usuário pode alterar o status
  final int _userId;

  TodoModel({
    required int id,
    required String todoText,
    required bool isCompleted,
    required int userId,
  })  : _id = id,
        _todoText = todoText,
        _isCompleted = isCompleted,
        _userId = userId;

  int get id => _id;
  String get todoText => _todoText;
  bool get isCompleted => _isCompleted;
  int get userId => _userId;

  // Método para inverter o status da tarefa (Requisito RF07)
  void toggleCompletion() {
    _isCompleted = !_isCompleted;
  }

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'],
      todoText: json['todo'],
      isCompleted: json['completed'] == true || json['completed'] == 1,
      userId: json['userId'],
    );
  }

  // Método para converter o objeto em Map e salvar no SQFlite
  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'todoText': _todoText,
      'completed': _isCompleted ? 1 : 0, 
      'userId': _userId,
    };
  }

  @override
  String toString() {
    return 'TodoModel(id: $_id, tarefa: $_todoText, completa: $_isCompleted)';
  }
}