import 'package:aplikacja/features/Auth/pages/auth_gate.dart';
import 'package:aplikacja/widgets/backgraound_gradient_black_red.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileScreen(
      providerConfigs: const [
        EmailProviderConfiguration(),
      ],
      actions: [
        SignedOutAction((context) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const Auth(),
            ),
          );
        }),
      ],
      avatarSize: 24,
    );
  }
}

class User extends StatefulWidget {
  const User({super.key});

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomPaint(
      painter: BackgroundGradientPainter(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [],
      ),
    ));
  }
}
