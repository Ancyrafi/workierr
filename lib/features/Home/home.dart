import 'package:aplikacja/features/Auth/pages/user_page.dart';
import 'package:aplikacja/features/OrderPage/order_page.dart';
import 'package:aplikacja/features/QuestPage/quest_page.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Builder(builder: (context) {
          if (index == 2) {
            return const UserProfile();
          }
          if (index == 1) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const QuestPage()));
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 12.0),
                      textStyle: const TextStyle(fontSize: 18.0),
                    ),
                    child: const Text('Szukaj zlecenia'),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            );
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                child: Text(
                  'Wybierz Czego szukasz',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: ((context) => const OrderPage()),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 12.0),
                  textStyle: const TextStyle(fontSize: 18.0),
                ),
                child: const Text('Wystaw zlecenie'),
              ),
            ],
          );
        }),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (newIndex) {
          setState(() {
            index = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            activeIcon: Icon(
              Icons.add,
              color: Colors.blue,
              size: 30,
            ),
            label: 'Stwórz zlecenie',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            activeIcon: Icon(
              Icons.list_alt,
              color: Colors.blue,
              size: 30,
            ),
            label: 'Zlecenia',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            activeIcon: Icon(
              Icons.person,
              color: Colors.blue,
              size: 30,
            ),
            label: 'Moje Konto',
          ),
        ],
      ),
    );
  }
}
