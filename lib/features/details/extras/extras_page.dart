import 'dart:async';

import 'package:aplikacja/model/model.dart';
import 'package:aplikacja/repository/repository.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../widgets/backgraound_gradient_black_red.dart';
import '../../EditOrder/editorder.dart';
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
                          DocumentCont(models: item, id: id),
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

class DocumentCont extends StatefulWidget {
  const DocumentCont({
    super.key,
    required this.models,
    required this.id,
  });

  final Model models;
  final String id;

  @override
  State<DocumentCont> createState() => _DocumentContState();
}

class _DocumentContState extends State<DocumentCont> {
  void timerr() {
    final remainingDuration =
        widget.models.deleteTimestamp.difference(DateTime.now());

    if (remainingDuration.isNegative) {
      _timeLeft = '00:00:00';
    }

    final formatter = NumberFormat("00");

    final hours = remainingDuration.inHours.remainder(60);
    final minutes = remainingDuration.inMinutes.remainder(60);
    final seconds = remainingDuration.inSeconds.remainder(60);

    _timeLeft =
        '${formatter.format(hours)}:${formatter.format(minutes)}:${formatter.format(seconds)}';
  }

  String _timeLeft = '00:00:00';

  Timer? _countDown;

  @override
  void initState() {
    super.initState();
    _countDown = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        timerr();
      });
    });
  }

  @override
  void dispose() {
    _countDown?.cancel();
    super.dispose();
  }

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
                widget.models.title,
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
                widget.models.description,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Adres: ${widget.models.fullDescription}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Numer telefonu: ${widget.models.phoneNumber}',
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
                        widget.models.adress,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) =>
                              EditOrderPage(id: widget.id))));
                    },
                    child: const Text('Edytuj'),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text('Pozostały czas do końca zlecenia'),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(_timeLeft)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
