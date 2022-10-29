import 'package:flutter/material.dart';

import '../providers/auth_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("APP"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_outlined),
            onPressed: () {
              Navigator.pushReplacementNamed(context, 'login');
              AuthService.deleteToken();
            },
          ),
        ],
      ),
      body: Table(
        children: [
          const TableRow(
            children: [
              _SingleCard(icon: Icons.people, text: 'Usuarios', page: 'users'),
              _SingleCard(
                icon: Icons.app_registration,
                text: 'Registros',
                page: 'pregnancy',
              )
            ],
          ),
          TableRow(children: [
            const _SingleCard(
                icon: Icons.calculate, text: 'Calculadora', page: 'calculator'),
            Container(),
            // _SingleCard(
            //   icon: Icons.print,
            //   text: 'Reportes',
            //   page: 'report',
            // )
          ])
        ],
      ),
    );
  }
}

class _SingleCard extends StatelessWidget {
  final IconData icon;
  final String text;
  final String page;

  const _SingleCard(
      {Key? key, required this.icon, required this.text, required this.page})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, page);
      },
      child: Container(
        margin: const EdgeInsets.all(15),
        height: 180,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Color(0xffDDDDDD),
                blurRadius: 6.0,
                spreadRadius: 2.0,
                offset: Offset(0.0, 0.0),
              )
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: const Color(0xff6A7AFA),
              radius: 30,
              child: Icon(
                icon,
                size: 35,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              text,
              style: const TextStyle(color: Color(0xff6A7AFA), fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}
