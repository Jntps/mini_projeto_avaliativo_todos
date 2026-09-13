import '../../models/user_model.dart';
import '../datasources/api_datasource.dart';
import '../datasources/prefs_datasource.dart';
import 'result.dart';

class AuthRepository {
  final ApiDatasource _apiDatasource;
  final PrefsDatasource _prefsDatasource;

  AuthRepository(this._apiDatasource, this._prefsDatasource);

  Future<Result<UserModel, Exception>> login(String username, String password) async {
    try {
      // Busca os dados brutos da API
      final responseData = await _apiDatasource.login(username, password);
      
      // Converte o JSON em Objeto usando a Factory criada no Model
      final user = UserModel.fromJson(responseData);
      
      // Salva o nome e sobrenome no SharedPreferences (RF03)
      await _prefsDatasource.saveUserSession(user.firstName, user.lastName);
      
      return Success(user);
    } catch (e) {
      // Captura qualquer erro de requisição ou conversão
      return Failure(Exception('Erro ao realizar login: $e'));
    }
  }

  Future<bool> checkUserSession() async {
    return await _prefsDatasource.isUserLoggedIn();
  }
}