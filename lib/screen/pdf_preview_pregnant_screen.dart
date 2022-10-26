import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../helpers/operations.dart';
import '../models/index.dart';

class PdfPreviewPregnantScreen extends StatelessWidget {
  // final Invoice invoice;
  const PdfPreviewPregnantScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Pregnant pregnant =
        ModalRoute.of(context)!.settings.arguments as Pregnant;
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Preview'),
      ),
      body: PdfPreview(
        build: (context) => _makePdf(pregnant),
      ),
    );
  }
}

Future<Uint8List> _makePdf(Pregnant pregnant) async {
  final pdf = pw.Document();
  // final font = await PdfGoogleFonts.notoSans();

  pdf.addPage(
    pw.Page(
      build: (context) {
        return pw.Column(
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
            pw.Text('Edad ${getAge(pregnant.fechaDeNacimiento)}')
          ],
        );
      },
    ),
  );

  return pdf.save();
}
