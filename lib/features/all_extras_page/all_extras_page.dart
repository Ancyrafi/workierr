import 'package:aplikacja/model/model.dart';
import 'package:aplikacja/repository/repository.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/backgraound_gradient_black_red.dart';
import 'cubit/allextras_cubit.dart';

class AllxtrasPage extends StatelessWidget {
  const AllxtrasPage({required this.id, required this.user, Key? key})
      : super(key: key);

  final String id;
  final String user;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AllextrasCubit(Repository())..allUser(id: id, user: user),
      child: BlocBuilder<AllextrasCubit, AllextrasState>(
        builder: (context, state) {
          final item = state.page;
          if (item == null) {
            return Scaffold(
                body: Stack(
              children: [
                Positioned.fill(
                  child: CustomPaint(
                    painter: BackgroundGradientPainter(),
                  ),
                ),
                const Center(
                  child: CircularProgressIndicator(),
                ),
              ],
            ));
          }
          return Scaffold(
            body: CustomPaint(
              painter: BackgroundGradientPainter(),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: ListView(
                    children: [
                      Column(
                        children: [
                          DocumentCont(models: item),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class DocumentCont extends StatelessWidget {
  const DocumentCont({
    super.key,
    required this.models,
  });

  final Model models;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 2.0,
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                models.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                models.description,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Adres: ${models.fullDescription}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Numer telefonu: ${models.phoneNumber}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 1.0,
                    ),
                  ],
                ),
                width: double.infinity,
                constraints: const BoxConstraints(minHeight: 100),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Pełny opis',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                      Text(
                        models.adress,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
