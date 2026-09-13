import 'package:shared_preferences/shared_preferences.dart';

class PrefsDatasource {
  // Salva os dados após sucesso no login
  Future<void> saveUserSession(String firstName, String lastName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('firstName', firstName);
    await prefs.setString('lastName', lastName);
    await prefs.setBool('isLogged', true);
  }

  // Verifica se o usuário já está logado para a Splash Screen
  Future<bool> isUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLogged') ?? false;
  }

  // Recupera o nome para exibir na AppBar da Home
  Future<String?> getUserFullName() async {
    final prefs = await SharedPreferences.getInstance();
    final firstName = prefs.getString('firstName');
    final lastName = prefs.getString('lastName');
    
    if (firstName != null && lastName != null) {
      return '$firstName $lastName';
    }
    return null;
  }
}