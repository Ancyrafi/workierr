import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/model.dart';

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
      final model = data.docs.map((doc) {
        return Model(
          title: doc['title'],
          description: doc['description'],
          price: doc['price'],
          id: doc['id'],
        );
      }).toList();
      emit(
        OrderState(documents: model, load: false),
      );
    })
      ..onError((error) {
        emit(
          OrderState(documents: [], load: true),
        );
      });
  }

  Future<void> delete(String id) async {
    FirebaseFirestore.instance.collection('users').doc(id).delete();
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
