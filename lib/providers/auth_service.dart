import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../global/environment.dart';
import '../models/index.dart';

class AuthService with ChangeNotifier {
  //Validation
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyForgotPasword = GlobalKey<FormState>();

  String email = '';
  String password = '';
  bool _isObscure = true;

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }

  bool isValidFormForgot() {
    return formKeyForgotPasword.currentState?.validate() ?? false;
  }

  bool get isObscure => _isObscure;
  set isObscure(bool value) {
    _isObscure = value;
    notifyListeners();
  }

  // Auth Service

  late String user;
  bool _authenticating = false;

  // Create storage
  final _storage = const FlutterSecureStorage();

  bool get authenticating => _authenticating;
  set authenticating(bool value) {
    _authenticating = value;
    notifyListeners();
  }

  //Getters token static
  static Future<String?> getToken() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    return token;
  }

  static Future<String?> getIdUser() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'idUser');
    return token;
  }

  static Future<String?> getRole() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'role');
    return token;
  }

  static Future<void> deleteToken() async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: 'token');
    await storage.delete(key: 'idUser');
    await storage.delete(key: 'role');
  }

  Future<bool> login(String email, String password) async {
    authenticating = true;

    final data = {'email': email, 'password': password};

    final resp = await http.post(Uri.parse('${Environment.apiUrl}/users/login'),
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    authenticating = false;

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      user = loginResponse.id;

      await _saveToken(loginResponse.token, loginResponse.id);
      return true;
    } else {
      return false;
    }
  }

  Future<bool?> isLoggedIn() async {
    final token = await _storage.read(key: 'token');
    final resp = await http
        .get(Uri.parse('${Environment.apiUrl}/users/refresh'), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    });

    print(resp.body);

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      user = loginResponse.id;
      await _saveToken(loginResponse.token, loginResponse.id);
      return true;
    } else {
      logout();
      return false;
    }
  }

  Future _saveToken(String token, String idUser) async {
    await _storage.write(key: 'idUser', value: idUser);
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    await _storage.delete(key: 'idUser');
    await _storage.delete(key: 'token');
  }

  Future<bool> forgotPassword(String email) async {
    authenticating = true;

    final data = {'email': email};

    final resp = await http.post(
        Uri.parse('${Environment.apiUrl}/password/email'),
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'});

    authenticating = false;

    if (resp.statusCode == 200) {
      print(resp.body);

      return true;
    } else {
      return false;
    }
  }
}
