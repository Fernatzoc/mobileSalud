import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../global/environment.dart';
import '../models/index.dart';
import 'auth_service.dart';

class UserService with ChangeNotifier {
  //Validation
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String name = '';
  String email = '';
  String password = '';
  String role = '';
  bool _isObscure = true;

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }

  bool get isObscure => _isObscure;
  set isObscure(bool value) {
    _isObscure = value;
    notifyListeners();
  }

  // User Service
  late User user;
  bool _creatingUser = false;

  bool get creatingUser => _creatingUser;
  set creatingUser(bool value) {
    _creatingUser = value;
    notifyListeners();
  }

  Future<bool> createUser(
      String name, String email, String role, String password) async {
    creatingUser = true;

    final data = {
      'name': name,
      'email': email,
      'role': role,
      'password': password
    };

    final token = await AuthService.getToken();
    final resp = await http.post(Uri.parse('${Environment.apiUrl}/users/new'),
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        });

    creatingUser = false;

    if (resp.statusCode == 201) {
      final userCreatedResponse = loginResponseFromJson(resp.body);
      print(userCreatedResponse);
      return true;
    } else {
      return false;
    }
  }
}
