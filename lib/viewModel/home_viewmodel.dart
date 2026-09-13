import 'package:flutter/material.dart';
import '../data/models/todo_model.dart';
import '../data/repositories/todo_repository.dart';
import '../data/repositories/result.dart';

// Enum para facilitar a filtragem exigida no RF05
enum TodoFilter { all, completed, uncompleted }

class HomeViewModel extends ChangeNotifier {
  final TodoRepository _repository;

  HomeViewModel(this._repository);

  List<TodoModel> _allTodos = [];
  List<TodoModel> _filteredTodos = [];
  
  // A View sempre consumirá a lista filtrada
  List<TodoModel> get todos => _filteredTodos;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  TodoFilter _currentFilter = TodoFilter.all;
  String _searchQuery = '';

  // RF04 - Consumo de TODOS ao entrar na tela
  Future<void> loadTodos() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await _repository.syncTodos();

    if (result is Success<List<TodoModel>, Exception>) {
      _allTodos = result.value;
      _applyFilters();
    } else if (result is Failure) {
      _errorMessage = (result as Failure).exception.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  // RF05 - Filtros de status
  void setFilter(TodoFilter filter) {
    _currentFilter = filter;
    _applyFilters();
  }

  // RF05 - Filtro por texto
  void setSearchQuery(String query) {
    _searchQuery = query.toLowerCase();
    _applyFilters();
  }

  // Lógica interna que cruza os filtros de texto e status utilizando métodos avançados de List (where)
  void _applyFilters() {
    _filteredTodos = _allTodos.where((todo) {
      final matchText = todo.todoText.toLowerCase().contains(_searchQuery);
      
      bool matchStatus = true;
      if (_currentFilter == TodoFilter.completed) {
        matchStatus = todo.isCompleted;
      } else if (_currentFilter == TodoFilter.uncompleted) {
        matchStatus = !todo.isCompleted;
      }

      return matchText && matchStatus;
    }).toList();

    notifyListeners();
  }

  // RF07 - Atualiza a tarefa ao clicar no checkbox e reorganiza a tela
  Future<void> toggleTodoStatus(TodoModel todo) async {
    final result = await _repository.toggleTodoStatus(todo);
    
    if (result is Success) {
      _applyFilters(); 
    } else {
      _errorMessage = "Erro ao atualizar o status da tarefa no banco.";
      notifyListeners();
    }
  }
}