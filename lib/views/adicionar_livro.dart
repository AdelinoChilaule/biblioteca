import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/livro.dart';
import '../provider/livros.dart';

class Livro_Form extends StatelessWidget {
  final _form = GlobalKey<FormState>();
  final Map<String, String> _formData = {};

  void loadFormData(Livro livro) {
    if (livro != null) {
      _formData['id'] = livro.id;
      _formData['titulo'] = livro.titulo;
      _formData['autor'] = livro.autor;
      _formData['editora'] = livro.editora;
      _formData['anopublicacao'] = livro.anopublicacao;
      _formData['genero'] = livro.genero;
      _formData['estado'] = livro.estado;
      _formData['avatarUrl'] = livro.avatarUrl;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Livro? user = ModalRoute.of(context)?.settings.arguments as Livro?;

// Sempre reniciar isso
    if (user != null) {
      loadFormData(user);
    } else {}

    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Livro'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              final isValid = _form.currentState!.validate();
              if (isValid) {
                _form.currentState!.save();

                Provider.of<Livros>(context, listen: false).put(Livro(
                  id: _formData['titulo']!,
                  titulo: _formData['titulo']!,
                  autor: _formData['autor']!,
                  editora: _formData['editora']!,
                  anopublicacao: _formData['anopublicacao']!,
                  genero: _formData['genero']!,
                  estado: _formData['estado']!,
                  avatarUrl:
                      'https://br.freepik.com/vetores-premium/pilha-de-livros-para-estudantes-icon-ilustracao-em-fundo-branco_7882453.htm',
                  nomecliente: _formData['estado']!,
                  telefonecliente: _formData['estado']!,
                ));
                Navigator.of(context).pop();
              }
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _form,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: _formData['titulo'],
                decoration: InputDecoration(labelText: 'Titulo'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'O Titulo está vazio';
                  }
                  if (value.trim().length < 3) {
                    return 'O Titulo é muito pequeno';
                  }
                  return null;
                },
                onSaved: (value) => _formData['titulo'] = value!,
              ),
              TextFormField(
                initialValue: _formData['autor'],
                decoration: InputDecoration(labelText: 'Autor'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'O nome está vazio';
                  }
                  if (value.trim().length < 3) {
                    return 'O nome é muito pequeno';
                  }
                  return null;
                },
                onSaved: (value) => _formData['autor'] = value!,
              ),
              TextFormField(
                initialValue: _formData['editora'],
                decoration: InputDecoration(labelText: 'Editora'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'O nome está vazio';
                  }
                  if (value.trim().length < 3) {
                    return 'O nome é muito pequeno';
                  }
                  return null;
                },
                onSaved: (value) => _formData['editora'] = value!,
              ),
              TextFormField(
                initialValue: _formData['anopublicacao'],
                decoration: InputDecoration(labelText: 'Ano de publicação'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'O nome está vazio';
                  }
                  if (value.trim().length != 4) {
                    return 'Ano invalido ';
                  }
                  return null;
                },
                onSaved: (value) => _formData['anopublicacao'] = value!,
              ),
              TextFormField(
                initialValue: _formData['genero'],
                decoration: InputDecoration(labelText: 'Genero'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'O Genero está vazio';
                  }
                  if (value.trim().length < 3) {
                    return 'Genero muito curto';
                  }
                  return null;
                },
                onSaved: (value) => _formData['genero'] = value!,
              ),
              TextFormField(
                initialValue: _formData['estado'],
                decoration: InputDecoration(labelText: 'Estado'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'O Estado está vazio';
                  }
                  if (value.trim().length < 3) {
                    return 'Estado muito curto';
                  }
                  return null;
                },
                onSaved: (value) => _formData['estado'] = value!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
