import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_service.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final users = Provider.of<UserService>(context).users;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuarios'),
      ),
      body: users.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: users.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.all(5),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: const Color(0xff6A7AFA),
                      child: Text(
                        users[index].name![0],
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(users[index].name!),
                    subtitle: Text(users[index].rol!),
                    // trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, 'createUser'),
      ),
    );
  }
}
