import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'operations.dart';
import '../models/index.dart';

Future<void> makePdf(Pregnant pregnant) async {
  final pdf = pw.Document();
  final imageIMC = pw.MemoryImage(
    (await rootBundle.load('assets/imc.jpg')).buffer.asUint8List(),
  );

  pdf.addPage(
    pw.MultiPage(
      build: (context) {
        return [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Container(
                  decoration: pw.BoxDecoration(
                      borderRadius: pw.BorderRadius.circular(2.0)),
                  padding: const pw.EdgeInsets.all(12),
                  width: double.infinity,
                  child: pw.Text('${pregnant.nombres} ${pregnant.apellidos}',
                      style: pw.TextStyle(
                        fontSize: 22,
                        color: PdfColor.fromHex('#25396F'),
                        fontWeight: pw.FontWeight.bold,
                      ),
                      textAlign: pw.TextAlign.center)),
              pw.SizedBox(height: 15),
              _infoPerson(pregnant),
              pw.SizedBox(height: 15),
              _infoState(pregnant),
              pw.SizedBox(height: 15),
              pw.Column(
                children: [
                  pw.Container(
                    decoration: pw.BoxDecoration(
                      color: PdfColor.fromHex('#97a2fc'),
                    ),
                    padding: const pw.EdgeInsets.all(12),
                    width: double.infinity,
                    child: pw.Text(
                      'Estado nutricional',
                      style: pw.TextStyle(
                          color: PdfColor.fromHex('#ffffff'), fontSize: 15),
                    ),
                  ),
                  pw.Container(
                      decoration: pw.BoxDecoration(
                          color: PdfColor.fromHex('#ffffff'),
                          borderRadius: pw.BorderRadius.circular(2.0)),
                      padding: const pw.EdgeInsets.all(12),
                      width: double.infinity,
                      child: getWeeks(pregnant.ultimaRegla) < 12
                          ? int.parse(pregnant.cmb) < 23
                              ? _tableCmbB(pregnant)
                              : _tableCmbA(pregnant)

                          // ? _TableCmbB(cmb: cmb)
                          // : _TableCmbA(cmb: cmb)
                          : pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                // Image(image: pw.AssetImage('assets/imc.jpg')),
                                pw.Image(imageIMC),
                                _titleAndInfo(
                                    'Indice de masa corporal:',
                                    calcImc(pregnant.peso, pregnant.altura)
                                        .toStringAsFixed(2)),
                                pw.SizedBox(height: 18),
                                _titleAndInfo(
                                    'Estado de peso:',
                                    idealWeight(
                                        pregnant.peso, pregnant.altura)),
                                pw.SizedBox(height: 18),
                                _titleAndInfo(
                                    'Aumento de peso recomendado',
                                    increaseRecommended(
                                        pregnant.peso, pregnant.altura))
                              ],
                            ))
                ],
              )
            ],
          )
        ];
      },
    ),
  );

  await Printing.layoutPdf(
      name: 'Reporte ${pregnant.nombres} ${pregnant.apellidos}',
      onLayout: (PdfPageFormat format) async => pdf.save());
  // return pdf.save();
}

pw.Column _tableCmbA(Pregnant pregnant) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      _titleAndInfo('Cmb', '${pregnant.cmb} cm'),
      pw.SizedBox(height: 18),
      pw.Text(
        'Tabla de ganancia de peso mínimo esperado en embarazadas utilizando circunferencia de brazo medida en el primer trimestre',
        style: pw.TextStyle(color: PdfColor.fromHex('#25396F'), fontSize: 15),
      ),
      pw.SizedBox(height: 18),
      pw.Table(
        border: pw.TableBorder.all(color: PdfColor.fromHex('#808080')),
        defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
        children: [
          pw.TableRow(
              decoration: pw.BoxDecoration(color: PdfColor.fromHex('#97a2fc')),
              children: [
                pw.Text(
                  "Mes de embarazo",
                  style: pw.TextStyle(
                      fontSize: 16.0,
                      color: PdfColor.fromHex('#ffffff'),
                      fontWeight: pw.FontWeight.bold),
                  textAlign: pw.TextAlign.center,
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(8.0),
                  child: pw.Text(
                    "Libras que deben aumentar las mujeres con circunferencia de brazo igual o mayor de 23 cm",
                    style: pw.TextStyle(
                        fontSize: 16.0,
                        color: PdfColor.fromHex('#ffffff'),
                        fontWeight: pw.FontWeight.bold),
                    textAlign: pw.TextAlign.center,
                  ),
                ),
              ]),
          pw.TableRow(children: [
            _valueRowTable('1'),
            _valueRowTable('1/2 lb'),
          ]),
          pw.TableRow(children: [
            _valueRowTable('2'),
            _valueRowTable('1/2 lb'),
          ]),
          pw.TableRow(children: [
            _valueRowTable('3'),
            _valueRowTable('1 lb'),
          ]),
          pw.TableRow(children: [
            _valueRowTable('4'),
            _valueRowTable('3 lb'),
          ]),
          pw.TableRow(children: [
            _valueRowTable('5'),
            _valueRowTable('3 lb'),
          ]),
          pw.TableRow(children: [
            _valueRowTable('6'),
            _valueRowTable('3 lb'),
          ]),
          pw.TableRow(children: [
            _valueRowTable('7'),
            _valueRowTable('3 lb'),
          ]),
          pw.TableRow(children: [
            _valueRowTable('8'),
            _valueRowTable('2 1/2 lb'),
          ]),
          pw.TableRow(children: [
            _valueRowTable('9'),
            _valueRowTable('1 lb'),
          ]),
          pw.TableRow(children: [
            _valueRowTable('Total'),
            _valueRowTable('17 1/2 lb'),
          ]),
        ],
      )
    ],
  );
}

pw.Column _tableCmbB(Pregnant pregnant) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      _titleAndInfo('Cmb', '${pregnant.cmb} cm'),
      pw.SizedBox(height: 18),
      pw.Table(
        border: pw.TableBorder.all(color: PdfColor.fromHex('#808080')),
        defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
        children: [
          pw.TableRow(
              decoration: pw.BoxDecoration(color: PdfColor.fromHex('#97a2fc')),
              children: [
                pw.Text(
                  "Mes de embarazo",
                  style: pw.TextStyle(
                      fontSize: 16.0,
                      color: PdfColor.fromHex('#ffffff'),
                      fontWeight: pw.FontWeight.bold),
                  textAlign: pw.TextAlign.center,
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(8.0),
                  child: pw.Text(
                    "Libras que deben aumentar las mujeres con circunferencia de brazo menor de 23 cm",
                    style: pw.TextStyle(
                        fontSize: 16.0,
                        color: PdfColor.fromHex('#ffffff'),
                        fontWeight: pw.FontWeight.bold),
                    textAlign: pw.TextAlign.center,
                  ),
                ),
              ]),
          pw.TableRow(children: [
            _valueRowTable('1'),
            _valueRowTable('1 lb'),
          ]),
          pw.TableRow(children: [
            _valueRowTable('2'),
            _valueRowTable('1 lb'),
          ]),
          pw.TableRow(children: [
            _valueRowTable('3'),
            _valueRowTable('2 lb'),
          ]),
          pw.TableRow(children: [
            _valueRowTable('4'),
            _valueRowTable('5 lb'),
          ]),
          pw.TableRow(children: [
            _valueRowTable('5'),
            _valueRowTable('5 lb'),
          ]),
          pw.TableRow(children: [
            _valueRowTable('6'),
            _valueRowTable('5 lb'),
          ]),
          pw.TableRow(children: [
            _valueRowTable('7'),
            _valueRowTable('5 lb'),
          ]),
          pw.TableRow(children: [
            _valueRowTable('8'),
            _valueRowTable('4 lb'),
          ]),
          pw.TableRow(children: [
            _valueRowTable('9'),
            _valueRowTable('2 lb'),
          ]),
          pw.TableRow(children: [
            _valueRowTable('Total'),
            _valueRowTable('30 lb'),
          ]),
        ],
      )
    ],
  );
}

pw.Padding _valueRowTable(String value) {
  return pw.Padding(
    padding: const pw.EdgeInsets.all(8.0),
    child: pw.Text(
      value,
      style: pw.TextStyle(fontSize: 17.0, color: PdfColor.fromHex('#25396F')),
      textAlign: pw.TextAlign.center,
    ),
  );
}

pw.Column _infoPerson(Pregnant pregnant) {
  return pw.Column(children: [
    pw.Container(
        decoration: pw.BoxDecoration(color: PdfColor.fromHex('#97a2fc')),
        padding: const pw.EdgeInsets.all(12),
        width: double.infinity,
        child: pw.Text('Datos Personales',
            style: pw.TextStyle(
              fontSize: 15,
              color: PdfColor.fromHex('#ffffff'),
            ))),
    pw.Container(
        decoration: pw.BoxDecoration(
            color: PdfColor.fromHex('#ffffff'),
            borderRadius: pw.BorderRadius.circular(2.0)),
        padding: const pw.EdgeInsets.all(12),
        width: double.infinity,
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
              children: [
                _titleAndInfo('Edad', getAge(pregnant.fechaDeNacimiento)),
                _titleAndInfo('Peso', '${pregnant.peso} lb'),
                _titleAndInfo('Altura', '${pregnant.altura} mt'),
                _titleAndInfo('Cmb', '${pregnant.cmb} cm'),
              ],
            ),
            pw.SizedBox(height: 18),
            _titleAndInfo('Cui', pregnant.cui),
            pw.SizedBox(height: 18),
            _titleAndInfo('Dirección', pregnant.direccion),
            pw.SizedBox(height: 18),
            _titleAndInfo('Fecha de nacimiento', pregnant.fechaDeNacimiento),
            pw.SizedBox(height: 18),
            _titleAndInfo('Fecha de registro', pregnant.createdAt),
            pw.SizedBox(height: 18),
            _titleAndInfo('Registrado por:', pregnant.userName.toString()),
            pw.SizedBox(height: 18),
          ],
        )),
  ]);
}

pw.Column _infoState(Pregnant pregnant) {
  return pw.Column(
    children: [
      pw.Container(
        decoration: pw.BoxDecoration(
          color: PdfColor.fromHex('#97a2fc'),
        ),
        padding: const pw.EdgeInsets.all(12),
        width: double.infinity,
        child: pw.Text(
          'Edad Gestacional',
          style: pw.TextStyle(color: PdfColor.fromHex('#ffffff'), fontSize: 15),
        ),
      ),
      pw.Container(
        decoration: pw.BoxDecoration(
            color: PdfColor.fromHex('#ffffff'),
            borderRadius: pw.BorderRadius.circular(2.0)),
        padding: const pw.EdgeInsets.all(12),
        width: double.infinity,
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            _titleAndInfo(pregnant.tipoDeExamen, pregnant.ultimaRegla),
            pw.SizedBox(height: 18),
            _titleAndInfo('Trimestre:', getQuarterly(pregnant.ultimaRegla)),
            pw.SizedBox(height: 18),
            _titleAndInfo(
                'Semanas', getWeeks(pregnant.ultimaRegla).toStringAsFixed(2)),
            pw.SizedBox(height: 18),
            _titleAndInfo(
              'Fecha prevista de parto',
              getDateOfBirth(pregnant.ultimaRegla),
            )
          ],
        ),
      )
    ],
  );
}

pw.Column _titleAndInfo(String title, String value) {
  return pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
    pw.Text(title,
        style: pw.TextStyle(
            color: PdfColor.fromHex('#25396F'),
            fontSize: 15,
            fontWeight: pw.FontWeight.bold)),
    pw.Text(value,
        style: pw.TextStyle(color: PdfColor.fromHex('#25396F'), fontSize: 15))
  ]);
}
