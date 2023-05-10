import 'package:aplikacja/features/Auth/pages/auth_gate.dart';
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
