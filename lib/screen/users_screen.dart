import 'package:flutter/material.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> items = List<String>.generate(5, (i) => '$i');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuarios'),
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
              title: Text('Usuario ${items[index]}'),
              subtitle: const Text('Rol'),
              trailing: const Icon(Icons.more_vert),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, 'createUser'),
      ),
    );
  }
}
