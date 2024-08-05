import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/comentarios.dart';
import '../provider/users.dart';
import '../models/user.dart';

class SuaTela extends StatelessWidget {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _mensagemController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final usersProvider = Provider.of<Users>(context);
    final User loggedInUser = usersProvider.loggedInUser!;
    final String nomeUsuario = loggedInUser.name;

    void _adicionarMensagem(BuildContext context) {
      final mensagensProvider = Provider.of<Mensagens>(context, listen: false);
      final mensagem = _mensagemController.text;
      mensagensProvider.adicionarMensagem(nomeUsuario, mensagem);
      _nomeController.clear();
      _mensagemController.clear();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Mensagens'),
      ),
      body: Column(
        children: [
          Text(
            'Usuário: $nomeUsuario',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          TextField(
            controller: _mensagemController,
            decoration: InputDecoration(labelText: 'Mensagem'),
          ),
          ElevatedButton(
            onPressed: () => _adicionarMensagem(context),
            child: Text('Adicionar Mensagem'),
          ),
          SizedBox(height: 20),
          Text(
            'Comentários:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Expanded(
            child: Consumer<Mensagens>(
              builder: (ctx, mensagensProvider, _) {
                final comentarios = mensagensProvider.mensagens;
                return ListView.builder(
                  itemCount: comentarios.length,
                  itemBuilder: (ctx, index) {
                    final comentario = comentarios[index];
                    return ListTile(
                      title: Text(comentario.nome),
                      subtitle: Text(comentario.mensagem),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
