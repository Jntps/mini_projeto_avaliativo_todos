import 'package:flutter/material.dart';
import '../data/repositories/auth_repository.dart';
import '../data/repositories/result.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthRepository _repository;

  LoginViewModel(this._repository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> login(String username, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    // Chama o repositório que já trata o JSON e salva os dados localmente
    final result = await _repository.login(username, password);

    _isLoading = false;
    
    if (result is Success) {
      notifyListeners();
      return true;
    } else if (result is Failure) {
      _errorMessage = (result as Failure).exception.toString();
      notifyListeners();
      return false;
    }
    return false;
  }
}