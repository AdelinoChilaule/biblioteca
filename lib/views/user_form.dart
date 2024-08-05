import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../provider/users.dart';

class UserForm extends StatelessWidget {
  final _form = GlobalKey<FormState>();
  final Map<String, String> _formData = {};
// Colocar a carregar
  bool _isLoading = false;

  void loadFormData(User user) {
    if (user != null) {
      _formData['id'] = user.id;
      _formData['name'] = user.name;
      _formData['email'] = user.email;
      _formData['avatarUrl'] = user.avatarUrl;
      _formData['senha'] = user.senha;
    }
  }

  @override
  Widget build(BuildContext context) {
    final User? user = ModalRoute.of(context)?.settings.arguments as User?;

// Sempre reniciar isso
    if (user != null) {
      loadFormData(user);
    } else {}

    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário do Usuário'),
        actions: <Widget>[
          IconButton(
            // Com BD
            onPressed: () async {
              final isValid = _form.currentState!.validate();
              if (isValid) {
                _form.currentState!.save();

                await Provider.of<Users>(context, listen: false).put(User(
                    id: _formData['id']!,
                    name: _formData['name']!,
                    email: _formData['email']!,
                    avatarUrl: _formData['avatarUrl']!,
                    senha: _formData['senha']!));
                Navigator.of(context).pop();
              }
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: EdgeInsets.all(15),
              child: Form(
                key: _form,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      initialValue: _formData['id'],
                      decoration: InputDecoration(labelText: 'Telefone'),
                      onSaved: (value) => _formData['id'] = value!,
                    ),
                    TextFormField(
                      initialValue: _formData['name'],
                      decoration: InputDecoration(labelText: 'Nome'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'O nome está vazio';
                        }
                        if (value.trim().length < 3) {
                          return 'O nome é muito pequeno';
                        }
                        return null;
                      },
                      onSaved: (value) => _formData['name'] = value!,
                    ),
                    TextFormField(
                      initialValue: _formData['email'],
                      decoration: InputDecoration(labelText: 'Email'),
                      onSaved: (value) => _formData['email'] = value!,
                    ),
                    TextFormField(
                      initialValue: _formData['avatarUrl'],
                      decoration: InputDecoration(labelText: 'Avatar URL'),
                      onSaved: (value) => _formData['avatarUrl'] = value!,
                    ),
                    TextFormField(
                      initialValue: _formData['senha'],
                      decoration: InputDecoration(labelText: 'Senha'),
                      onSaved: (value) => _formData['senha'] = value!,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
