import 'dart:async';

import 'package:skezik/repository/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/model.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit(this._repository)
      : super(
          OrderState(
            documents: [],
            load: false,
          ),
        );
  final Repository _repository;

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    emit(
      OrderState(
        documents: [],
        load: true,
      ),
    );

    _streamSubscription = _repository.getModel().listen((model) {
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
    try {
      await _repository.delete(id: id);
    } catch (error) {
      emit(
        OrderState(documents: [], load: true),
      );
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
