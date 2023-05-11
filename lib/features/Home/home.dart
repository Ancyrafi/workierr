import 'package:aplikacja/features/Auth/pages/auth_gate.dart';
import 'package:aplikacja/features/Auth/pages/user_page.dart';
import 'package:aplikacja/features/OrderPage/order_page.dart';
import 'package:aplikacja/features/QuestPage/quest_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../widgets/backgraound_gradient_black_red.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? userID = FirebaseAuth.instance.currentUser?.uid;
  var index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('aplikacja')),
        backgroundColor: Colors.black,
      ),
      body: CustomPaint(
        painter: BackgroundGradientPainter(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Builder(builder: (context) {
              if (index == 2) {
                if (userID == null) {
                  return const Auth();
                }
                return const Account();
              }
              if (index == 1) {
                if (userID == null) {
                  return const Auth();
                } else {
                  return const OrderPage();
                }
              }
              return const QuestPage();
            }),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        currentIndex: index,
        onTap: (newIndex) {
          setState(() {
            index = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.list_alt,
              color: Colors.red,
            ),
            activeIcon: Icon(
              Icons.list_alt,
              color: Colors.blue,
              size: 30,
            ),
            label: 'Zlecenia',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add,
              color: Colors.red,
            ),
            activeIcon: Icon(
              Icons.add,
              color: Colors.blue,
              size: 30,
            ),
            label: 'Stwórz zlecenie',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: Colors.red,
            ),
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
