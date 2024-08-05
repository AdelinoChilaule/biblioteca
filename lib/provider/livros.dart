import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/livro.dart';

class Livros with ChangeNotifier {
  ValueNotifier<List<Livro>> _livrosNotifier = ValueNotifier<List<Livro>>([]);
  List<Livro> get livros => _livrosNotifier.value;

  void adicionarLivro(Livro livro) {
    _livrosNotifier.value = [..._livrosNotifier.value, livro];
    notifyListeners();
  }

  static const _baseUrl =
      'https://bibilioteca-cm-2023-gt-default-rtdb.firebaseio.com/';

  List<Livro> _livros = []; // Lista de todos os livros

  List<Livro> get all {
    return [..._livros];
  }

  int get count {
    return _livros.length;
  }

  Livro byIndex(int i) {
    return _livros[i];
  }

  Future<void> fetchLivros() async {
    final url = Uri.parse("$_baseUrl/livros.json");
    final response = await http.get(url);

    final data = json.decode(response.body) as Map<String, dynamic>;

    _livros.clear();
    data.forEach((livroId, livroData) {
      _livros.add(Livro(
        id: livroId,
        titulo: livroData['titulo'],
        autor: livroData['autor'],
        editora: livroData['editora'],
        anopublicacao: livroData['anopublicacao'],
        genero: livroData['genero'],
        estado: livroData['estado'],
        avatarUrl: livroData['avatarUrl'],
        nomecliente: livroData['nomecliente'],
        telefonecliente: livroData['telefonecliente'],
      ));
    });

    notifyListeners();
  }

  Future<void> put(Livro livro) async {
    final url = Uri.parse("$_baseUrl/livros.json");
    final response = await http.post(
      url,
      body: json.encode({
        'titulo': livro.titulo,
        'autor': livro.autor,
        'editora': livro.editora,
        'anopublicacao': livro.anopublicacao,
        'genero': livro.genero,
        'estado': livro.estado,
        'avatarUrl':
            'https://br.freepik.com/vetores-premium/pilha-de-livros-para-estudantes-icon-ilustracao-em-fundo-branco_7882453.htm',
        'nomecliente': livro.nomecliente,
        'telefonecliente': livro.telefonecliente,
      }),
    );

    final id = json.decode(response.body)['name'];
    _livros.add(
      Livro(
        id: id,
        titulo: livro.titulo,
        autor: livro.autor,
        editora: livro.editora,
        anopublicacao: livro.anopublicacao,
        genero: livro.genero,
        estado: livro.estado,
        avatarUrl: livro.avatarUrl,
        nomecliente: livro.nomecliente,
        telefonecliente: livro.telefonecliente,
      ),
    );

    notifyListeners();
  }

  void remove(Livro livro) {
    if (livro != null && livro.id != null) {
      final url = Uri.parse("$_baseUrl/livros/${livro.id}.json");
      http.delete(url);

      _livros.remove(livro);
      notifyListeners();
    }
  }

  Future<void> updateNome(Livro livro, String novoNome) async {
    final url = Uri.parse("$_baseUrl/livros/${livro.id}.json");
    await http.patch(
      url,
      body: json.encode({
        'nomecliente': novoNome,
      }),
    );

    livro.nomecliente = novoNome;
    notifyListeners();
  }

  Future<void> updateEstado(Livro livro, String novoEstado) async {
    final url = Uri.parse("$_baseUrl/livros/${livro.id}.json");
    await http.patch(
      url,
      body: json.encode({
        'estado': novoEstado,
      }),
    );

    livro.estado = novoEstado;
    notifyListeners();
  }

  Future<void> updateTelefone(Livro livro, String novoTelefone) async {
    final url = Uri.parse("$_baseUrl/livros/${livro.id}.json");
    await http.patch(
      url,
      body: json.encode({
        'telefonecliente': novoTelefone,
      }),
    );

    livro.telefonecliente = novoTelefone;
    notifyListeners();
  }

  List<Livro> getLivrosReservados() {
    return _livros.where((livro) => livro.estado == 'Reservado').toList();
  }

  List<Livro> filterByAuthor(String author) {
    return _livros.where((livro) => livro.autor == author).toList();
  }

  List<Livro> get filteredLivros => _livros;

  List<Livro> getLivrosByAuthor(String author) {
    return _livros.where((livro) => livro.autor == author).toList();
  }
}
