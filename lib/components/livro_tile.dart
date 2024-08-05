import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/livro.dart';
import '../models/user.dart';
import '../provider/livros.dart';

class LivroTile extends StatelessWidget {
  final Livro livro;
  final User loggedInUser;

  const LivroTile(this.livro, {required this.loggedInUser});

  @override
  Widget build(BuildContext context) {
    final avatar = livro.avatarUrl == null || livro.avatarUrl.isEmpty
        ? CircleAvatar(child: Icon(Icons.menu_book))
        : CircleAvatar(backgroundImage: NetworkImage(livro.avatarUrl));

    return ListTile(
      leading: avatar,
      title: Text(livro.titulo),
      subtitle: Text(
        ' Autor: ' +
            livro.autor +
            ' \n\n Editora:' +
            livro.editora +
            '\n\n Ano de publicação: ' +
            livro.anopublicacao +
            '\n\n Gênero: ' +
            livro.genero +
            '\n\n Estado: ' +
            livro.estado +
            '\n\n',
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              onPressed: () {
                final livrosProvider =
                    Provider.of<Livros>(context, listen: false);

                String novoEstado = 'Alugado';
                String nome = loggedInUser.name;
                String telefone = loggedInUser.id;

                if (livro.estado == 'Alugado') {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text('Livro Alugado'),
                      content: Text('Este livro já está reservado.'),
                      actions: [
                        TextButton(
                          child: Text('OK'),
                          onPressed: () {
                            Navigator.of(ctx).pop();
                          },
                        ),
                      ],
                    ),
                  );
                } else {
                  livrosProvider.updateEstado(livro, novoEstado);
                  livrosProvider.updateNome(livro, nome);
                  livrosProvider.updateTelefone(livro, telefone);
                }
              },
              icon: Icon(Icons.sell),
              color: livro.estado == 'Reservado' ? Colors.red : Colors.blue,
            ),
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text('Excluir Livro'),
                    content: Text('Tem certeza?'),
                    actions: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          Provider.of<Livros>(context, listen: false)
                              .remove(livro);
                          Navigator.of(context).pop();
                        },
                        child: Text('Sim'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Não'),
                      ),
                    ],
                  ),
                );
              },
              icon: Icon(Icons.delete),
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
