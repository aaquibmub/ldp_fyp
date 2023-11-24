import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:ldp_fyp/helpers/db_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/models/user.dart';

class Auth with ChangeNotifier {
  User _user;
  Timer _authTimer;

  bool get isAuth {
    return _user != null;
  }

  User get currentUser {
    return _user;
  }

  String get userName {
    String username = '';
    if (_user != null) {
      username = _user.username;
    }
    return username;
  }

  Future<String> _authenticate(
    String username,
    String password,
  ) async {
    final users = await DbHelper.instance.getData('users');
    final user = users.firstWhere(
        (user) => user['username'] == username && user['password'] == password);
    if (user != null) {
      _user = User.fromJson(user);
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'user': jsonEncode(_user.toJson()),
      });
      prefs.setString('userData', userData);
      return '';
    }
    return 'User not registered';
  }

  Future<String> login(
    String email,
    String password,
  ) async {
    return _authenticate(
      email,
      password,
    );
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData = json.decode(prefs.getString('userData'));

    _user = User.fromJson(jsonDecode(extractedUserData['user']));

    return true;
  }

  Future<String> register(
    String username,
    String email,
    String password,
  ) async {
    final users = await DbHelper.instance.getData('users');
    final user = users.any((user) => user['username'] == username);
    if (user) {
      return 'User already registered';
    }
    await DbHelper.instance.insert(
      'users',
      {
        'id': Guid.newGuid.toString(),
        'username': username,
        'email': email,
        'password': password
      },
    );
    return '';
  }

  void logout() async {
    _user = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
