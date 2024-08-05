import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Mensagens with ChangeNotifier {
  static const _baseUrl =
      'https://bibilioteca-cm-2023-gt-default-rtdb.firebaseio.com/';

  List<Mensagem> _mensagens = [];

  List<Mensagem> get mensagens => [..._mensagens];

  Future<void> adicionarMensagem(String nome, String mensagem) async {
    final url = Uri.parse("$_baseUrl/mensagens.json");
    final response = await http.post(
      url,
      body: json.encode({
        'nome': nome,
        'mensagem': mensagem,
      }),
    );

    if (response.statusCode == 200) {
      final id = json.decode(response.body)['name'];
      _mensagens.add(
        Mensagem(
          id: id,
          nome: nome,
          mensagem: mensagem,
        ),
      );
      notifyListeners();
    } else {
      throw Exception('Erro ao adicionar mensagem');
    }
  }

  Future<void> fetchMensagens() async {
    final url = Uri.parse("$_baseUrl/mensagens.json");
    final response = await http.get(url);

    final data = json.decode(response.body) as Map<String, dynamic>;

    _mensagens.clear();
    data.forEach((mensagemId, mensagemData) {
      _mensagens.add(
        Mensagem(
          id: mensagemId,
          nome: mensagemData['nome'],
          mensagem: mensagemData['mensagem'],
        ),
      );
    });

    notifyListeners();
  }
}

class Mensagem {
  final String id;
  final String nome;
  final String mensagem;

  Mensagem({
    required this.id,
    required this.nome,
    required this.mensagem,
  });
}
