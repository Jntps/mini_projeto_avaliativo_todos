import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../viewModel/home_viewmodel.dart';
import '../../../data/datasources/prefs_datasource.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _fullName = '';

  @override
  void initState() {
    super.initState();
    _loadUserName();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeViewModel>(context, listen: false).loadTodos();
    });
  }

  Future<void> _loadUserName() async {
    final name = await PrefsDatasource().getUserFullName();
    setState(() {
      _fullName = name ?? 'Usuário';
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Olá, $_fullName'),
        actions: [
          PopupMenuButton<TodoFilter>(
            icon: const Icon(Icons.filter_list),
            onSelected: (filter) => viewModel.setFilter(filter),
            itemBuilder: (context) => [
              const PopupMenuItem(value: TodoFilter.all, child: Text('Todas')),
              const PopupMenuItem(value: TodoFilter.completed, child: Text('Completadas')),
              const PopupMenuItem(value: TodoFilter.uncompleted, child: Text('Não Completadas')),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Pesquisar tarefa...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: viewModel.setSearchQuery,
            ),
          ),
          
          if (viewModel.errorMessage != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(viewModel.errorMessage!, style: const TextStyle(color: Colors.red)),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: viewModel.loadTodos,
                    child: const Text('Tentar de novo'),
                  ),
                ],
              ),
            ),

          Expanded(
            child: viewModel.isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: viewModel.todos.length,
                    itemBuilder: (context, index) {
                      final todo = viewModel.todos[index];
                      
                      return Opacity(
                        opacity: todo.isCompleted ? 0.5 : 1.0,
                        child: Card(
                          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          child: ListTile(
                            title: Text(
                              todo.todoText,
                              style: TextStyle(
                                decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
                              ),
                            ),
                            trailing: Checkbox(
                              value: todo.isCompleted,
                              onChanged: (val) {
                                viewModel.toggleTodoStatus(todo);
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}