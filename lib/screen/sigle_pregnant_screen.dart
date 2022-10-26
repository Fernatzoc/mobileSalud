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
                cmb: pregnant.cmb,
                createdAt: pregnant.createdAt,
                autor: pregnant.userName!,
              ),
              const SizedBox(height: 15),
              _InfoState(lastRule: pregnant.ultimaRegla),
              const SizedBox(height: 15),
              _InfoPeso(
                peso: pregnant.peso,
                altura: pregnant.altura,
                lastRule: pregnant.ultimaRegla,
                cmb: pregnant.cmb,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'previewPregnantPdf',
              arguments: pregnant);
        },
        child: const Icon(Icons.picture_as_pdf),
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
  final String cmb;
  final String createdAt;
  final String autor;

  const _InfoPerson(
      {Key? key,
      required this.address,
      required this.nacimientoDate,
      required this.cui,
      required this.peso,
      required this.altura,
      required this.cmb,
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
                    _TitleAndInfo(
                        title: 'Edad', value: '${getAge(nacimientoDate)} años'),
                    _TitleAndInfo(title: 'Peso', value: '$peso lb'),
                    _TitleAndInfo(title: 'Altura', value: '$altura mt'),
                    _TitleAndInfo(title: 'Cmb', value: '$cmb cm'),
                  ],
                ),
                const SizedBox(height: 18),
                _TitleAndInfo(title: 'Cui', value: cui),
                const SizedBox(height: 18),
                _TitleAndInfo(title: 'Dirección', value: address),
                const SizedBox(height: 18),
                _TitleAndInfo(
                    title: 'Fecha de nacimiento', value: nacimientoDate),
                const SizedBox(height: 18),
                _TitleAndInfo(title: 'Fecha de registro', value: createdAt),
                const SizedBox(height: 18),
                _TitleAndInfo(title: 'Registrado por:', value: autor),
                const SizedBox(height: 18),
              ],
            )),
      ],
    );
  }
}

class _InfoState extends StatelessWidget {
  final String lastRule;

  const _InfoState({Key? key, required this.lastRule}) : super(key: key);

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
            'Edad Gestacional',
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
              _TitleAndInfo(title: 'Ultima regla', value: lastRule),
              const SizedBox(height: 18),
              _TitleAndInfo(title: 'Trimestre:', value: getQuarterly(lastRule)),
              const SizedBox(height: 18),
              _TitleAndInfo(
                  title: 'Semanas',
                  value: getWeeks(lastRule).toStringAsFixed(2)),
              const SizedBox(height: 18),
              _TitleAndInfo(
                title: 'Fecha prevista de parto',
                value: getDateOfBirth(lastRule),
              )
            ],
          ),
        )
      ],
    );
  }
}

class _InfoPeso extends StatelessWidget {
  final String peso;
  final String altura;
  final String lastRule;
  final String cmb;

  const _InfoPeso(
      {Key? key,
      required this.peso,
      required this.altura,
      required this.lastRule,
      required this.cmb})
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
            'Estado nutricional',
            style: TextStyle(
                color: Colors.white, fontFamily: fontText, fontSize: 15),
          ),
        ),
        Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(2.0)),
            padding: const EdgeInsets.all(12),
            width: double.infinity,
            child: getWeeks(lastRule) < 12
                ? int.parse(cmb) < 23
                    ? _TableCmbB(cmb: cmb)
                    : _TableCmbA(cmb: cmb)
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Image(image: AssetImage('assets/imc.jpg')),
                      _TitleAndInfo(
                          title: 'Indice de masa corporal:',
                          value: calcImc(peso, altura).toStringAsFixed(2)),
                      const SizedBox(height: 18),
                      _TitleAndInfo(
                          title: 'Estado de peso:',
                          value: idealWeight(peso, altura)),
                      const SizedBox(height: 18),
                      _TitleAndInfo(
                          title: 'Aumento de peso recomendado',
                          value: increaseRecommended(peso, altura))
                    ],
                  ))
      ],
    );
  }
}

class _TableCmbA extends StatelessWidget {
  const _TableCmbA({
    Key? key,
    required this.cmb,
  }) : super(key: key);

  final String cmb;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _TitleAndInfo(title: 'Cmb', value: '$cmb cm'),
        const SizedBox(height: 18),
        const Text(
          'Tabla de ganancia de peso mínimo esperado en embarazadas utilizando circunferencia de brazo medida en el primer trimestre',
          style:
              TextStyle(color: colorText, fontFamily: fontText, fontSize: 15),
        ),
        const SizedBox(height: 18),
        Table(
          border: TableBorder.all(color: Colors.grey),
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: const [
            TableRow(
                decoration: BoxDecoration(color: Color(0xff97a2fc)),
                children: [
                  Text(
                    "Mes de embarazo",
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                        fontFamily: 'NotoSans',
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Libras que deben aumentar las mujeres con circunferencia de brazo igual o mayor de 23 cm",
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                          fontFamily: 'NotoSans',
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ]),
            TableRow(children: [
              _ValueRowTable(value: '1'),
              _ValueRowTable(value: '1/2 lb'),
            ]),
            TableRow(children: [
              _ValueRowTable(value: '2'),
              _ValueRowTable(value: '1/2 lb'),
            ]),
            TableRow(children: [
              _ValueRowTable(value: '3'),
              _ValueRowTable(value: '1 lb'),
            ]),
            TableRow(children: [
              _ValueRowTable(value: '4'),
              _ValueRowTable(value: '3 lb'),
            ]),
            TableRow(children: [
              _ValueRowTable(value: '5'),
              _ValueRowTable(value: '3 lb'),
            ]),
            TableRow(children: [
              _ValueRowTable(value: '6'),
              _ValueRowTable(value: '3 lb'),
            ]),
            TableRow(children: [
              _ValueRowTable(value: '7'),
              _ValueRowTable(value: '3 lb'),
            ]),
            TableRow(children: [
              _ValueRowTable(value: '8'),
              _ValueRowTable(value: '2 1/2 lb'),
            ]),
            TableRow(children: [
              _ValueRowTable(value: '9'),
              _ValueRowTable(value: '1 lb'),
            ]),
            TableRow(children: [
              _ValueRowTable(value: 'Total'),
              _ValueRowTable(value: '17 1/2 lb'),
            ]),
          ],
        )
      ],
    );
  }
}

class _TableCmbB extends StatelessWidget {
  const _TableCmbB({
    Key? key,
    required this.cmb,
  }) : super(key: key);

  final String cmb;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _TitleAndInfo(title: 'Cmb', value: '$cmb cm'),
        const SizedBox(height: 18),
        Table(
          border: TableBorder.all(color: Colors.grey),
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: const [
            TableRow(
                decoration: BoxDecoration(color: Color(0xff97a2fc)),
                children: [
                  Text(
                    "Mes de embarazo",
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                        fontFamily: 'NotoSans',
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Libras que deben aumentar las mujeres con circunferencia de brazo menor de 23 cm",
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                          fontFamily: 'NotoSans',
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ]),
            TableRow(children: [
              _ValueRowTable(value: '1'),
              _ValueRowTable(value: '1 lb'),
            ]),
            TableRow(children: [
              _ValueRowTable(value: '2'),
              _ValueRowTable(value: '1 lb'),
            ]),
            TableRow(children: [
              _ValueRowTable(value: '3'),
              _ValueRowTable(value: '2 lb'),
            ]),
            TableRow(children: [
              _ValueRowTable(value: '4'),
              _ValueRowTable(value: '5 lb'),
            ]),
            TableRow(children: [
              _ValueRowTable(value: '5'),
              _ValueRowTable(value: '5 lb'),
            ]),
            TableRow(children: [
              _ValueRowTable(value: '6'),
              _ValueRowTable(value: '5 lb'),
            ]),
            TableRow(children: [
              _ValueRowTable(value: '7'),
              _ValueRowTable(value: '5 lb'),
            ]),
            TableRow(children: [
              _ValueRowTable(value: '8'),
              _ValueRowTable(value: '4 lb'),
            ]),
            TableRow(children: [
              _ValueRowTable(value: '9'),
              _ValueRowTable(value: '2 lb'),
            ]),
            TableRow(children: [
              _ValueRowTable(value: 'Total'),
              _ValueRowTable(value: '30 lb'),
            ]),
          ],
        )
      ],
    );
  }
}

class _ValueRowTable extends StatelessWidget {
  final String value;

  const _ValueRowTable({
    Key? key,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        value,
        style: const TextStyle(
            fontSize: 17.0, color: colorText, fontFamily: fontText),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _TitleAndInfo extends StatelessWidget {
  final String title;
  final String value;

  const _TitleAndInfo({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
              color: colorText,
              fontSize: 15,
              fontFamily: fontText,
              fontWeight: FontWeight.w700),
        ),
        Text(
          value,
          style: const TextStyle(
              color: colorText, fontSize: 15, fontFamily: fontText),
        )
      ],
    );
  }
}
