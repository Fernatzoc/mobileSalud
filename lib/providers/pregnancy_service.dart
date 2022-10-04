import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../global/environment.dart';
import '../models/index.dart';
import './index.dart';

class PregnancyService with ChangeNotifier {
  // Validation
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String names = '';
  String lastNames = '';
  String cui = '';
  String address = '';
  String dateOfBirth = '';
  String lastRule = '';
  String weight = '';
  String height = '';

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }

  // Pregnant Service
  late Pregnant pregnant;
  bool _creatingPregnant = false;

  bool get creatingPregnant => _creatingPregnant;
  set creatingPregnant(bool value) {
    _creatingPregnant = value;
    notifyListeners();
  }

  Future<bool> createPregnant(
      String names,
      String lastNames,
      String cui,
      String address,
      String dateOfBirth,
      String lastRule,
      String weight,
      String height) async {
    creatingPregnant = true;

    final token = await AuthService.getToken();
    final userId = await AuthService.getIdUser();

    final data = {
      'nombres': names,
      'apellidos': lastNames,
      'cui': cui,
      'direccion': address,
      'fecha_de_nacimiento': dateOfBirth,
      'ultima_regla': lastRule,
      'peso': weight,
      'altura': height,
      'id_user': userId
    };

    final resp = await http.post(Uri.parse('${Environment.apiUrl}/pregnant'),
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        });

    creatingPregnant = false;

    if (resp.statusCode == 201) {
      final pregnantCreatedResponse = newPregnantResponseFromJson(resp.body);
      print(pregnantCreatedResponse);
      return true;
    } else {
      return false;
    }
  }
}
