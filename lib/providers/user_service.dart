import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mobile_salud/models/new_user_response.dart';

import '../global/environment.dart';
import '../models/index.dart';
import 'auth_service.dart';

class UserService with ChangeNotifier {
  List<User> users = [];

  UserService() {
    getUsers(1);
  }

  //Validation
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String name = '';
  String email = '';
  String password = '';
  String role = '';
  String state = '';
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
      final userCreatedResponse = newUsersResponseFromJson(resp.body);
      users.insert(0, userCreatedResponse.data);
      print(userCreatedResponse);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateUser(String name, String email, String role, String state,
      String password, String idUser) async {
    creatingUser = true;

    final token = await AuthService.getToken();

    final data = {
      'name': name,
      'email': email,
      'role': role,
      'estado': state,
      'password': password,
    };

    final resp = await http.put(
        Uri.parse('${Environment.apiUrl}/users/$idUser'),
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        });

    creatingUser = false;

    if (resp.statusCode == 200) {
      final pregnantCreatedResponse = newUsersResponseFromJson(resp.body);
      var item = users.firstWhere((i) => i.id.toString() == idUser);
      var index = users.indexOf(item);
      users[index] = pregnantCreatedResponse.data;

      print(pregnantCreatedResponse);
      return true;
    } else {
      return false;
    }
  }

  // getUsers(int pageNumber) async {
  //   final token = await AuthService.getToken();
  //   final resp = await http.get(
  //       Uri.parse('${Environment.apiUrl}/users/all?page=$pageNumber'),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $token'
  //       });

  //   if (resp.statusCode == 200) {
  //     final usersResponse = usersResponseFromJson(resp.body);
  //     users.addAll(usersResponse.allUsers!.data);
  //     notifyListeners();
  //     return usersResponse;
  //   } else {
  //     throw Exception("Failed to load data");
  //   }
  // }

  getUsers(int pageNumber) async {
    final token = await AuthService.getToken();
    final resp = await http.get(
        Uri.parse('${Environment.apiUrl}/users/all?page=$pageNumber'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        });

    final usersResponse = usersResponseFromJson(resp.body);
    users.addAll(usersResponse.data);
    print('llamada');
    notifyListeners();
  }
}
