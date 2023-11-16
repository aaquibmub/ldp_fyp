import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:ldp_fyp/helpers/db_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/models/user.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  User _user;
  Timer _authTimer;

  bool get isAuth {
    return token != null;
  }

  User get currentUser {
    return _user;
  }

  String get userName {
    String username = '';
    if (_user != null) {
      username = _user.userName;
    }
    return username;
  }

  String get token {
    if (_token != null &&
        _expiryDate != null &&
        _expiryDate.isAfter(DateTime.now())) {
      return _token;
    }
    return null;
  }

  Future<String> _authenticate(
    String username,
    String password,
  ) async {
    final users = await DbHelper.getData('users');
    final user = users.firstWhere(
        (user) => user['username'] == username && user['password'] == password);
    if (user != null) {
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

  Future<String> register(
    String username,
    String email,
    String password,
  ) async {
    await DbHelper.insert(
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
    _token = null;
    _user = null;
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
