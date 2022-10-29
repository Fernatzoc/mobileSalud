import 'package:flutter/material.dart';

import '../models/index.dart';

class SingleUserScreen extends StatelessWidget {
  const SingleUserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User user = ModalRoute.of(context)!.settings.arguments as User;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuario'),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () =>
                    Navigator.pushNamed(context, 'updateUser', arguments: user),
                child: const Icon(
                  Icons.mode_edit_outline,
                  size: 26.0,
                  color: Colors.white,
                ),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(5.0),
          margin: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _InfoPerson(
                name: user.name.toString(),
                email: user.email.toString(),
                rol: user.rol.toString(),
                state: user.estado.toString(),
                id: user.id.toString(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoPerson extends StatelessWidget {
  final String name;
  final String email;
  final String rol;
  final String state;
  final String id;

  const _InfoPerson({
    Key? key,
    required this.name,
    required this.email,
    required this.rol,
    required this.state,
    required this.id,
  }) : super(key: key);

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
                color: Colors.white, fontFamily: 'NotoSans', fontSize: 15),
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
                _TitleAndInfo(title: 'Nombre', value: name),
                const SizedBox(height: 18),
                _TitleAndInfo(title: 'Correo', value: email),
                const SizedBox(height: 18),
                _TitleAndInfo(title: 'Rol', value: rol),
                const SizedBox(height: 18),
                _TitleAndInfo(title: 'Estado', value: state),
                const SizedBox(height: 18),
              ],
            )),
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
              color: Color(0xff25396F),
              fontSize: 15,
              fontFamily: 'NotoSans',
              fontWeight: FontWeight.w700),
        ),
        Text(
          value,
          style: const TextStyle(
              color: Color(0xff25396F), fontSize: 15, fontFamily: 'NotoSans'),
        )
      ],
    );
  }
}
