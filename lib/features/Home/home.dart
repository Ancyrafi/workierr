import 'package:aplikacja/features/Auth/pages/user_page.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Strona Startowa')),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const UserProfile()));
            },
            icon: const Icon(Icons.person_2),
          ),
        ],
      ),
    );
  }
}
