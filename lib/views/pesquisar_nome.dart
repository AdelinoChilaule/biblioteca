import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/livro_tile.dart';
import '../components/pesquisar_autor.dart';
import '../models/livro.dart';
import '../models/user.dart';
import '../provider/livros.dart';
import '../provider/users.dart';
import '../routes/app_routes.dart';

class Pesquisar extends StatefulWidget {
  @override
  _PesquisarState createState() => _PesquisarState();
}

class _PesquisarState extends State<Pesquisar> {
  String autorPesquisado = '';

  @override
  Widget build(BuildContext context) {
    final livrosProvider = Provider.of<Livros>(context);
    final usersProvider = Provider.of<Users>(context);
    final List<Livro> livros = livrosProvider.all;
    final User loggedInUser = usersProvider.loggedInUser!;

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Livros Pesquisa'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              // Navigator.of(context).pushNamed(AppRoutes.Livro_Form);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  autorPesquisado = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Categoria',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: livros.length,
              itemBuilder: (ctx, i) {
                final livro = livros[i];
                if (autorPesquisado.isNotEmpty &&
                    livro.autor != autorPesquisado &&
                    livro.genero != autorPesquisado &&
                    livro.estado != autorPesquisado &&
                    livro.titulo != autorPesquisado) {
                  return SizedBox(); // Retorna um SizedBox vazio se o autor não corresponder à pesquisa
                }
                return PesquisarAutor(
                  livro,
                  loggedInUser: loggedInUser,
                  autorPesquisado: autorPesquisado,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
