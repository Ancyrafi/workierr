import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/quest_cubit.dart';

class QuestPage extends StatefulWidget {
  const QuestPage({super.key});

  @override
  State<QuestPage> createState() => _QuestPageState();
}

class _QuestPageState extends State<QuestPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuestCubit(),
      child: BlocBuilder<QuestCubit, QuestState>(
        builder: (context, state) {
          return Scaffold(
            body: ListView(
              children: const [
                Center(
                  child: Text('Moje Zadania'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
