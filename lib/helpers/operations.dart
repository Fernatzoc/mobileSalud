import 'package:intl/intl.dart';

final DateFormat formatter = DateFormat('dd-MM-yyyy');
final DateTime now = DateTime.now();

int getAge(String fechaNacimiento) {
  var fecha1 = DateFormat('dd-MM-yyyy').parse(fechaNacimiento);
  return now.year - fecha1.year;
}

//Edad

// //Semanas de Emabarazo
// String ultima_regla = '2022-09-25';
// final reglaParse = DateTime.parse(ultima_regla);

// final difference = now.difference(reglaParse).inDays;

// //Fecha de parto

// var newDate =
//     new DateTime(reglaParse.year + 1, reglaParse.month - 3, reglaParse.day + 7);
