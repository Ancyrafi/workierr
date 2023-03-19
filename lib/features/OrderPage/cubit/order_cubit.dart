import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit()
      : super(
          OrderState(
            documents: [],
            load: false,
          ),
        );

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    emit(
      OrderState(
        documents: [],
        load: true,
      ),
    );

    await Future.delayed(
      const Duration(seconds: 2),
    );

    _streamSubscription = FirebaseFirestore.instance
        .collection('users')
        .snapshots()
        .listen((data) {
      emit(
        OrderState(documents: data.docs, load: false),
      );
    })
      ..onError((error) {
        emit(
          OrderState(documents: [], load: true),
        );
      });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
