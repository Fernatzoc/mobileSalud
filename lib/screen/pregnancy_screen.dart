import 'package:flutter/material.dart';

class PregnacyScreen extends StatelessWidget {
  const PregnacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> items = List<String>.generate(30, (i) => '$i');

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
      body: Center(
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: const Color(0xff6A7AFA),
                child: Text(items[index]),
              ),
              title: const Text('nombre apellido'),
              subtitle: const Text('Estado'),
              trailing: const Icon(Icons.more_vert),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff6A7AFA),
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
