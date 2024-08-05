import 'package:bibilioteca/components/Comentario_tile.dart';
import 'package:bibilioteca/provider/comentarios.dart';
import 'package:bibilioteca/provider/livros.dart';
import 'package:bibilioteca/provider/users.dart';
import 'package:bibilioteca/routes/app_routes.dart';
import 'package:bibilioteca/views/Comentario.dart';
import 'package:bibilioteca/views/Livro_alugado.dart';
import 'package:bibilioteca/views/adicionar_livro.dart';
import 'package:bibilioteca/views/janela_livros.dart';
import 'package:bibilioteca/views/livro_reservado.dart';
import 'package:bibilioteca/views/login.dart';
import 'package:bibilioteca/views/menu.dart';
import 'package:bibilioteca/views/pesquisar_nome.dart';
import 'package:bibilioteca/views/user_form.dart';
import 'package:bibilioteca/views/user_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    // Inicialize o plugin FlutterLocalNotifications
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Livros()..fetchLivros(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Users(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Mensagens(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          'login': (context) => LoginForm(),
          AppRoutes.Home: (_) => LoginForm(),
          AppRoutes.USER_List: (_) => UserList(),
          AppRoutes.USER_FORM: (_) => UserForm(),
          AppRoutes.Livro: (_) => Janelalivros(),
          AppRoutes.LivroReservado: (_) => Livro_Reservado(),
          AppRoutes.Livro_Form: (_) => Livro_Form(),
          AppRoutes.menu: (_) => BottomNavBarFb5(),
          AppRoutes.Pesquisar: (_) => Pesquisar(),
          AppRoutes.Comentar: (_) => SuaTela(),
        },
      ),
    );
  }
}
