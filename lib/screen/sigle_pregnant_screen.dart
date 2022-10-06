import 'package:flutter/material.dart';

import '../helpers/operations.dart';
import '../models/index.dart';

const Color colorText = Color(0xff25396F);
const String fontText = 'NotoSans';

class SinglePregnantScreen extends StatelessWidget {
  const SinglePregnantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Pregnant pregnant =
        ModalRoute.of(context)!.settings.arguments as Pregnant;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(5.0),
          margin: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Header(
                names: pregnant.nombres,
                lastNames: pregnant.apellidos,
              ),
              const SizedBox(height: 15),
              _InfoPerson(
                cui: pregnant.cui,
                address: pregnant.direccion,
                nacimientoDate: pregnant.fechaDeNacimiento,
                peso: pregnant.peso,
                altura: pregnant.altura,
                createdAt: pregnant.createdAt,
                autor: pregnant.userName!,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final String names;
  final String lastNames;

  const _Header({Key? key, required this.names, required this.lastNames})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Color colorPrimary = Theme.of(context).primaryColor;

    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(2.0)),
      padding: const EdgeInsets.all(12),
      width: double.infinity,
      child: Text(
        '$names $lastNames',
        style: const TextStyle(
            fontSize: 22,
            color: colorText,
            fontFamily: fontText,
            fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _InfoPerson extends StatelessWidget {
  final String cui;
  final String address;
  final String nacimientoDate;
  final String peso;
  final String altura;
  final String createdAt;
  final String autor;

  const _InfoPerson(
      {Key? key,
      required this.address,
      required this.nacimientoDate,
      required this.cui,
      required this.peso,
      required this.altura,
      required this.createdAt,
      required this.autor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Color(0xff97a2fc),
          ),
          padding: const EdgeInsets.all(12),
          width: double.infinity,
          child: const Text(
            'Datos Personales',
            style: TextStyle(
                color: Colors.white, fontFamily: fontText, fontSize: 15),
          ),
        ),
        Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(2.0)),
            padding: const EdgeInsets.all(12),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        const Text(
                          'Edad',
                          style: TextStyle(
                              color: colorText,
                              fontFamily: fontText,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          getAge(nacimientoDate).toString(),
                          style: const TextStyle(
                              color: colorText, fontFamily: fontText),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        const Text(
                          'Peso',
                          style: TextStyle(
                              color: colorText,
                              fontFamily: fontText,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '$peso lb',
                          style: const TextStyle(
                              color: colorText, fontFamily: fontText),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        const Text(
                          'Altura',
                          style: TextStyle(
                              color: colorText,
                              fontFamily: fontText,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '$altura mt',
                          style: const TextStyle(
                              color: colorText, fontFamily: fontText),
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'CUI',
                      style: TextStyle(
                          color: colorText,
                          fontSize: 15,
                          fontFamily: fontText,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(cui,
                        style: const TextStyle(
                            color: colorText,
                            fontSize: 15,
                            fontFamily: fontText))
                  ],
                ),
                const SizedBox(height: 18),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Dirección',
                      style: TextStyle(
                          color: colorText,
                          fontSize: 15,
                          fontFamily: fontText,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(address,
                        style: const TextStyle(
                            color: colorText,
                            fontSize: 15,
                            fontFamily: fontText))
                  ],
                ),
                const SizedBox(height: 18),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Fecha de nacimiento',
                      style: TextStyle(
                          color: colorText,
                          fontSize: 15,
                          fontFamily: fontText,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(nacimientoDate,
                        style: const TextStyle(
                            color: colorText,
                            fontSize: 15,
                            fontFamily: fontText))
                  ],
                ),
                const SizedBox(height: 18),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Fecha de registro',
                      style: TextStyle(
                          color: colorText,
                          fontSize: 15,
                          fontFamily: fontText,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(createdAt,
                        style: const TextStyle(
                            color: colorText,
                            fontSize: 15,
                            fontFamily: fontText))
                  ],
                ),
                const SizedBox(height: 18),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Registrado por:',
                      style: TextStyle(
                          color: colorText,
                          fontSize: 15,
                          fontFamily: fontText,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(autor,
                        style: const TextStyle(
                            color: colorText,
                            fontSize: 15,
                            fontFamily: fontText))
                  ],
                ),
                const SizedBox(height: 18),
              ],
            )),
      ],
    );
  }
}
