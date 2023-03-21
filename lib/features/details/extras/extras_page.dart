import 'package:aplikacja/model/model.dart';
import 'package:aplikacja/repository/repository.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/extras_cubit.dart';

class ExtrasPage extends StatelessWidget {
  const ExtrasPage({required this.id, Key? key}) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExtrasCubit(Repository())..extrapage(id),
      child: BlocBuilder<ExtrasCubit, ExtrasState>(
        builder: (context, state) {
          final item = state.page;
          if (item == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
            appBar: AppBar(
              title: const Text('Dokładne Informacje'),
            ),
            body: Padding(
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  models.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  models.description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
            Text(
              '${models.price} zł',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
