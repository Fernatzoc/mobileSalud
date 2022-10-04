import 'package:flutter/material.dart';

class PregnancyService with ChangeNotifier {
  // Validation
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String names = '';
  String lastnames = '';
  String cui = '';
  String addres = '';
  String dateOfBirth = '';
  String lastRule = '';
  String weight = '';
  String height = '';

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
