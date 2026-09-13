import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/datasources/api_datasource.dart';
import 'data/datasources/prefs_datasource.dart';
import 'data/datasources/sqlite_datasource.dart';
import 'data/repositories/auth_repository.dart';
import 'data/repositories/todo_repository.dart';
import 'viewModel/login_viewmodel.dart';
import 'viewModel/home_viewmodel.dart';
import 'view/splash_screen.dart';
import 'view/login_screen.dart';
import 'view/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Instanciando os datasources
    final apiDatasource = ApiDatasource();
    final prefsDatasource = PrefsDatasource();
    final sqliteDatasource = SqliteDatasource();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LoginViewModel(AuthRepository(apiDatasource, prefsDatasource)),
        ),
        ChangeNotifierProvider(
          create: (_) => HomeViewModel(TodoRepository(apiDatasource, sqliteDatasource)),
        ),
      ],
      child: MaterialApp(
        title: 'Mini Projeto Avaliativo',
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: '/', // Navegação nomeada obrigatória
        routes: {
          '/': (context) => const SplashScreen(),
          '/login': (context) => const LoginScreen(),
          '/home': (context) => const HomeScreen(),
        },
      ),
    );
  }
}