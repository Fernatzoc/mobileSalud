import 'package:intl/intl.dart';

final DateFormat formatter = DateFormat('dd-MM-yyyy');
final DateTime now = DateTime.now();

// Calc
String formaterDate(String lastRule) {
  var fecha1 = DateTime.parse(lastRule);
  return formatter.format(fecha1);
}

// Au

String getAge(String fechaNacimiento) {
  var fecha1 = DateFormat('dd-MM-yyyy').parse(fechaNacimiento);
  return (now.year - fecha1.year).toString();
}

double getWeeks(String lastRule) {
  final fecha1 = DateFormat('dd-MM-yyyy').parse(lastRule);
  final diference = (now.difference(fecha1).inDays) / 7;
  return diference;
}

String getDateOfBirth(String lastRule) {
  final fecha1 = DateFormat('dd-MM-yyyy').parse(lastRule);
  final newDate = DateTime(fecha1.year + 1, fecha1.month - 3, fecha1.day + 7);
  return formatter.format(newDate);
}

String getQuarterly(String lastRule) {
  final weeks = getWeeks(lastRule);
  if (weeks > 0 && weeks <= 12) {
    return 'Primer trimeste';
  } else if (weeks >= 13 && weeks <= 24) {
    return 'Segundo trimestre';
  } else if (weeks >= 25) {
    return 'Tercer trimestre';
  } else {
    return 'Fuera de rango';
  }
}

double calcImc(String peso, String altura) {
  final pesoKilos = (int.parse(peso) / 2.2);
  final talla = (double.parse(altura) * double.parse(altura));
  return pesoKilos / talla;
}

String idealWeight(String peso, String altura) {
  final imc = calcImc(peso, altura);
  if (imc < 18.5) {
    return 'E: Peso por debajo de lo normal';
  } else if (imc >= 18.5 && imc <= 24.9) {
    return 'N: Peso normal';
  } else if (imc >= 25 && imc <= 29.9) {
    return 'S: Sobre peso';
  } else if (imc > 30) {
    return 'O: Obesidad';
  } else {
    return 'Fuera de rango';
  }
}

String increaseRecommended(String peso, String altura) {
  final imc = idealWeight(peso, altura);
  if (imc.toString() == 'E: Peso por debajo de lo normal') {
    return '26 a 39 lb';
  } else if (imc.toString() == 'N: Peso normal') {
    return '22 a 28 lb';
  } else if (imc.toString() == 'S: Sobre peso') {
    return '15 a 22 lb';
  } else if (imc.toString() == 'O: Obesidad') {
    return '13 a 15 lb';
  } else {
    return 'Fuera de rango';
  }
}
