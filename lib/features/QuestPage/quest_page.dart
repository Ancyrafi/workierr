import 'dart:async';

import 'package:aplikacja/model/model.dart';
import 'package:aplikacja/repository/repository.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../widgets/backgraound_gradient_black_red.dart';
import '../all_extras_page/all_extras_page.dart';
import 'cubit/quest_cubit.dart';

class QuestPage extends StatefulWidget {
  const QuestPage({Key? key}) : super(key: key);

  @override
  State<QuestPage> createState() => _QuestPageState();
}

class _QuestPageState extends State<QuestPage> {
  String? searchCity;
  bool search = false;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuestCubit(Repository())..start(),
      child: BlocBuilder<QuestCubit, QuestState>(
        builder: (context, state) {
          final models = state.documents;
          if (state.load) {
            return Scaffold(
                body: Stack(
              children: [
                Positioned.fill(
                  child: CustomPaint(painter: BackgroundGradientPainter()),
                ),
                const Center(
                  child: CircularProgressIndicator(),
                )
              ],
            ));
          }

          final filteredModels = models
              .where((model) => searchCity == null || searchCity!.isEmpty
                  ? true
                  : model.city
                      .toLowerCase()
                      .contains(searchCity!.toLowerCase()))
              .toList();
          return Scaffold(
            // appBar: AppBar(
            //   title: const Text('Aktualne zlecenia w pobliżu'),
            // ),
            body: CustomPaint(
              painter: BackgroundGradientPainter(),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: ListView(
                    children: [
                      Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                          onPressed: () {
                            if (search == false) {
                              setState(() {
                                search = true;
                              });
                            } else {
                              setState(() {
                                search = false;
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              minimumSize: const Size(25, 25)),
                          child: const Icon(
                            Icons.search,
                            size: 30,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (search == true)
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Wpisz miasto',
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              searchCity = value;
                            });
                          },
                        ),
                      const SizedBox(
                        height: 10,
                      ),
                      for (final model in filteredModels) ...[
                        Column(
                          children: [
                            DocumentCont(model: model),
                          ],
                        ),
                      ],
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
    required this.model,
  });

  final Model model;

  @override
  State<DocumentCont> createState() => _DocumentContState();
}

class _DocumentContState extends State<DocumentCont> {
  void timerr() {
    final remainingDuration =
        widget.model.deleteTimestamp.difference(DateTime.now());

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
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) =>
                  AllxtrasPage(id: widget.model.id, user: widget.model.userID)),
        );
      },
      child: Container(
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
                    widget.model.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.model.description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              Text(
                '${widget.model.price} zł',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
              Text(_timeLeft)
            ],
          ),
        ),
      ),
    );
  }
}
