import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit()
      : super(
          OrderState(
            price: '',
            title: '',
            description: '',
            load: false,
          ),
        );

  Future<void> start() async {
    emit(
      OrderState(
        title: '',
        description: '',
        price: '',
        load: true,
      ),
    );

    await Future.delayed(
      const Duration(seconds: 3),
    );

    emit(
      OrderState(title: '', description: '', price: '', load: false),
    );
  }
}
