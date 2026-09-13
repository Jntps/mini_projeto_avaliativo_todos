import 'package:flutter/material.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../data/datasources/api_datasource.dart';
import '../../../data/datasources/prefs_datasource.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkSession();
  }

  Future<void> _checkSession() async {
    // Instancia o repositório para verificar a sessão
    final authRepo = AuthRepository(ApiDatasource(), PrefsDatasource());
    final isLogged = await authRepo.checkUserSession();

    // Aguarda um pequeno delay para a splash screen não piscar muito rápido
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    // Navegação nomeada exigida nos requisitos técnicos
    if (isLogged) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}