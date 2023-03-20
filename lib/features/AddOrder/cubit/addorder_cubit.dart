import 'package:aplikacja/repository/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'addorder_state.dart';

class AddOrderCubit extends Cubit<bool> {
  AddOrderCubit(this._repository) : super(false);

  final Repository _repository;

  Future<void> addOrder(String title, String description, String price) async {
    emit(false);
    try {
      await _repository.addOrder(title, description, price);
    } catch (e) {
      emit(false);
      throw Exception('Nie udało się dodać zlecenia: $e');
    }
  }
}
