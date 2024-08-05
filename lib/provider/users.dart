import 'dart:convert';
import 'dart:math';

import 'package:bibilioteca/data/dummy_users.dart';
import 'package:bibilioteca/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../provider/users.dart';
import 'package:http/http.dart' as http;

// Essa classe vai adicionar editar e remover
class Users with ChangeNotifier {
  static const _baseUrl =
      'https://bibilioteca-cm-2023-gt-default-rtdb.firebaseio.com/';

  final Map<String, User> _items = Map.fromIterable(
    DUMMY_USERS,
    key: (user) => user.id,
  );

  List<User> get all {
    return [..._items.values];
  }

  int get count {
    return _items.length;
  }

  User byIndex(int i) {
    return _items.values.elementAt(i);
  }

  Future<void> put(User user) async {
    if (user.id != null && _items.containsKey(user.id)) {
      _items.update(
        user.id!,
        (_) => User(
          id: user.id!,
          name: user.name,
          email: user.email,
          avatarUrl: user.avatarUrl,
          senha: user.senha,
        ),
      );
    } else {
      final url = Uri.parse("$_baseUrl/users.json");
      final response = await http.post(
        url,
        body: json.encode({
          'id': user.id,
          'name': user.name,
          'email': user.email,
          'avatarUrl': user.avatarUrl,
          'senha': user.senha,
        }),
      );

      final id = json.decode(response.body)['name'];
      print(id);
      _items.putIfAbsent(
        id,
        () => User(
          id: id,
          name: user.name,
          email: user.email,
          avatarUrl: user.avatarUrl,
          senha: user.senha,
        ),
      );
    }
    notifyListeners();
  }

  void remove(User user) {
    if (user != null && user.id != null) {
      _items.remove(user.id);
      notifyListeners();
    }
  }

  User? authenticateUser(String id, String senha) {
    final user = _items.values.firstWhere(
      (user) => user.id == id && user.senha == senha,
      orElse: null,
    );
    return user;
  }

  User? _loggedInUser;

  void setLoggedInUser(User user) {
    _loggedInUser = user;
    notifyListeners();
  }

  User? get loggedInUser {
    return _loggedInUser;
  }

  Future<void> getUsers() async {
    final url = Uri.parse("$_baseUrl/users.json");
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;

    final List<User> loadedUsers = [];
    extractedData.forEach((userId, userData) {
      loadedUsers.add(User(
        id: userId,
        name: userData['name'],
        email: userData['email'],
        avatarUrl: userData['avatarUrl'],
        senha: userData['senha'],
      ));
    });

    _items.clear();
    _items.addEntries(loadedUsers.map((user) => MapEntry(user.id, user)));

    notifyListeners();
  }

  // Adicionar ou alterar
}
