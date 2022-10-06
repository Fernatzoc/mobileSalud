import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/index.dart';
import '../providers/index.dart';

class PregnacyScreen extends StatelessWidget {
  const PregnacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pregnants = Provider.of<PregnancyService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registros'),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () => {},
                child: const Icon(
                  Icons.search,
                  size: 26.0,
                  color: Colors.white,
                ),
              )),
        ],
      ),
      body: pregnants.pregnantsList.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () => pregnants.getPregnants(1),
              child: ListView.builder(
                itemCount: pregnants.pregnantsList.length,
                itemBuilder: (context, index) {
                  return _CardPregnant(
                      pregnant: pregnants.pregnantsList[index]);
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff6A7AFA),
        child: const Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, 'createRegister'),
      ),
    );
  }
}

class _CardPregnant extends StatelessWidget {
  final Pregnant pregnant;

  const _CardPregnant({
    Key? key,
    required this.pregnant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          Navigator.pushNamed(context, 'singlePregnant', arguments: pregnant),
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.all(5),
        child: ListTile(
          leading: const CircleAvatar(
            backgroundColor: Color(0xff6A7AFA),
            child: Text('a'),
          ),
          title: Text(pregnant.nombres),
          subtitle: Text(pregnant.apellidos),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }
}
