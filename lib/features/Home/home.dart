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
      body: Builder(builder: (context) {
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
              child: Text('Wybierz Czego szukasz'),
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
              child: const Text('Wystaw zlecenie'),
            ),
          ],
        );
      }),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (newIndex) {
          setState(() {
            index = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.plus_one),
            label: 'Guzik',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.plus_one),
            label: 'Guzik',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.plus_one),
            label: 'Guzik',
          ),
        ],
      ),
    );
  }
}
