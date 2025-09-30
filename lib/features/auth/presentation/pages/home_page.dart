import 'package:crypto_app/features/auth/domain/entities/user_entity.dart';
import 'package:crypto_app/features/joke/presentation/pages/joke_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final UserEntity user;

  const HomePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome ${user.name}!'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const JokePage()),
            );
          },
          child: const Text("Go to Jokes"),
        ),
      ),
    );
  }
}
