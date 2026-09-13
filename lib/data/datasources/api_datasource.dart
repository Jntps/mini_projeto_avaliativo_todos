import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiDatasource {
  final String baseUrl = 'https://dummyjson.com';

  // Consumo do endpoint de login
  Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Falha na autenticação: ${response.statusCode}');
    }
  }

  // Consumo do endpoint de TODOS
  Future<List<dynamic>> getTodos() async {
    final response = await http.get(Uri.parse('$baseUrl/todos'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['todos']; // Retorna apenas a lista contida no JSON
    } else {
      throw Exception('Falha ao buscar tarefas: ${response.statusCode}');
    }
  }
}