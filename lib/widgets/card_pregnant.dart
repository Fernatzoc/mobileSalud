import 'package:flutter/material.dart';

import '../models/index.dart';

class CardPregnant extends StatelessWidget {
  final Pregnant pregnant;

  const CardPregnant({
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
          leading: CircleAvatar(
            backgroundColor: const Color(0xff6A7AFA),
            child: Text(pregnant.nombres[0],
                style: const TextStyle(color: Colors.white)),
          ),
          title: Text('${pregnant.nombres} ${pregnant.apellidos}'),
          subtitle: Text('Cui: ${pregnant.cui}'),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }
}
