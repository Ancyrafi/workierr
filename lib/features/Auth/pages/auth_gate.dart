import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import '../../../widgets/backgraound_gradient_black_red.dart';
import '../../../widgets/textfield.dart';
import '../../Home/home.dart';

// class AuthGate extends StatelessWidget {
//   const AuthGate({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<User?>(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       // If the user is already signed-in, use it as initial data
//       initialData: FirebaseAuth.instance.currentUser,
//       builder: (context, snapshot) {
//         // User is not signed in
//         if (!snapshot.hasData) {
//           return const SignInScreen(providerConfigs: [
//             EmailProviderConfiguration(),
//           ]);
//         }

//         // Render your application if authenticated
//         return const Home();
//       },
//     );
//   }
// }

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  final email = TextEditingController();
  final pass = TextEditingController();
  final confirmPass = TextEditingController();
  bool check = true;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            body: CustomPaint(
              painter: BackgroundGradientPainter(),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildTextField(
                        visible: false,
                        controller: email,
                        hintText: 'E-mail',
                        labelText: 'Wpisz Adres E-mail'),
                    buildTextField(
                        visible: true,
                        controller: pass,
                        hintText: 'Hasło',
                        labelText: 'Wprowadź swoj hasło...'),
                    if (check == false)
                      buildTextField(
                          visible: true,
                          controller: confirmPass,
                          hintText: 'Potwierdź hasło..',
                          labelText: 'Potwierdź hasło'),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(70, 50)),
                      onPressed: () async {
                        if (check) {
                          if (pass.text.isNotEmpty && email.text.isNotEmpty) {
                            try {
                              await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: email.text, password: pass.text);
                            } catch (error) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Błędny E-mail lub Hasło'),
                                  backgroundColor: Colors.black,
                                ),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Pola nie mogą być puste'),
                                backgroundColor: Colors.black,
                              ),
                            );
                          }
                        } else {
                          if (pass.text.isNotEmpty &&
                              email.text.isNotEmpty &&
                              confirmPass.text.isNotEmpty) {
                            if (pass.text == confirmPass.text) {
                              try {
                                await FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                        email: email.text, password: pass.text);
                              } catch (error) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Hasło powinno mieć minimum 6 znaków'),
                                  ),
                                );
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Hasło musi być takie samo w obu polach'),
                                  backgroundColor: Colors.black,
                                ),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Pola nie mogą być puste'),
                                backgroundColor: Colors.black,
                              ),
                            );
                          }
                        }
                      },
                      child: Text(check ? 'Zaloguj się' : 'Rejestracja'),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextButton(
                        style: TextButton.styleFrom(
                            minimumSize: const Size(70, 70)),
                        onPressed: () {
                          setState(() {
                            if (check) {
                              check = false;
                            } else {
                              check = true;
                            }
                          });
                        },
                        child: Text(
                          check ? 'Nie masz jeszcze konta?' : 'Zaloguj się',
                          style: const TextStyle(color: Colors.white),
                        ))
                  ],
                ),
              ),
            ),
          );
        }
        return const Home();
      },
    );
  }
}
