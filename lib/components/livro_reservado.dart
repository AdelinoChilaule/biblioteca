import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

import '../provider/livros.dart';
import '../provider/users.dart';
import '../models/livro.dart';

class LivroReservado extends StatelessWidget {
  final Livro livro;

  const LivroReservado(this.livro);

  @override
  Widget build(BuildContext context) {
    final livrosProvider = Provider.of<Livros>(context);
    final usersProvider = Provider.of<Users>(context);
    final String loggedInUserName = usersProvider.loggedInUser?.name ?? '';

    if (livro.estado != 'Alugado' || livro.nomecliente != loggedInUserName) {
      return SizedBox(); // Retorna um SizedBox vazio se o livro não estiver reservado para o usuário logado
    }

    final avatar = livro.avatarUrl == null || livro.avatarUrl.isEmpty
        ? CircleAvatar(child: Icon(Icons.menu_book))
        : CircleAvatar(backgroundImage: NetworkImage(livro.avatarUrl));

    return ListTile(
      leading: avatar,
      title: Text(livro.titulo),
      subtitle: Text(
        'Autor: ${livro.autor}\n\n'
        'Editora: ${livro.editora}\n\n'
        'Ano de publicação: ${livro.anopublicacao}\n\n'
        'Gênero: ${livro.genero}\n\n'
        'Estado: ${livro.estado}\n\n'
        'Nome: ${livro.nomecliente}\n\n'
        'Telefone: ${livro.telefonecliente}\n\n',
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                final livrosProvider =
                    Provider.of<Livros>(context, listen: false);
                String novoEstado = 'Disponível';

                livrosProvider.updateEstado(livro, novoEstado);
                _showNotification(livro.titulo);
              },
              style: ElevatedButton.styleFrom(
                  //primary: Colors.red,
                  //onPrimary: Colors.white,
                  ),
              child: Text('Devolver'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showNotification(String livroTitulo) async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'channelId',
      'channelName',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      'Livro Devolvido',
      'O livro "$livroTitulo" foi devolvido com sucesso.',
      platformChannelSpecifics,
      payload: 'Test Payload',
    );
  }
}
