import 'package:aplikacja/repository/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'addorder_state.dart';

class AddOrderCubit extends Cubit<bool> {
  AddOrderCubit(this._repository) : super(false);

  final Repository _repository;

  Future<void> addOrder({
    required String title,
    required String description,
    required String price,
    required String fullDescription,
    required String adress,
    required String phoneNumber,
    required int hours,

  }) async {
    emit(false);
    try {
      await _repository.addOrder(
          title: title,
          description: description,
          price: price,
          adress: adress,
          fullDescription: fullDescription,
          phoneNumber: phoneNumber,
          hours: hours);
    } catch (e) {
      emit(false);
      throw Exception('Nie udało się dodać zlecenia: $e');
    }
  }
}
