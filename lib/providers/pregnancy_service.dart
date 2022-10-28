import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../global/environment.dart';
import '../helpers/debouncer.dart';
import '../models/index.dart';
import './index.dart';

class PregnancyService with ChangeNotifier {
  List<Pregnant> pregnantsList = [];

  PregnancyService() {
    getPregnants(1);
  }

  getPregnants(int pageNumber) async {
    // if (pregnantsList.isNotEmpty) {
    //   return pregnantsList;
    // }
    pregnantsList.clear();

    final token = await AuthService.getToken();
    final resp = await http.get(
        Uri.parse('${Environment.apiUrl}/pregnant?page=$pageNumber'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        });

    final pregnantsResponse = pregnantResponseFromJson(resp.body);
    pregnantsList.addAll(pregnantsResponse.data!);

    print('llamada embarazos');
    notifyListeners();
  }

  // Validation
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String names = '';
  String lastNames = '';
  String cui = '';
  String address = '';
  String dateOfBirth = '';
  String examType = '';
  String lastRule = '';
  String weight = '';
  String height = '';
  String cmb = '';

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
      String examType,
      String lastRule,
      String weight,
      String height,
      String cmb) async {
    creatingPregnant = true;

    final token = await AuthService.getToken();
    final userId = await AuthService.getIdUser();

    final data = {
      'nombres': names,
      'apellidos': lastNames,
      'cui': cui,
      'direccion': address,
      'fecha_de_nacimiento': dateOfBirth,
      'tipo_de_examen': examType,
      'ultima_regla': lastRule,
      'peso': weight,
      'altura': height,
      'cmb': cmb,
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
      pregnantsList.insert(0, pregnantCreatedResponse.data);
      print(pregnantCreatedResponse);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updatePregnant(
      String idPregnant,
      String names,
      String lastNames,
      String cui,
      String address,
      String dateOfBirth,
      String examType,
      String lastRule,
      String weight,
      String height,
      String cmb) async {
    creatingPregnant = true;

    final token = await AuthService.getToken();
    final userId = await AuthService.getIdUser();

    final data = {
      'nombres': names,
      'apellidos': lastNames,
      'cui': cui,
      'direccion': address,
      'fecha_de_nacimiento': dateOfBirth,
      'tipo_de_examen': examType,
      'ultima_regla': lastRule,
      'peso': weight,
      'altura': height,
      'cmb': cmb,
      'id_user': userId
    };

    final resp = await http.put(
        Uri.parse('${Environment.apiUrl}/pregnant/$idPregnant'),
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        });

    creatingPregnant = false;

    if (resp.statusCode == 200) {
      final pregnantCreatedResponse = newPregnantResponseFromJson(resp.body);
      var item = pregnantsList.firstWhere((i) => i.id.toString() == idPregnant);
      var index = pregnantsList.indexOf(item);
      pregnantsList[index] = pregnantCreatedResponse.data;

      print(pregnantCreatedResponse);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deletePregnant(String idPregnant) async {
    creatingPregnant = true;

    final token = await AuthService.getToken();

    final resp = await http.delete(
        Uri.parse('${Environment.apiUrl}/pregnant/$idPregnant'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        });

    creatingPregnant = false;

    if (resp.statusCode == 200) {
      pregnantsList.removeWhere((i) => i.id.toString() == idPregnant);
      return true;
    } else {
      return false;
    }
  }

  final debouncer = Debouncer(
    duration: const Duration(milliseconds: 500),
    // onValue:
  );

  final StreamController<List<Pregnant>> _suggestionsStreamController =
      StreamController.broadcast();
  Stream<List<Pregnant>> get suggestionStream =>
      _suggestionsStreamController.stream;

  Future<List<Pregnant>?> searchPregnant(String query) async {
    final url = Uri.parse('${Environment.apiUrl}/pregnant/search/$query');

    final response = await http.get(url);
    final searchResponse = pregnantResponseFromJson(response.body);

    return searchResponse.data;
  }

  void getSuggestionsByQuery(String searchTerm) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      final results = await searchPregnant(value);
      _suggestionsStreamController.add(results!);
    };

    final timer = Timer.periodic(const Duration(milliseconds: 300), (_) {
      debouncer.value = searchTerm;
    });

    Future.delayed(const Duration(milliseconds: 301))
        .then((_) => timer.cancel());
  }
}
