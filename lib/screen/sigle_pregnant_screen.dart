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
              _InfoPeso(peso: pregnant.peso, altura: pregnant.altura),
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

  const _InfoPeso({Key? key, required this.peso, required this.altura})
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Image(image: AssetImage('assets/imc.jpg')),
              _TitleAndInfo(
                  title: 'Indice de masa corporal:',
                  value: calcImc(peso, altura).toStringAsFixed(2)),
              const SizedBox(height: 18),
              _TitleAndInfo(
                  title: 'Estado de peso:', value: idealWeight(peso, altura)),
              const SizedBox(height: 18),
              _TitleAndInfo(
                  title: 'Aumento de peso recomendado',
                  value: increaseRecommended(peso, altura))
            ],
          ),
        )
      ],
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
