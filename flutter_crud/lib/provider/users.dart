import 'dart:math';

import 'package:flutter/material.dart';
import '../data/dummy_users.dart';
import '../models/user.dart';

class Users with ChangeNotifier {
  Map<String, User> _items = {...DUMMY_USERS};

  List<User> get all {
    return [..._items.values];
  }

  int get count {
    return _items.length;
  }

  User byIndex(int i) {
    return _items.values.elementAt(i);
  }

  void put(User user) {
    if (user == null) {
      return;
    }

    if (user.name.isEmpty || user.username.isEmpty || user.email.isEmpty) {
      // Verificar se os campos necessários estão vazios
      return;
    }

    if (user.id != null && _items.containsKey(user.id.toString())) {
      _items.update(
        user.id.toString(),
        (_) => User(
          id: int.parse(user.id.toString()),
          name: user.name,
          username: user.username,
          email: user.email,
          avatarUrl: user.avatarUrl,
        ),
      );
    } else {
      final id = Random().nextInt(999999);
      _items.putIfAbsent(
        id.toString(),
        () => User(
          id: id,
          name: user.name,
          username: user.username,
          email: user.email,
          avatarUrl: user.avatarUrl,
        ),
      );
    }
    notifyListeners();
  }

  void remove(User user) {
    if (user != null && user.id != null) {
      _items.remove(user.id.toString());
      notifyListeners();
    }
  }
}
