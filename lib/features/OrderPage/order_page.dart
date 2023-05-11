import 'dart:async';

import 'package:skezik/features/OrderPage/cubit/order_cubit.dart';
import 'package:skezik/features/details/extras/extras_page.dart';
import 'package:skezik/model/model.dart';
import 'package:skezik/repository/repository.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../widgets/backgraound_gradient_black_red.dart';
import '../AddOrder/add_order.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderCubit(Repository())..start(),
      child: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          final models = state.documents;
          if (state.load) {
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
            // appBar: AppBar(
            //   title: const Text('Wystaw swoje zlecenie'),
            // ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AddOrderPage()));
              },
              child: const Icon(Icons.add_box),
            ),
            body: CustomPaint(
              painter: BackgroundGradientPainter(),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: ListView(
                    children: [
                      for (final model in models) ...[
                        Column(
                          children: [
                            Dismissible(
                              key: ValueKey(model.id),
                              onDismissed: (_) {
                                context.read<OrderCubit>().delete(model.id);
                              },
                              child: DocumentCont(model: model),
                            ),
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
              builder: (context) => ExtrasPage(id: widget.model.id)),
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
