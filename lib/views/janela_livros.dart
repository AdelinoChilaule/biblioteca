import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/livro_tile.dart';
import '../models/livro.dart';
import '../models/user.dart';
import '../provider/livros.dart';
import '../provider/users.dart';
import '../routes/app_routes.dart';

class Janelalivros extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final livrosProvider = Provider.of<Livros>(context);
    final usersProvider = Provider.of<Users>(context);
    final List<Livro> livros = livrosProvider.all;
    final User loggedInUser = usersProvider.loggedInUser!;

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Livros'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.Livro_Form);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: livros.length,
        itemBuilder: (ctx, i) => LivroTile(
          livros[i],
          loggedInUser: loggedInUser,
        ),
      ),
    );
  }
}
